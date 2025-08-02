import 'package:souq_al_balad/global/components/app_loader.dart';
import 'package:souq_al_balad/global/data/local/cache_helper.dart';
import 'package:souq_al_balad/global/endpoints/chat/models/chat_model.dart';
import 'package:souq_al_balad/global/endpoints/chat/models/message_model.dart';
import 'package:souq_al_balad/global/endpoints/core/enum/state_enum.dart';
import 'package:souq_al_balad/global/localization/app_localization.dart';
import 'package:souq_al_balad/modules/chat/chats_page/bloc/chats_bloc.dart';
import 'package:souq_al_balad/modules/chat/chats_page/bloc/chats_event.dart';
import 'package:souq_al_balad/modules/chat/chats_page/bloc/chats_states.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:souq_al_balad/global/utils/color_app.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';

class ChatsPageScreen extends StatefulWidget {
  ChatModel chat;

  ChatsPageScreen({super.key, required this.chat});

  @override
  State<ChatsPageScreen> createState() => _ChatsPageScreenState();
}

PusherChannelsFlutter pusher = PusherChannelsFlutter();
late int currentUserId;
late final ChatBloc bloc;

class _ChatsPageScreenState extends State<ChatsPageScreen> {
  @override
  void initState() {
    initPusher();
    currentUserId = CacheHelper.getData(key: 'userId');
    super.initState();
  }

  final TextEditingController _messageController = TextEditingController();
  Future<void> initPusher() async {
    try {
      await pusher.init(
        apiKey: "532366136982ea627331",
        cluster: "mt1",
        onConnectionStateChange: (currentState, previousState) {
          print("Connection state: $currentState");
        },
        onError: (message, code, error) {
          print("Error: $message");
        },
      );

      await pusher.subscribe(
        channelName: "chat.${widget.chat.chatId!}",
        onEvent: (event) {
          print("Received event: ${event.eventName}");
          print("Data: ${event.data}");
          //bloc.add(event)
        },
        onSubscriptionSucceeded: () {
          print("Subscribtion succeded");
        },
      );

      await pusher.connect();
    } catch (e) {
      print("Pusher init error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return BlocProvider(
      create:
          (context) =>
              ChatBloc()
                ..add(GetChatMessagesEvent(widget.chat.chatId!, context)),
      child: Scaffold(
        backgroundColor:
            isDark ? AppColors.darkBackground : AppColors.lightBackground,
        appBar: _buildAppBar(isDark),
        body: Column(
          children: [
            BlocBuilder<ChatBloc, ChatState>(
              builder: (context, state) {
                if (state.chatState == StateEnum.loading) {
                  return AppLoader();
                }
                return Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    itemCount: state.chatMessages!.length,
                    itemBuilder: (context, index) {
                      return _buildMessageItem(
                        state.chatMessages![index],
                        isDark,
                      );
                    },
                  ),
                );
              },
            ),
            _buildMessageInput(isDark),
          ],
        ),
      ),
    );
  }

  AppBar _buildAppBar(bool isDark) {
    return AppBar(
      backgroundColor: isDark ? AppColors.darkSurface : AppColors.lightSurface,
      elevation: 0,
      leading: IconButton(
        icon: Icon(Icons.arrow_back, color: AppColors.primary),
        onPressed: () => Navigator.pop(context),
      ),
      title: Row(
        textDirection: TextDirection.rtl,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40.w,
            height: 40.h,
            decoration: BoxDecoration(shape: BoxShape.circle),
            child: CachedNetworkImage(
              imageUrl: '', //widget.chat.otherUser.image,
              fit: BoxFit.cover,
              progressIndicatorBuilder: (context, child, loadingProgress) {
                return const Center(child: CircularProgressIndicator());
              },
              errorWidget: (context, error, stackTrace) {
                return Icon(Icons.person, size: 24, color: Colors.white);
              },
            ),
          ),
          const SizedBox(width: 12),
          Text(
            widget.chat.otherUser!.name!,
            style: TextStyle(
              fontFamily: 'Montserrat',
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color:
                  isDark
                      ? AppColors.darkTextPrimary
                      : AppColors.lightTextPrimary,
            ),
          ),
        ],
      ),
      centerTitle: true,
    );
  }

  Widget _buildMessageItem(ChatMessageModel message, bool isDark) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        textDirection:
            message.senderId == currentUserId
                ? TextDirection.ltr
                : TextDirection.rtl,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (message.senderId != currentUserId) ...[
            Container(
              width: 32.w,
              height: 32.h,
              decoration: BoxDecoration(shape: BoxShape.circle),
              child: CachedNetworkImage(
                imageUrl: '',
                fit: BoxFit.cover,
                progressIndicatorBuilder: (context, child, loadingProgress) {
                  return const Center(child: CircularProgressIndicator());
                },
                errorWidget: (context, error, stackTrace) {
                  return Icon(Icons.person, size: 18, color: Colors.white);
                },
              ),
            ),
            SizedBox(width: 8.h),
          ],
          Flexible(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color:
                    message.senderId == currentUserId
                        ? AppColors.primary
                        : (isDark
                            ? AppColors.darkCardBackground
                            : Colors.white),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 4,
                    offset: const Offset(0, 1),
                  ),
                ],
              ),
              child: Text(
                message.message!,
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 14,
                  color:
                      message.senderId == currentUserId
                          ? Colors.white
                          : (isDark
                              ? AppColors.darkTextPrimary
                              : AppColors.lightTextPrimary),
                ),
                textDirection: TextDirection.rtl,
              ),
            ),
          ),
          if (message.senderId == currentUserId) ...[
            SizedBox(width: 8.w),
            Container(
              width: 32.w,
              height: 32.h,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFFB8C5D6),
              ),
              child: const Icon(Icons.person, color: Colors.white, size: 18),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildMessageInput(bool isDark) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkSurface : AppColors.lightSurface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, -1),
          ),
        ],
      ),
      child: Row(
        textDirection: TextDirection.rtl,
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: isDark ? AppColors.darkCardBackground : Colors.white,
                borderRadius: BorderRadius.circular(25),
                border: Border.all(
                  color: isDark ? AppColors.grey700 : AppColors.grey300,
                ),
              ),
              child: TextField(
                controller: _messageController,
                textDirection: TextDirection.rtl,
                decoration: InputDecoration(
                  hintText:
                      '${AppLocalization.of(context).translate("write_a_message")}...',
                  hintStyle: TextStyle(
                    fontFamily: 'Montserrat',
                    color:
                        isDark
                            ? AppColors.darkTextSecondary
                            : AppColors.lightTextSecondary,
                  ),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                ),
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  color:
                      isDark
                          ? AppColors.darkTextPrimary
                          : AppColors.lightTextPrimary,
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          GestureDetector(
            onTap: () {
              bloc.add(
                AddMessageToListEvent(
                  ChatMessageModel(
                    chatId: widget.chat.chatId,
                    createdAt: DateTime.now().toString(),
                    message: _messageController.text,
                    senderId: currentUserId,
                  ),
                  context,
                ),
              );
            },
            child: Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: AppColors.primary,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.send, color: Colors.white, size: 24),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }
}

class ChatMessage {
  final String text;
  final bool isSentByMe;
  final DateTime timestamp;

  ChatMessage({
    required this.text,
    required this.isSentByMe,
    required this.timestamp,
  });
}
