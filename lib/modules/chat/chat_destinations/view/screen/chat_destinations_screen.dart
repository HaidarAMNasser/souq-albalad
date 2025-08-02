import 'package:souq_al_balad/global/components/app_loader.dart';
import 'package:souq_al_balad/global/endpoints/core/enum/state_enum.dart';
import 'package:souq_al_balad/global/localization/app_localization.dart';
import 'package:souq_al_balad/modules/chat/chat_destinations/bloc/chats_dest_bloc.dart';
import 'package:souq_al_balad/modules/chat/chat_destinations/bloc/chats_dest_event.dart';
import 'package:souq_al_balad/modules/chat/chat_destinations/bloc/chats_dest_states.dart';
import 'package:souq_al_balad/modules/chat/chat_destinations/view/widget/chat_contact_widget.dart';
import 'package:souq_al_balad/modules/chat/chats_page/view/screen/chats_page_screen.dart';
import 'package:flutter/material.dart';
import 'package:souq_al_balad/global/utils/color_app.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
              color:
                  isDark
                      ? AppColors.darkTextPrimary
                      : AppColors.lightTextPrimary,
            ),
          ),
          centerTitle: true,
        ),
        body: Column(
          children: [
            SizedBox(height: 16.h),
            BlocBuilder<ChatDestBloc, ChatDestState>(
              builder: (context, state) {
                if (state.chatDestState == StateEnum.loading) {
                  return AppLoader();
                }
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: state.chats!.length,
                  itemBuilder: (context, i) {
                    return ChatContactWidget(
                      contactName: state.chats![i].otherUser!.name!,
                      lastMessage: state.chats![i].latestMessage!.message!,
                      time: state.chats![i].latestMessage!.createdAt!,
                      imagePath: '',
                      unreadCount: state.chats![i].unseenCount!,
                      onTap: () {
                        /* Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ChatsPageScreen(
                              contactName: 'Ahmad',
                              contactImage: 'assets/images/on1.png',
                            ),
                          ),
                        );*/
                      },
                    );
                  },
                );
              },
            ),
            SizedBox(height: 16.h),
          ],
        ),
      ),
    );
  }
}
