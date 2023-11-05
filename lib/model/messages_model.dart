// To parse this JSON data, do
//
//     final messagesModel = messagesModelFromJson(jsonString);

import 'dart:convert';

MessagesModel messagesModelFromJson(String str) => MessagesModel.fromJson(json.decode(str));

String messagesModelToJson(MessagesModel data) => json.encode(data.toJson());

class MessagesModel {
    List<Message>? messages;
    int? page;
    int? pageSize;
    int? total;
    int? totalPages;

    MessagesModel({
        this.messages,
        this.page,
        this.pageSize,
        this.total,
        this.totalPages,
    });

    factory MessagesModel.fromJson(Map<String, dynamic> json) => MessagesModel(
        messages: json["messages"] == null ? [] : List<Message>.from(json["messages"]!.map((x) => Message.fromJson(x))),
        page: json["page"],
        pageSize: json["pageSize"],
        total: json["total"],
        totalPages: json["totalPages"],
    );

    Map<String, dynamic> toJson() => {
        "messages": messages == null ? [] : List<dynamic>.from(messages!.map((x) => x.toJson())),
        "page": page,
        "pageSize": pageSize,
        "total": total,
        "totalPages": totalPages,
    };
}

class Message {
    String? id;
    String? sender;
    String? threadId;
    String? message;
    String? messageType;
    String? messageStatus;
    bool? isDeleted;
    int? createdAt;
    int? v;

    Message({
        this.id,
        this.sender,
        this.threadId,
        this.message,
        this.messageType,
        this.messageStatus,
        this.isDeleted,
        this.createdAt,
        this.v,
    });

    factory Message.fromJson(Map<String, dynamic> json) => Message(
        id: json["_id"],
        sender: json["sender"],
        threadId: json["thread_id"],
        message: json["message"],
        messageType: json["message_type"],
        messageStatus: json["message_status"],
        isDeleted: json["is_deleted"],
        createdAt: json["created_at"],
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "sender": sender,
        "thread_id": threadId,
        "message": message,
        "message_type": messageType,
        "message_status": messageStatus,
        "is_deleted": isDeleted,
        "created_at": createdAt,
        "__v": v,
    };
}
