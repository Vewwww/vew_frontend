part of 'chat_cubit.dart';

@immutable
abstract class ChatState {}

class ChatInitial extends ChatState {}

class MessageSentState extends ChatState {}
class GettingChatsLoadingState extends ChatState {}
class GettingChatsSuccessState extends ChatState {
  final List<Chat> chats ;
  GettingChatsSuccessState(this.chats);
}
class GettingChatsErrorState extends ChatState {}
