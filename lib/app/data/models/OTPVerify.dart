/// success : {"message":"Otp verified successfuly.","data":{"id":"60f00c18bf5e430f30bfc81d","name":"35f2d6ef23e081d486f232f49816277c","phone_number":"993494f61a23a1b8a9fb3b66ee66513a","verificationToken":"e34abba4d3b6a28128718f7cf61df1410d0a3ca226413d1f625c8f467e06a30814deb967b1c8bf386bb779e45d99444a","about":null,"profile_pic":null,"thumbnail":null}}

class OtpVerify {
  Success? _success;

  Success? get success => _success;

  OtpVerify({
    Success? success}){
    _success = success;
  }

  OtpVerify.fromJson(dynamic json) {
    _success = json["success"] != null ? Success.fromJson(json["success"]) : null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (_success != null) {
      map["success"] = _success?.toJson();
    }
    return map;
  }

}

/// message : "Otp verified successfuly."
/// data : {"id":"60f00c18bf5e430f30bfc81d","name":"35f2d6ef23e081d486f232f49816277c","phone_number":"993494f61a23a1b8a9fb3b66ee66513a","verificationToken":"e34abba4d3b6a28128718f7cf61df1410d0a3ca226413d1f625c8f467e06a30814deb967b1c8bf386bb779e45d99444a","about":null,"profile_pic":null,"thumbnail":null}

class Success {
  String? _message;
  Data? _data;

  String? get message => _message;
  Data? get data => _data;

  Success({
    String? message,
    Data? data}){
    _message = message;
    _data = data;
  }

  Success.fromJson(dynamic json) {
    _message = json["message"];
    _data = json["data"] != null ? Data.fromJson(json["data"]) : null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["message"] = _message;
    if (_data != null) {
      map["data"] = _data?.toJson();
    }
    return map;
  }

}

/// id : "60f00c18bf5e430f30bfc81d"
/// name : "35f2d6ef23e081d486f232f49816277c"
/// phone_number : "993494f61a23a1b8a9fb3b66ee66513a"
/// verificationToken : "e34abba4d3b6a28128718f7cf61df1410d0a3ca226413d1f625c8f467e06a30814deb967b1c8bf386bb779e45d99444a"
/// about : null
/// profile_pic : null
/// thumbnail : null

class Data {
  String? _id;
  String? _name;
  String? _phoneNumber;
  String? _verificationToken;
  dynamic? _about;
  dynamic? _profilePic;
  dynamic? _thumbnail;

  String? get id => _id;
  String? get name => _name;
  String? get phoneNumber => _phoneNumber;
  String? get verificationToken => _verificationToken;
  dynamic? get about => _about;
  dynamic? get profilePic => _profilePic;
  dynamic? get thumbnail => _thumbnail;

  Data({
    String? id,
    String? name,
    String? phoneNumber,
    String? verificationToken,
    dynamic? about,
    dynamic? profilePic,
    dynamic? thumbnail}){
    _id = id;
    _name = name;
    _phoneNumber = phoneNumber;
    _verificationToken = verificationToken;
    _about = about;
    _profilePic = profilePic;
    _thumbnail = thumbnail;
  }

  Data.fromJson(dynamic json) {
    _id = json["id"];
    _name = json["name"];
    _phoneNumber = json["phone_number"];
    _verificationToken = json["verificationToken"];
    _about = json["about"];
    _profilePic = json["profile_pic"];
    _thumbnail = json["thumbnail"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["name"] = _name;
    map["phone_number"] = _phoneNumber;
    map["verificationToken"] = _verificationToken;
    map["about"] = _about;
    map["profile_pic"] = _profilePic;
    map["thumbnail"] = _thumbnail;
    return map;
  }

}