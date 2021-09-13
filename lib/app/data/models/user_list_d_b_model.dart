import 'package:surya/app/data/models/my_chat_user_model.dart';

/// userList : [{"name":"","number":"","isGroup":false,"isBlocked":false,"users":[{"name":"","number":"","isGroup":false,"isBlocked":false,"users":[],"profileImage":"","messageList":[{"isMe":false,"isGroup":false,"isSelected":false,"name":"","message":"","messageType":"","time":"","messageSeen":"","mediaType":"","media":"","isTapped":false,"repliedMessage":{"isMe":false,"isGroup":false,"isSelected":false,"name":"","message":"","messageType":"","time":"","messageSeen":"","mediaType":"","media":"","isTapped":false,"repliedMessage":null}}]}],"profileImage":"","messageList":[{"isMe":false,"isGroup":false,"isSelected":false,"name":"","message":"","messageType":"","time":"","messageSeen":"","mediaType":"","media":"","isTapped":false,"repliedMessage":{"isMe":false,"isGroup":false,"isSelected":false,"name":"","message":"","messageType":"","time":"","messageSeen":"","mediaType":"","media":"","isTapped":false,"repliedMessage":null}}]}]

class UserListDBModel {
  List<ChatUserDBModel>? _userList;

  List<ChatUserDBModel>? get userList => _userList;

  UserListDBModel({
      List<ChatUserDBModel>? userList}){
    _userList = userList;
}

  UserListDBModel.fromJson(dynamic json) {
    if (json["userList"] != null) {
      _userList = [];
      json["userList"].forEach((v) {
        _userList?.add(ChatUserDBModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (_userList != null) {
      map["userList"] = _userList?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}
//
// /// name : ""
// /// number : ""
// /// isGroup : false
// /// isBlocked : false
// /// users : [{"name":"","number":"","isGroup":false,"isBlocked":false,"users":[],"profileImage":"","messageList":[{"isMe":false,"isGroup":false,"isSelected":false,"name":"","message":"","messageType":"","time":"","messageSeen":"","mediaType":"","media":"","isTapped":false,"repliedMessage":{"isMe":false,"isGroup":false,"isSelected":false,"name":"","message":"","messageType":"","time":"","messageSeen":"","mediaType":"","media":"","isTapped":false,"repliedMessage":null}}]}]
// /// profileImage : ""
// /// messageList : [{"isMe":false,"isGroup":false,"isSelected":false,"name":"","message":"","messageType":"","time":"","messageSeen":"","mediaType":"","media":"","isTapped":false,"repliedMessage":{"isMe":false,"isGroup":false,"isSelected":false,"name":"","message":"","messageType":"","time":"","messageSeen":"","mediaType":"","media":"","isTapped":false,"repliedMessage":null}}]
//
// class UserList {
//   String? _name;
//   String? _number;
//   bool? _isGroup;
//   bool? _isBlocked;
//   List<Users>? _users;
//   String? _profileImage;
//   List<MessageList>? _messageList;
//
//   String? get name => _name;
//   String? get number => _number;
//   bool? get isGroup => _isGroup;
//   bool? get isBlocked => _isBlocked;
//   List<Users>? get users => _users;
//   String? get profileImage => _profileImage;
//   List<MessageList>? get messageList => _messageList;
//
//   UserList({
//       String? name,
//       String? number,
//       bool? isGroup,
//       bool? isBlocked,
//       List<Users>? users,
//       String? profileImage,
//       List<MessageList>? messageList}){
//     _name = name;
//     _number = number;
//     _isGroup = isGroup;
//     _isBlocked = isBlocked;
//     _users = users;
//     _profileImage = profileImage;
//     _messageList = messageList;
// }
//
//   UserList.fromJson(dynamic json) {
//     _name = json["name"];
//     _number = json["number"];
//     _isGroup = json["isGroup"];
//     _isBlocked = json["isBlocked"];
//     if (json["users"] != null) {
//       _users = [];
//       json["users"].forEach((v) {
//         _users?.add(Users.fromJson(v));
//       });
//     }
//     _profileImage = json["profileImage"];
//     if (json["messageList"] != null) {
//       _messageList = [];
//       json["messageList"].forEach((v) {
//         _messageList?.add(MessageList.fromJson(v));
//       });
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     var map = <String, dynamic>{};
//     map["name"] = _name;
//     map["number"] = _number;
//     map["isGroup"] = _isGroup;
//     map["isBlocked"] = _isBlocked;
//     if (_users != null) {
//       map["users"] = _users?.map((v) => v.toJson()).toList();
//     }
//     map["profileImage"] = _profileImage;
//     if (_messageList != null) {
//       map["messageList"] = _messageList?.map((v) => v.toJson()).toList();
//     }
//     return map;
//   }
//
// }
//
// /// isMe : false
// /// isGroup : false
// /// isSelected : false
// /// name : ""
// /// message : ""
// /// messageType : ""
// /// time : ""
// /// messageSeen : ""
// /// mediaType : ""
// /// media : ""
// /// isTapped : false
// /// repliedMessage : {"isMe":false,"isGroup":false,"isSelected":false,"name":"","message":"","messageType":"","time":"","messageSeen":"","mediaType":"","media":"","isTapped":false,"repliedMessage":null}
//
// class MessageList {
//   bool? _isMe;
//   bool? _isGroup;
//   bool? _isSelected;
//   String? _name;
//   String? _message;
//   String? _messageType;
//   String? _time;
//   String? _messageSeen;
//   String? _mediaType;
//   String? _media;
//   bool? _isTapped;
//   RepliedMessage? _repliedMessage;
//
//   bool? get isMe => _isMe;
//   bool? get isGroup => _isGroup;
//   bool? get isSelected => _isSelected;
//   String? get name => _name;
//   String? get message => _message;
//   String? get messageType => _messageType;
//   String? get time => _time;
//   String? get messageSeen => _messageSeen;
//   String? get mediaType => _mediaType;
//   String? get media => _media;
//   bool? get isTapped => _isTapped;
//   RepliedMessage? get repliedMessage => _repliedMessage;
//
//   MessageList({
//       bool? isMe,
//       bool? isGroup,
//       bool? isSelected,
//       String? name,
//       String? message,
//       String? messageType,
//       String? time,
//       String? messageSeen,
//       String? mediaType,
//       String? media,
//       bool? isTapped,
//       RepliedMessage? repliedMessage}){
//     _isMe = isMe;
//     _isGroup = isGroup;
//     _isSelected = isSelected;
//     _name = name;
//     _message = message;
//     _messageType = messageType;
//     _time = time;
//     _messageSeen = messageSeen;
//     _mediaType = mediaType;
//     _media = media;
//     _isTapped = isTapped;
//     _repliedMessage = repliedMessage;
// }
//
//   MessageList.fromJson(dynamic json) {
//     _isMe = json["isMe"];
//     _isGroup = json["isGroup"];
//     _isSelected = json["isSelected"];
//     _name = json["name"];
//     _message = json["message"];
//     _messageType = json["messageType"];
//     _time = json["time"];
//     _messageSeen = json["messageSeen"];
//     _mediaType = json["mediaType"];
//     _media = json["media"];
//     _isTapped = json["isTapped"];
//     _repliedMessage = json["repliedMessage"] != null ? RepliedMessage.fromJson(json["repliedMessage"]) : null;
//   }
//
//   Map<String, dynamic> toJson() {
//     var map = <String, dynamic>{};
//     map["isMe"] = _isMe;
//     map["isGroup"] = _isGroup;
//     map["isSelected"] = _isSelected;
//     map["name"] = _name;
//     map["message"] = _message;
//     map["messageType"] = _messageType;
//     map["time"] = _time;
//     map["messageSeen"] = _messageSeen;
//     map["mediaType"] = _mediaType;
//     map["media"] = _media;
//     map["isTapped"] = _isTapped;
//     if (_repliedMessage != null) {
//       map["repliedMessage"] = _repliedMessage?.toJson();
//     }
//     return map;
//   }
//
// }
//
// /// isMe : false
// /// isGroup : false
// /// isSelected : false
// /// name : ""
// /// message : ""
// /// messageType : ""
// /// time : ""
// /// messageSeen : ""
// /// mediaType : ""
// /// media : ""
// /// isTapped : false
// /// repliedMessage : null
//
// class RepliedMessage {
//   bool? _isMe;
//   bool? _isGroup;
//   bool? _isSelected;
//   String? _name;
//   String? _message;
//   String? _messageType;
//   String? _time;
//   String? _messageSeen;
//   String? _mediaType;
//   String? _media;
//   bool? _isTapped;
//   dynamic? _repliedMessage;
//
//   bool? get isMe => _isMe;
//   bool? get isGroup => _isGroup;
//   bool? get isSelected => _isSelected;
//   String? get name => _name;
//   String? get message => _message;
//   String? get messageType => _messageType;
//   String? get time => _time;
//   String? get messageSeen => _messageSeen;
//   String? get mediaType => _mediaType;
//   String? get media => _media;
//   bool? get isTapped => _isTapped;
//   dynamic? get repliedMessage => _repliedMessage;
//
//   RepliedMessage({
//       bool? isMe,
//       bool? isGroup,
//       bool? isSelected,
//       String? name,
//       String? message,
//       String? messageType,
//       String? time,
//       String? messageSeen,
//       String? mediaType,
//       String? media,
//       bool? isTapped,
//       dynamic? repliedMessage}){
//     _isMe = isMe;
//     _isGroup = isGroup;
//     _isSelected = isSelected;
//     _name = name;
//     _message = message;
//     _messageType = messageType;
//     _time = time;
//     _messageSeen = messageSeen;
//     _mediaType = mediaType;
//     _media = media;
//     _isTapped = isTapped;
//     _repliedMessage = repliedMessage;
// }
//
//   RepliedMessage.fromJson(dynamic json) {
//     _isMe = json["isMe"];
//     _isGroup = json["isGroup"];
//     _isSelected = json["isSelected"];
//     _name = json["name"];
//     _message = json["message"];
//     _messageType = json["messageType"];
//     _time = json["time"];
//     _messageSeen = json["messageSeen"];
//     _mediaType = json["mediaType"];
//     _media = json["media"];
//     _isTapped = json["isTapped"];
//     _repliedMessage = json["repliedMessage"];
//   }
//
//   Map<String, dynamic> toJson() {
//     var map = <String, dynamic>{};
//     map["isMe"] = _isMe;
//     map["isGroup"] = _isGroup;
//     map["isSelected"] = _isSelected;
//     map["name"] = _name;
//     map["message"] = _message;
//     map["messageType"] = _messageType;
//     map["time"] = _time;
//     map["messageSeen"] = _messageSeen;
//     map["mediaType"] = _mediaType;
//     map["media"] = _media;
//     map["isTapped"] = _isTapped;
//     map["repliedMessage"] = _repliedMessage;
//     return map;
//   }
//
// }
//
// /// name : ""
// /// number : ""
// /// isGroup : false
// /// isBlocked : false
// /// users : []
// /// profileImage : ""
// /// messageList : [{"isMe":false,"isGroup":false,"isSelected":false,"name":"","message":"","messageType":"","time":"","messageSeen":"","mediaType":"","media":"","isTapped":false,"repliedMessage":{"isMe":false,"isGroup":false,"isSelected":false,"name":"","message":"","messageType":"","time":"","messageSeen":"","mediaType":"","media":"","isTapped":false,"repliedMessage":null}}]
//
// class Users {
//   String? _name;
//   String? _number;
//   bool? _isGroup;
//   bool? _isBlocked;
//   List<dynamic>? _users;
//   String? _profileImage;
//   List<MessageList>? _messageList;
//
//   String? get name => _name;
//   String? get number => _number;
//   bool? get isGroup => _isGroup;
//   bool? get isBlocked => _isBlocked;
//   List<dynamic>? get users => _users;
//   String? get profileImage => _profileImage;
//   List<MessageList>? get messageList => _messageList;
//
//   Users({
//       String? name,
//       String? number,
//       bool? isGroup,
//       bool? isBlocked,
//       List<dynamic>? users,
//       String? profileImage,
//       List<MessageList>? messageList}){
//     _name = name;
//     _number = number;
//     _isGroup = isGroup;
//     _isBlocked = isBlocked;
//     _users = users;
//     _profileImage = profileImage;
//     _messageList = messageList;
// }
//
//   Users.fromJson(dynamic json) {
//     _name = json["name"];
//     _number = json["number"];
//     _isGroup = json["isGroup"];
//     _isBlocked = json["isBlocked"];
//     if (json["users"] != null) {
//       _users = [];
//       json["users"].forEach((v) {
//         _users?.add(dynamic.fromJson(v));
//       });
//     }
//     _profileImage = json["profileImage"];
//     if (json["messageList"] != null) {
//       _messageList = [];
//       json["messageList"].forEach((v) {
//         _messageList?.add(MessageList.fromJson(v));
//       });
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     var map = <String, dynamic>{};
//     map["name"] = _name;
//     map["number"] = _number;
//     map["isGroup"] = _isGroup;
//     map["isBlocked"] = _isBlocked;
//     if (_users != null) {
//       map["users"] = _users?.map((v) => v.toJson()).toList();
//     }
//     map["profileImage"] = _profileImage;
//     if (_messageList != null) {
//       map["messageList"] = _messageList?.map((v) => v.toJson()).toList();
//     }
//     return map;
//   }
//
// }
//
// /// isMe : false
// /// isGroup : false
// /// isSelected : false
// /// name : ""
// /// message : ""
// /// messageType : ""
// /// time : ""
// /// messageSeen : ""
// /// mediaType : ""
// /// media : ""
// /// isTapped : false
// /// repliedMessage : {"isMe":false,"isGroup":false,"isSelected":false,"name":"","message":"","messageType":"","time":"","messageSeen":"","mediaType":"","media":"","isTapped":false,"repliedMessage":null}
//
// class MessageList {
//   bool? _isMe;
//   bool? _isGroup;
//   bool? _isSelected;
//   String? _name;
//   String? _message;
//   String? _messageType;
//   String? _time;
//   String? _messageSeen;
//   String? _mediaType;
//   String? _media;
//   bool? _isTapped;
//   RepliedMessage? _repliedMessage;
//
//   bool? get isMe => _isMe;
//   bool? get isGroup => _isGroup;
//   bool? get isSelected => _isSelected;
//   String? get name => _name;
//   String? get message => _message;
//   String? get messageType => _messageType;
//   String? get time => _time;
//   String? get messageSeen => _messageSeen;
//   String? get mediaType => _mediaType;
//   String? get media => _media;
//   bool? get isTapped => _isTapped;
//   RepliedMessage? get repliedMessage => _repliedMessage;
//
//   MessageList({
//       bool? isMe,
//       bool? isGroup,
//       bool? isSelected,
//       String? name,
//       String? message,
//       String? messageType,
//       String? time,
//       String? messageSeen,
//       String? mediaType,
//       String? media,
//       bool? isTapped,
//       RepliedMessage? repliedMessage}){
//     _isMe = isMe;
//     _isGroup = isGroup;
//     _isSelected = isSelected;
//     _name = name;
//     _message = message;
//     _messageType = messageType;
//     _time = time;
//     _messageSeen = messageSeen;
//     _mediaType = mediaType;
//     _media = media;
//     _isTapped = isTapped;
//     _repliedMessage = repliedMessage;
// }
//
//   MessageList.fromJson(dynamic json) {
//     _isMe = json["isMe"];
//     _isGroup = json["isGroup"];
//     _isSelected = json["isSelected"];
//     _name = json["name"];
//     _message = json["message"];
//     _messageType = json["messageType"];
//     _time = json["time"];
//     _messageSeen = json["messageSeen"];
//     _mediaType = json["mediaType"];
//     _media = json["media"];
//     _isTapped = json["isTapped"];
//     _repliedMessage = json["repliedMessage"] != null ? RepliedMessage.fromJson(json["repliedMessage"]) : null;
//   }
//
//   Map<String, dynamic> toJson() {
//     var map = <String, dynamic>{};
//     map["isMe"] = _isMe;
//     map["isGroup"] = _isGroup;
//     map["isSelected"] = _isSelected;
//     map["name"] = _name;
//     map["message"] = _message;
//     map["messageType"] = _messageType;
//     map["time"] = _time;
//     map["messageSeen"] = _messageSeen;
//     map["mediaType"] = _mediaType;
//     map["media"] = _media;
//     map["isTapped"] = _isTapped;
//     if (_repliedMessage != null) {
//       map["repliedMessage"] = _repliedMessage?.toJson();
//     }
//     return map;
//   }
//
// }
//
// /// isMe : false
// /// isGroup : false
// /// isSelected : false
// /// name : ""
// /// message : ""
// /// messageType : ""
// /// time : ""
// /// messageSeen : ""
// /// mediaType : ""
// /// media : ""
// /// isTapped : false
// /// repliedMessage : null
//
// class RepliedMessage {
//   bool? _isMe;
//   bool? _isGroup;
//   bool? _isSelected;
//   String? _name;
//   String? _message;
//   String? _messageType;
//   String? _time;
//   String? _messageSeen;
//   String? _mediaType;
//   String? _media;
//   bool? _isTapped;
//   dynamic? _repliedMessage;
//
//   bool? get isMe => _isMe;
//   bool? get isGroup => _isGroup;
//   bool? get isSelected => _isSelected;
//   String? get name => _name;
//   String? get message => _message;
//   String? get messageType => _messageType;
//   String? get time => _time;
//   String? get messageSeen => _messageSeen;
//   String? get mediaType => _mediaType;
//   String? get media => _media;
//   bool? get isTapped => _isTapped;
//   dynamic? get repliedMessage => _repliedMessage;
//
//   RepliedMessage({
//       bool? isMe,
//       bool? isGroup,
//       bool? isSelected,
//       String? name,
//       String? message,
//       String? messageType,
//       String? time,
//       String? messageSeen,
//       String? mediaType,
//       String? media,
//       bool? isTapped,
//       dynamic? repliedMessage}){
//     _isMe = isMe;
//     _isGroup = isGroup;
//     _isSelected = isSelected;
//     _name = name;
//     _message = message;
//     _messageType = messageType;
//     _time = time;
//     _messageSeen = messageSeen;
//     _mediaType = mediaType;
//     _media = media;
//     _isTapped = isTapped;
//     _repliedMessage = repliedMessage;
// }
//
//   RepliedMessage.fromJson(dynamic json) {
//     _isMe = json["isMe"];
//     _isGroup = json["isGroup"];
//     _isSelected = json["isSelected"];
//     _name = json["name"];
//     _message = json["message"];
//     _messageType = json["messageType"];
//     _time = json["time"];
//     _messageSeen = json["messageSeen"];
//     _mediaType = json["mediaType"];
//     _media = json["media"];
//     _isTapped = json["isTapped"];
//     _repliedMessage = json["repliedMessage"];
//   }
//
//   Map<String, dynamic> toJson() {
//     var map = <String, dynamic>{};
//     map["isMe"] = _isMe;
//     map["isGroup"] = _isGroup;
//     map["isSelected"] = _isSelected;
//     map["name"] = _name;
//     map["message"] = _message;
//     map["messageType"] = _messageType;
//     map["time"] = _time;
//     map["messageSeen"] = _messageSeen;
//     map["mediaType"] = _mediaType;
//     map["media"] = _media;
//     map["isTapped"] = _isTapped;
//     map["repliedMessage"] = _repliedMessage;
//     return map;
//   }
//
