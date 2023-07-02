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
        chats!.add(new Chat.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['newChats'] = this.newChats;
    data['result'] = this.result;
    if (this.chats != null) {
      data['data'] = this.chats!.map((v) => v.toJson()).toList();
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
    print("object");
    room = json['room'];
    print("object1");
    participants = json['participants'].cast<String>();
    print("object2");
    if (json['messages'] != null) {
      messages = <Messages>[];
      json['messages'].forEach((v) {
        messages!.add(new Messages.fromJson(v));
      });
    }
    print("object3");
    iV = json['__v'];
    chatName = json['chatName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['room'] = this.room;
    data['participants'] = this.participants;
    if (this.messages != null) {
      data['messages'] = this.messages!.map((v) => v.toJson()).toList();
    }
    data['__v'] = this.iV;
    data['chatName'] = this.chatName;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sender'] = this.sender;
    data['content'] = this.content;
    data['time'] = this.time;
    data['seen'] = this.seen;
    data['_id'] = this.sId;
    return data;
  }
}
