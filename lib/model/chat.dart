class ChatModel {
  String sender;
  List<MessageModel> messages;
  ChatModel({required this.sender, required this.messages});
}

class MessageModel {
  String sender;
  String message;
  String date;
  MessageModel(
      {required this.sender, required this.message, required this.date});
}

List<ChatModel> chats = [
  ChatModel(
    messages: [
      MessageModel(sender: "me", message: "hello", date: "10:05 today"),
      MessageModel(sender: "me", message: "where are you", date: "10:55 today"),
      MessageModel(
          sender: "Ahmed Nader",
          message: "I'm 5 minues far",
          date: "10:58 today"),
      MessageModel(
          sender: "me", message: "thank you for help", date: "11:30 today"),
    ],
    sender: "Ahmed Nader",
  ),
  ChatModel(
    messages: [
      MessageModel(sender: "me", message: "hi", date: "10:05 today"),
      MessageModel(sender: "Shimaa Yossef", message: "hi", date: "10:06 today"),
      MessageModel(
          sender: "me", message: "is the location clear?", date: "10:10 today"),
      MessageModel(
          sender: "Shimaa Yossef",
          message: "yes, i'm on my way",
          date: "10:30 today"),
    ],
    sender: "Shimaa Yossef",
  ),
];
