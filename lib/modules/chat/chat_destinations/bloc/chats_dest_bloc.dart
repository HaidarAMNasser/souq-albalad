import 'package:souq_al_balad/global/data/local/cache_helper.dart';
import 'package:souq_al_balad/global/endpoints/chat/chatApi.dart';
import 'package:souq_al_balad/global/endpoints/chat/models/chat_model.dart';
import 'package:souq_al_balad/global/endpoints/core/enum/state_enum.dart'
    show StateEnum;
import 'package:souq_al_balad/global/endpoints/logout/logoutApi.dart';
import 'package:souq_al_balad/global/endpoints/models/message_model.dart';
import 'package:souq_al_balad/global/endpoints/models/result_class.dart';
import 'package:souq_al_balad/modules/auth/log_in/view/screen/log_in_screen.dart';
import 'package:souq_al_balad/modules/chat/chat_destinations/bloc/chats_dest_event.dart';
import 'package:souq_al_balad/modules/chat/chat_destinations/bloc/chats_dest_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart' show Bloc, Emitter;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class ChatDestBloc extends Bloc<ChatDestEvents, ChatDestState> {
  ChatDestBloc() : super(ChatDestState()) {
    on<GetChatsEvent>(_getChatsEvent);
  }

  void _getChatsEvent(ChatDestEvents event, Emitter<ChatDestState> emit) async {
    emit(state.copyWith(chatDestState: StateEnum.loading));
    ResponseState<MessageModel> response = await ChatApi().getChats();
    if (response is SuccessState) {
      SuccessState<MessageModel> res = response as SuccessState<MessageModel>;
      if (res.data.success) {
        List<ChatModel> chats = [];
        for (var i = 0; i < res.data.result.length; i++) {
          ChatModel chat = ChatModel.fromJson(res.data.result[i]);
          chats.add(chat);
        }
        emit(state.copyWith(chatDestState: StateEnum.Success, chats: chats));
      } else {
        emit(state.copyWith(errorMessage: res.data.message));
        Fluttertoast.showToast(msg: res.data.message);
      }
    } else if (response is ErrorState) {
      ErrorState<MessageModel> res = response as ErrorState<MessageModel>;
      Fluttertoast.showToast(msg: res.errorMessage.error!.message);
      emit(state.copyWith(chatDestState: StateEnum.start));
    }
  }
}
