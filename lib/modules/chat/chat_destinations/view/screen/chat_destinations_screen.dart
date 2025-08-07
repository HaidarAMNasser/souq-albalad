import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// IMPORTANT: Add this import to access your local storage
import 'package:souq_al_balad/global/data/local/cache_helper.dart';

import 'package:souq_al_balad/global/components/app_loader.dart';
import 'package:souq_al_balad/global/endpoints/core/enum/state_enum.dart';
import 'package:souq_al_balad/global/endpoints/url_api.dart';
import 'package:souq_al_balad/global/localization/app_localization.dart';
import 'package:souq_al_balad/global/utils/color_app.dart';
import 'package:souq_al_balad/modules/chat/chat_destinations/bloc/chats_dest_bloc.dart';
import 'package:souq_al_balad/modules/chat/chat_destinations/bloc/chats_dest_event.dart';
import 'package:souq_al_balad/modules/chat/chat_destinations/bloc/chats_dest_states.dart';
import 'package:souq_al_balad/modules/chat/chat_destinations/view/widget/chat_contact_widget.dart';
import 'package:souq_al_balad/modules/chat/chats_page/view/screen/chats_page_screen.dart';

class ChatDestinationsScreen extends StatefulWidget {
  const ChatDestinationsScreen({super.key});

  @override
  State<ChatDestinationsScreen> createState() => _ChatDestinationsScreenState();
}

class _ChatDestinationsScreenState extends State<ChatDestinationsScreen> {
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return BlocProvider(
      create: (context) => ChatDestBloc()..add(GetChatsEvent(context)),
      child: Scaffold(
        backgroundColor:
            isDark ? AppColors.darkBackground : AppColors.lightBackground,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: AppColors.primary),
            onPressed: () => Navigator.pop(context),
          ),
          title: Text(
            AppLocalization.of(context).translate("the_messages"),
            style: TextStyle(
              fontFamily: 'Montserrat',
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: isDark
                  ? AppColors.darkTextPrimary
                  : AppColors.lightTextPrimary,
            ),
          ),
          centerTitle: true,
        ),
        body: Column(
          children: [
            SizedBox(height: 16.h),
            Expanded(
              child: BlocBuilder<ChatDestBloc, ChatDestState>(
                builder: (context, state) {
                  if (state.chatDestState == StateEnum.loading) {
                    return const Center(child: AppLoader());
                  }
                  if (state.chats == null || state.chats!.isEmpty) {
                    return Center(
                      child: Text(
                        AppLocalization.of(context).translate("no_messages"),
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 16,
                          color: isDark
                              ? AppColors.darkTextSecondary
                              : AppColors.lightTextSecondary,
                        ),
                      ),
                    );
                  }
                  return ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    itemCount: state.chats!.length,
                    itemBuilder: (context, i) {
                      final chat = state.chats![i];

                      final String? imagePath =
                          chat.otherUser?.logoPathFromServer;
                      String? fullImageUrl;
                      if (imagePath != null && imagePath.isNotEmpty) {
                        fullImageUrl = imagePath.startsWith('http')
                            ? imagePath
                            : BASE_URL + imagePath;
                      }

                      return ChatContactWidget(
                        contactName: chat.otherUser?.name ?? 'Unknown',
                        lastMessage: chat.latestMessage?.message ?? '',
                        time: chat.latestMessage?.createdAt ?? '',
                        imageUrl: fullImageUrl,
                        unreadCount: chat.unseenCount ?? 0,
                        onTap: () {
                          final int currentUserId = CacheHelper.getUserId();

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ChatsPageScreen(
                                chat: chat,
                                currentUserId: currentUserId,
                              ),
                            ),
                          );
                        },
                      );
                    },
                  );
                },
              ),
            ),
            SizedBox(height: 16.h),
          ],
        ),
      ),
    );
  }
}
