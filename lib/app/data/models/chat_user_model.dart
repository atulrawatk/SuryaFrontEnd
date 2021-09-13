// import 'dart:io';
//
// import 'package:get/get.dart';
// import 'package:surya/app/data/models/chat_message_model.dart';
//
// class ChatUserModel {
//   String? name;
//   String? number;
//   bool? isGroup;
//   bool? isBlocked;
//   List<ChatUserModel>? users;
//   String? profileImage;
//   List<ChatMessageModel>? messageList;
//
//   ChatUserModel(
//       {required this.name,
//       required this.number,
//       required this.isGroup,
//         required this.users,
//       required this.profileImage,
//       required this.isBlocked,
//       required this.messageList});
//   ChatUserModel.fromJson(dynamic json) {
//     name = json["name"];
//     number = json["number"];
//     isGroup = json["isGroup"];
//     isBlocked = json["isBlocked"];
//     if (json["users"] != null) {
//       users = <ChatUserModel>[];
//       json["users"].forEach((v) {
//         users?.add(ChatUserModel.fromJson(v));
//       });
//     }
//     profileImage = json["profileImage"];
//     if (json["messageList"] != null) {
//       messageList = <ChatMessageModel>[];
//       json["messageList"].forEach((v) {
//         messageList?.add(ChatMessageModel.fromJson(v));
//       });
//     }
//   }
// }
