/// contact_list : [{"name":"","number":""},{"name":"","number":""},{"name":"","number":""}]

class MobileContactListModel {
  List<Contact_list>? _contactList;

  List<Contact_list>? get contactList => _contactList;

  MobileContactListModel({
      List<Contact_list>? contactList}){
    _contactList = contactList;
}

  MobileContactListModel.fromJson(dynamic json) {
    if (json["contact_list"] != null) {
      _contactList = [];
      json["contact_list"].forEach((v) {
        _contactList?.add(Contact_list.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (_contactList != null) {
      map["contact_list"] = _contactList?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// name : ""
/// number : ""

class Contact_list {
  String? _name;
  String? _number;

  String? get name => _name;
  String? get number => _number;

  Contact_list({
      String? name, 
      String? number}){
    _name = name;
    _number = number;
}

  Contact_list.fromJson(dynamic json) {
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