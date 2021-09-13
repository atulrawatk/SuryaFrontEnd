// import 'dart:io';
//
// import 'package:get/get.dart';
// import 'package:surya/app/utils/utils.dart';
//
// class ChatMessageModel {
//   bool? isMe;
//   bool? isGroup;
//   bool? isSelected;
//   String? name;
//   String? message;
//   String? messageType;
//   String? time;
//   String? messageSeen;
//   String? mediaType;
//   File? media;
//   bool? isTapped;
//   ChatMessageModel? repliedMessage;
//   ChatMessageModel(
//       {required this.name,
//       required this.isGroup,
//       required this.isMe,
//       required this.message,
//       required this.messageType,
//       required this.time,
//       required this.messageSeen,
//        this.repliedMessage,
//         required this.isSelected,
//         required this.media,
//         required this.mediaType,
//         required this.isTapped
//       });
//   ChatMessageModel.fromJson(dynamic json) {
//     isMe = json["isMe"];
//     isGroup = json["isGroup"];
//     isSelected = json["isSelected"];
//     name = json["name"];
//     message = json["message"];
//     messageType = json["messageType"];
//     time = json["time"];
//     messageSeen = json["messageSeen"];
//     mediaType = json["mediaType"];
//     media = json["media"];
//     isTapped = json["isTapped"];
//     repliedMessage = json["repliedMessage"] != null ? ChatMessageModel.fromJson(json["repliedMessage"]) : null;
//   }
// }
