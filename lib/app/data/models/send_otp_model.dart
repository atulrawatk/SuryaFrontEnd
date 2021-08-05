/// success : {"data":{"_id":"60f00c18bf5e430f30bfc81d","verificationToken":"e34abba4d3b6a28128718f7cf61df1410d0a3ca226413d1f625c8f467e06a30814deb967b1c8bf386bb779e45d99444a"},"message":"Otp sent successfuly."}

class SendOtpModel {
  Success? _success;

  Success? get success => _success;

  SendOtpModel({
      Success? success}){
    _success = success;
}

  SendOtpModel.fromJson(dynamic json) {
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

/// data : {"_id":"60f00c18bf5e430f30bfc81d","verificationToken":"e34abba4d3b6a28128718f7cf61df1410d0a3ca226413d1f625c8f467e06a30814deb967b1c8bf386bb779e45d99444a"}
/// message : "Otp sent successfuly."

class Success {
  Data? _data;
  String? _message;

  Data? get data => _data;
  String? get message => _message;

  Success({
      Data? data, 
      String? message}){
    _data = data;
    _message = message;
}

  Success.fromJson(dynamic json) {
    _data = json["data"] != null ? Data.fromJson(json["data"]) : null;
    _message = json["message"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (_data != null) {
      map["data"] = _data?.toJson();
    }
    map["message"] = _message;
    return map;
  }

}

/// _id : "60f00c18bf5e430f30bfc81d"
/// verificationToken : "e34abba4d3b6a28128718f7cf61df1410d0a3ca226413d1f625c8f467e06a30814deb967b1c8bf386bb779e45d99444a"

class Data {
  String? _id;
  String? _verificationToken;

  String? get id => _id;
  String? get verificationToken => _verificationToken;

  Data({
      String? id, 
      String? verificationToken}){
    _id = id;
    _verificationToken = verificationToken;
}

  Data.fromJson(dynamic json) {
    _id = json["_id"];
    _verificationToken = json["verificationToken"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["_id"] = _id;
    map["verificationToken"] = _verificationToken;
    return map;
  }

}