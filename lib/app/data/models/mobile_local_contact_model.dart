/// name : ""
/// number : ""

class MobileLocalContactModel {
  String? _name;
  String? _number;

  String? get name => _name;
  String? get number => _number;

  MobileLocalContactModel({
      String? name, 
      String? number}){
    _name = name;
    _number = number;
}

  MobileLocalContactModel.fromJson(dynamic json) {
    _name = json["name"];
    _number = json["number"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["name"] = _name;
    map["number"] = _number;
    return map;
  }

}