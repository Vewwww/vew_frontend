class ChatResponse {
  bool? newChats;
  int? result;
  List<Chat>? chats;

  ChatResponse({this.newChats, this.result, this.chats});

  ChatResponse.fromJson(Map<String, dynamic> json) {
    newChats = json['newChats'];
    result = json['result'];
    if (json['data'] != null) {
      chats = <Chat>[];
      json['data'].forEach((v) {
        chats!.add(Chat.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['newChats'] = newChats;
    data['result'] = result;
    if (chats != null) {
      data['data'] = chats!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Chat {
  String? sId;
  String? room;
  List<String>? participants;
  List<Messages>? messages;
  int? iV;
  String? chatName;

  Chat(
      {this.sId,
      this.room,
      this.participants,
      this.messages,
      this.iV,
      this.chatName});

  Chat.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    room = json['room'];
    participants = json['participants'].cast<String>();
    if (json['messages'] != null) {
      messages = <Messages>[];
      json['messages'].forEach((v) {
        messages!.add(Messages.fromJson(v));
      });
    }
    iV = json['__v'];
    chatName = json['chatName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['room'] = room;
    data['participants'] = participants;
    if (messages != null) {
      data['messages'] = messages!.map((v) => v.toJson()).toList();
    }
    data['__v'] = iV;
    data['chatName'] = chatName;
    return data;
  }
}

class Messages {
  String? sender;
  String? content;
  String? time;
  bool? seen;
  String? sId;

  Messages({this.sender, this.content, this.time, this.seen, this.sId});

  Messages.fromJson(Map<String, dynamic> json) {
    sender = json['sender'];
    content = json['content'];
    time = json['time'];
    seen = json['seen'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['sender'] = sender;
    data['content'] = content;
    data['time'] = time;
    data['seen'] = seen;
    data['_id'] = sId;
    return data;
  }
}
