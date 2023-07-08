import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:vewww/model/chat.dart';
import 'package:vewww/services/dio_helper.dart';
import '../../core/utils/sp_helper/cache_helper.dart';
part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());
  static ChatCubit get(context) => BlocProvider.of(context);
  ChatResponse? chatResponse;
  Chat? chat;

  // get message when recieving a new message event from server socket
  void reciveMessage(Map<String, dynamic> json, Chat chat) {
    Messages message = Messages.fromJson(json);
    if (chat != null) {
      chat.messages!.add(message);
      if (SharedPreferencesHelper.getData(key: "vewRole") == "winch") {
        getWinchChats();
      }
      if (SharedPreferencesHelper.getData(key: "vewRole") == "user") {
        getDriverChats();
      }
      if (SharedPreferencesHelper.getData(key: "vewRole") == "mechanic") {
        getMechanicChats();
      }
      emit(MessageSentState());
    }
  }

  void setchat(Chat chat) {
    this.chat = chat;
  }

  Future<void> getWinchChats() async {
    emit(GettingChatsLoadingState());
    await DioHelper.getData(
      url: "/winch/chat/",
      token: SharedPreferencesHelper.getData(key: 'vewToken'),
    ).then((value) {
      chatResponse = ChatResponse.fromJson(value.data);
      emit(GettingChatsSuccessState(chatResponse!.chats!));
    }).catchError((err) {
      if (err is DioError) {
      }
      emit(GettingChatsErrorState());
    });
  }

  Future<void> getDriverChats() async {
    emit(GettingChatsLoadingState());
    await DioHelper.getData(
      url: "/driver/chat/",
      token: SharedPreferencesHelper.getData(key: 'vewToken'),
    ).then((value) {
      chatResponse = ChatResponse.fromJson(value.data);
      emit(GettingChatsSuccessState(chatResponse!.chats!));
    }).catchError((err) {
      if (err is DioError) {
      }
      emit(GettingChatsErrorState());
    });
  }

  Future<void> getMechanicChats() async {
    emit(GettingChatsLoadingState());
    await DioHelper.getData(
      url: "/mechanic/chat/",
      token: SharedPreferencesHelper.getData(key: 'vewToken'),
    ).then((value) {
      chatResponse = ChatResponse.fromJson(value.data);
      emit(GettingChatsSuccessState(chatResponse!.chats!));
    }).catchError((err) {
      if (err is DioError) {
      }
      emit(GettingChatsErrorState());
    });
  }
}
