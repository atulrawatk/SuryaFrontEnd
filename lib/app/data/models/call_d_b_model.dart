import 'package:get/get.dart';

/// name : ""
/// callType : ""
/// time : ""
/// callTimes : ""

class CallDBModel {
  String? _name="";
  String? _callType;
  String? _time;
  RxInt? _callTimes=1.obs;

  String? get name => _name;
  String? get callType => _callType;
  String? get time => _time;
  RxInt? get callTimes => _callTimes;

  CallDBModel({
      required String? name,
    required String? callType,
    required  String? time,
    required RxInt? callTimes}){
    _name = name;
    _callType = callType;
    _time = time;
    _callTimes = callTimes;
}

  CallDBModel.fromJson(dynamic json) {
    _name = json["name"];
    _callType = json["callType"];
    _time = json["time"];
    _callTimes?.value = json["callTimes"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["name"] = _name;
    map["callType"] = _callType;
    map["time"] = _time;
    map["callTimes"] = _callTimes?.value;
    return map;
  }

}