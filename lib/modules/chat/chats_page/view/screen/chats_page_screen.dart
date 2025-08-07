import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:souq_al_balad/global/components/app_loader.dart';
import 'package:souq_al_balad/global/endpoints/chat/models/chat_model.dart';
import 'package:souq_al_balad/global/endpoints/chat/models/message_model.dart';
import 'package:souq_al_balad/global/endpoints/core/enum/state_enum.dart';
import 'package:souq_al_balad/global/endpoints/url_api.dart';
import 'package:souq_al_balad/global/localization/app_localization.dart';
import 'package:souq_al_balad/global/utils/color_app.dart';
import 'package:souq_al_balad/modules/chat/chats_page/bloc/chats_bloc.dart';
import 'package:souq_al_balad/modules/chat/chats_page/bloc/chats_event.dart';
import 'package:souq_al_balad/modules/chat/chats_page/bloc/chats_states.dart';

class ChatsPageScreen extends StatefulWidget {
  final ChatModel chat;
  final int currentUserId;

  const ChatsPageScreen({
    super.key,
    required this.chat,
    required this.currentUserId,
  });

  @override
  State<ChatsPageScreen> createState() => _ChatsPageScreenState();
}

class _ChatsPageScreenState extends State<ChatsPageScreen> {
  final PusherChannelsFlutter pusher = PusherChannelsFlutter();

  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  late final ChatBloc _chatBloc;

  @override
  void initState() {
    super.initState();
    _chatBloc = ChatBloc();
    _chatBloc.add(GetChatMessagesEvent(widget.chat.chatId ?? 0, context));

    // FIX #2: THE UNRELIABLE INITIALIZATION IS GONE.
    // We will now ONLY use `widget.currentUserId`.
    initPusher();
  }

  Future<void> initPusher() async {
    if (widget.chat.chatId == null) return;
    try {
      await pusher.init(
        apiKey: "532366136982ea627331",
        cluster: "mt1",
        onConnectionStateChange: (currentState, previousState) {
          debugPrint("Pusher Connection: $currentState");
        },
        onError: (message, code, error) {
          debugPrint("Pusher Error: $message, code: $code, error: $error");
        },
      );
      await pusher.subscribe(
        channelName: "chat.${widget.chat.chatId}",
        onEvent: (event) {
          debugPrint(
              "Received Pusher event. Raw Data: ${jsonEncode(event.data)}");
          try {
            final Map<String, dynamic> dataMap =
                Map<String, dynamic>.from(event.data);
            if (dataMap.containsKey('result') && dataMap['result'] is Map) {
              final Map<String, dynamic> messagePayload =
                  Map<String, dynamic>.from(dataMap['result']);
              final messageData = ChatMessageModel.fromJson(messagePayload);
              _chatBloc.add(AddMessageToListEvent(messageData, context));
            } else {
              debugPrint(
                  "Pusher event received, but 'result' key was missing or not a map.");
            }
          } catch (e, stackTrace) {
            debugPrint("CRITICAL ERROR parsing pusher message: $e");
            debugPrint("Stack trace: $stackTrace");
          }
        },
      );
      await pusher.connect();
    } catch (e) {
      debugPrint("Pusher init error: $e");
    }
  }

  @override
  void dispose() {
    if (widget.chat.chatId != null) {
      pusher.unsubscribe(channelName: "chat.${widget.chat.chatId}");
    }
    _chatBloc.close();
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _sendMessage() {
    final messageText = _messageController.text.trim();
    if (messageText.isEmpty || widget.chat.chatId == null) {
      return;
    }

    _chatBloc.add(
      SendMessageEvent(
        chatId: widget.chat.chatId!,
        message: messageText,
      ),
    );

    _chatBloc.add(
      AddMessageToListEvent(
        ChatMessageModel(
          chatId: widget.chat.chatId,
          createdAt: DateTime.now().toIso8601String(),
          message: messageText,
          senderId: widget.currentUserId,
        ),
        context,
      ),
    );

    _messageController.clear();
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  String _formatMessageTime(String isoString) {
    if (isoString.isEmpty) return '';
    try {
      final DateTime dateTime = DateTime.parse(isoString);
      return DateFormat.jm().format(dateTime);
    } catch (e) {
      return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return BlocProvider.value(
      value: _chatBloc,
      child: Scaffold(
        backgroundColor:
            isDark ? AppColors.darkBackground : AppColors.lightBackground,
        appBar: _buildAppBar(isDark),
        body: Column(
          children: [
            Expanded(
              child: BlocConsumer<ChatBloc, ChatState>(
                listener: (context, state) {
                  if (state.chatState == StateEnum.Success) {
                    WidgetsBinding.instance
                        .addPostFrameCallback((_) => _scrollToBottom());
                  }
                },
                builder: (context, state) {
                  if (state.chatState == StateEnum.loading &&
                      (state.chatMessages?.isEmpty ?? true)) {
                    return const Center(child: AppLoader());
                  }
                  if (state.chatMessages?.isEmpty ?? true) {
                    return Center(
                        child: Text(AppLocalization.of(context)
                            .translate("no_messages")));
                  }
                  return ListView.builder(
                    controller: _scrollController,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    itemCount: state.chatMessages!.length,
                    itemBuilder: (context, index) {
                      return _buildMessageItem(
                          state.chatMessages![index], isDark);
                    },
                  );
                },
              ),
            ),
            _buildMessageInput(isDark),
          ],
        ),
      ),
    );
  }

  AppBar _buildAppBar(bool isDark) {
    final String? imagePath = widget.chat.otherUser?.logoPathFromServer;
    String? fullImageUrl;
    if (imagePath != null && imagePath.isNotEmpty) {
      fullImageUrl =
          imagePath.startsWith('http') ? imagePath : BASE_URL + imagePath;
    }

    return AppBar(
      backgroundColor: isDark ? AppColors.darkSurface : AppColors.lightSurface,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: AppColors.primary),
        onPressed: () => Navigator.pop(context),
      ),
      title: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 40.w,
            height: 40.h,
            child: ClipOval(
              child: (fullImageUrl != null)
                  ? CachedNetworkImage(
                      imageUrl: fullImageUrl,
                      fit: BoxFit.cover,
                      progressIndicatorBuilder: (context, url, progress) =>
                          const Center(child: CircularProgressIndicator()),
                      errorWidget: (context, url, error) => const Icon(
                          Icons.person,
                          size: 24,
                          color: Colors.grey),
                    )
                  : const Icon(Icons.person, size: 24, color: Colors.grey),
            ),
          ),
          const SizedBox(width: 12),
          Flexible(
            child: Text(
              widget.chat.otherUser?.name ?? 'Unknown User',
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontFamily: 'Montserrat',
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: isDark
                    ? AppColors.darkTextPrimary
                    : AppColors.lightTextPrimary,
              ),
            ),
          ),
        ],
      ),
      centerTitle: true,
    );
  }

  Widget _buildMessageItem(ChatMessageModel message, bool isDark) {
    print('--- DEBUG ---');
    print(
        'Comparing message sender ID: ${message.senderId} (type: ${message.senderId.runtimeType})');
    print(
        'With current user ID: ${widget.currentUserId} (type: ${widget.currentUserId.runtimeType})');
    print('--- END DEBUG ---');

    final bool isSentByMe = message.senderId == widget.currentUserId;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Column(
        crossAxisAlignment:
            isSentByMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment:
                isSentByMe ? MainAxisAlignment.end : MainAxisAlignment.start,
            children: [
              Flexible(
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    color: isSentByMe
                        ? AppColors.primary
                        : (isDark
                            ? AppColors.darkCardBackground
                            : Colors.white),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    message.message ?? '',
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 14,
                      color: isSentByMe
                          ? Colors.white
                          : (isDark
                              ? AppColors.darkTextPrimary
                              : AppColors.lightTextPrimary),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 4.0, left: 10, right: 10),
            child: Text(
              _formatMessageTime(message.createdAt ?? ''),
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessageInput(bool isDark) {
    return Container(
      padding: const EdgeInsets.all(16),
      color: isDark ? AppColors.darkSurface : AppColors.lightSurface,
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _messageController,
              decoration: InputDecoration(
                hintText:
                    '${AppLocalization.of(context).translate("write_a_message")}...',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: BorderSide.none),
                filled: true,
                fillColor: isDark
                    ? AppColors.darkCardBackground
                    : AppColors.lightBackground,
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              ),
            ),
          ),
          const SizedBox(width: 8),
          GestureDetector(
            onTap: _sendMessage,
            child: Container(
              width: 48,
              height: 48,
              decoration: const BoxDecoration(
                  color: AppColors.primary, shape: BoxShape.circle),
              child: const Icon(Icons.send, color: Colors.white, size: 24),
            ),
          ),
        ],
      ),
    );
  }
}
