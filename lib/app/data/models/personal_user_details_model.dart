import 'package:get/get.dart';

/// name : ""
/// profile_image : ""

class PersonalUserDetailsModel {
  RxString? _name="".obs;
  RxString? _profileImage="".obs;
  RxString? _about="".obs;


  RxString? get name => _name;
  RxString? get profileImage => _profileImage;
  RxString? get about => _about;

  PersonalUserDetailsModel({
    RxString? name,
    RxString? profileImage,
    RxString? about

  }){
    _name = name;
    _profileImage = profileImage;
    _about = about;
}

  PersonalUserDetailsModel.fromJson(dynamic json) {
    _name!.value = json["name"];
    _profileImage?.value = json["profile_image"];
    _about?.value = json["about"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["name"] = _name!.value;
    map["profile_image"] = _profileImage?.value;
    map["about"] = _about?.value;
    return map;
  }

}