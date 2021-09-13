import 'dart:convert';

import 'package:get/get.dart';
import 'package:surya/app/utils/enum_navigation.dart';

/// name : ""
/// number : ""
/// isGroup : false
/// isBlocked : false
/// users : [{"name":"","number":"","isGroup":false,"isBlocked":false,"users":[],"profileImage":"","messageList":[{"isMe":false,"isGroup":false,"isSelected":false,"name":"","message":"","messageType":"","time":"","messageSeen":"","mediaType":"","media":"","isTapped":false,"repliedMessage":{"isMe":false,"isGroup":false,"isSelected":false,"name":"","message":"","messageType":"","time":"","messageSeen":"","mediaType":"","media":"","isTapped":false,"repliedMessage":null}}]}]
/// profileImage : ""
/// messageList : [{"isMe":false,"isGroup":false,"isSelected":false,"name":"","message":"","messageType":"","time":"","messageSeen":"","mediaType":"","media":"","isTapped":false,"repliedMessage":{"isMe":false,"isGroup":false,"isSelected":false,"name":"","message":"","messageType":"","time":"","messageSeen":"","mediaType":"","media":"","isTapped":false,"repliedMessage":null}}]

class ChatUserDBModel {
  RxString _name=''.obs;
  String? _number;
  bool? _isGroup;
  RxBool? _isBlocked=false.obs;
  RxList<ChatUserDBModel> _users=<ChatUserDBModel>[].obs;
  RxString _profileImage="".obs;
  RxList<MessageDBList> _messageList=<MessageDBList>[].obs;

  RxString? get name => _name;
  String? get number => _number;
  bool? get isGroup => _isGroup;
  RxBool? get isBlocked => _isBlocked;
  RxList<ChatUserDBModel>? get users => _users;
  RxString? get profileImage => _profileImage;
  RxList<MessageDBList>? get messageList => _messageList;

  ChatUserDBModel({
      RxString? name,
      String? number,
      bool? isGroup, 
      RxBool? isBlocked,
      RxList<ChatUserDBModel>? users,
      RxString? profileImage,
      RxList<MessageDBList>? messageList}){
    _name = name!;
    _number = number;
    _isGroup = isGroup;
    _isBlocked = isBlocked;
    _users = users!;
    _profileImage = profileImage!;
    _messageList = messageList!;
}

  static String encode(List<ChatUserDBModel> musics) => json.encode(
    musics
        .map<Map<String, dynamic>>((music) => ChatUserDBModel.toMap(music))
        .toList(),
  );

  static Map<String, dynamic> toMap(ChatUserDBModel music) => {
    'name': music.name,
    'number': music.number,
    // 'isGroup': music.size,
    // 'duration': music.duration,
    // 'name': music.name,
    // 'img': music.img,
    // 'favorite': music.favorite,
  };

  static List<ChatUserDBModel> decode(String musics) =>
      (json.decode(musics) as List<dynamic>)
          .map<ChatUserDBModel>((item) => ChatUserDBModel.fromJson(item))
          .toList();

  ChatUserDBModel.fromJson(dynamic json) {
    _name.value = json["name"];
    _number = json["number"];
    _isGroup = json["isGroup"];
    _isBlocked?.value = json["isBlocked"];
    if (json["users"] != null) {
      _users = <ChatUserDBModel>[].obs;
      json["users"].forEach((v) {
        _users.add(ChatUserDBModel.fromJson(v));
      });
    }
    _profileImage.value = json["profileImage"];
    if (json["messageList"] != null) {
      _messageList = <MessageDBList>[].obs;
      json["messageList"].forEach((v) {
        _messageList.add(MessageDBList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["name"] = _name.value;
    map["number"] = _number;
    map["isGroup"] = _isGroup;
    map["isBlocked"] = _isBlocked!.value;
    if (_users != null) {
      map["users"] = _users.map((v) => v.toJson()).toList();
    }
    map["profileImage"] = _profileImage.value;
    if (_messageList != null) {
      map["messageList"] = _messageList.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// isMe : false
/// isGroup : false
/// isSelected : false
/// name : ""
/// message : ""
/// messageType : ""
/// time : ""
/// messageSeen : ""
/// mediaType : ""
/// media : ""
/// isTapped : false
/// repliedMessage : {"isMe":false,"isGroup":false,"isSelected":false,"name":"","message":"","messageType":"","time":"","messageSeen":"","mediaType":"","media":"","isTapped":false,"repliedMessage":null}

class MessageDBList {
  bool? _isMe;
  bool? _isGroup;
  RxBool _isSelected=false.obs;
  String? _name;
  String? _message;
  String? _messageType;
  String? _time;
  String? _messageSeen;
  String? _mediaType;
  String? _media;
  RxBool _isTapped=false.obs;
  MessageDBList? _repliedMessage;

  bool? get isMe => _isMe;
  bool? get isGroup => _isGroup;
  RxBool? get isSelected => _isSelected;
  String? get name => _name;
  String? get message => _message;
  String? get messageType => _messageType;
  String? get time => _time;
  String? get messageSeen => _messageSeen;
  String? get mediaType => _mediaType;
  String? get media => _media;
  RxBool? get isTapped => _isTapped;
  MessageDBList? get repliedMessage => _repliedMessage;

  MessageDBList({
      bool? isMe, 
      bool? isGroup,
    RxBool? isSelected,
      String? name, 
      String? message,
      MessageType? messageType,
      String? time, 
      String? messageSeen,
      MediaType? mediaType,
      String? media,
    RxBool? isTapped,
    MessageDBList? repliedMessage}){
    _isMe = isMe;
    _isGroup = isGroup;
    _isSelected = isSelected! ;
    _name = name;
    _message = message;
    _messageType = messageType==MessageType.media?"media":"text";
    _time = time;
    _messageSeen = messageSeen;
    switch(mediaType){
      case MediaType.video:
        _mediaType="video";
        break;
      case MediaType.image:
        _mediaType="image";
        break;
      case MediaType.document:
        _mediaType="document";
        break;
      case MediaType.audio:
        _mediaType="audio";
        break;
      case MediaType.none:
        _mediaType="none";
        break;
      default: _mediaType="media";
    }
    _media = media;
    _isTapped = isTapped!;
    _repliedMessage = repliedMessage;
}

  MessageDBList.fromJson(dynamic json) {
    _isMe = json["isMe"];
    _isGroup = json["isGroup"];
    _isSelected.value = json["isSelected"];
    _name = json["name"];
    _message = json["message"];
    _messageType = json["messageType"];
    _time = json["time"];
    _messageSeen = json["messageSeen"];
    _mediaType = json["mediaType"];
    _media = json["media"];
    _isTapped.value = json["isTapped"];
    _repliedMessage = json["repliedMessage"] != null ? MessageDBList.fromJson(json["repliedMessage"]) : null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["isMe"] = _isMe;
    map["isGroup"] = _isGroup;
    map["isSelected"] = _isSelected.value;
    map["name"] = _name;
    map["message"] = _message;
    map["messageType"] = _messageType;
    map["time"] = _time;
    map["messageSeen"] = _messageSeen;
    map["mediaType"] = _mediaType;
    map["media"] = _media;
    map["isTapped"] = _isTapped.value;
    if (_repliedMessage != null) {
      map["repliedMessage"] = _repliedMessage?.toJson();
    }
    return map;
  }

}

