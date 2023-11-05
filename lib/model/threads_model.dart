// To parse this JSON data, do
//
//     final threadsModel = threadsModelFromJson(jsonString);

import 'dart:convert';

List<ThreadsModel> threadsModelFromJson(String str) => List<ThreadsModel>.from(json.decode(str).map((x) => ThreadsModel.fromJson(x)));

String threadsModelToJson(List<ThreadsModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ThreadsModel {
    String? id;
    List<String>? participants;
    String? lastMessage;
    int? unreadMessages;
    String? unreadMessagesSender;
    int? createdAt;
    int? updatedAt;
    int? v;
    int? lastMessageUnix;
    Reciever? reciever;

    ThreadsModel({
        this.id,
        this.participants,
        this.lastMessage,
        this.unreadMessages,
        this.unreadMessagesSender,
        this.createdAt,
        this.updatedAt,
        this.v,
        this.lastMessageUnix,
        this.reciever,
    });

    factory ThreadsModel.fromJson(Map<String, dynamic> json) => ThreadsModel(
        id: json["_id"],
        participants: json["participants"] == null ? [] : List<String>.from(json["participants"]!.map((x) => x)),
        lastMessage: json["last_message"],
        unreadMessages: json["unread_messages"],
        unreadMessagesSender: json["unread_messages_sender"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        v: json["__v"],
        lastMessageUnix: json["last_message_unix"],
        reciever: json["reciever"] == null ? null : Reciever.fromJson(json["reciever"]),
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "participants": participants == null ? [] : List<dynamic>.from(participants!.map((x) => x)),
        "last_message": lastMessage,
        "unread_messages": unreadMessages,
        "unread_messages_sender": unreadMessagesSender,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "__v": v,
        "last_message_unix": lastMessageUnix,
        "reciever": reciever?.toJson(),
    };
}

class Reciever {
    String? profileImage;
    String? id;
    String? firstName;
    String? lastName;
    String? email;
    String? chatToken;

    Reciever({
        this.profileImage,
        this.id,
        this.firstName,
        this.lastName,
        this.email,
        this.chatToken,
    });

    factory Reciever.fromJson(Map<String, dynamic> json) => Reciever(
        profileImage: json["profileImage"],
        id: json["_id"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        email: json["email"],
        chatToken: json["chat_token"],
    );

    Map<String, dynamic> toJson() => {
        "profileImage": profileImage,
        "_id": id,
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        "chat_token": chatToken,
    };
}
