import 'package:surya/app/data/encryption/aes.dart';

class UserModel{

  String _id;

  String _name;

  String _profilePic;

  String _phoneNumber;

  String _publicKey;

  bool _isDeleted;

  String _pushToken;

  String _about;

  String _designation;

  String _status;

  String _lastSeen;

  String _created;

  String _profileThumbnail;

  String _secretKey;

  String _status_bar;

  String _last_seen;





  UserModel(this._id,this._name,this._profilePic,this._phoneNumber,this._publicKey,this._isDeleted,this._pushToken,this._about,this._designation,this._status,this._lastSeen,this._created,this._profileThumbnail,this._secretKey,this._status_bar,this._last_seen);

  UserModel.fromJson(Map<String, dynamic> json,AESEncryption aesEncryption)
      : _id = json['id'],
        _name = json['name']!=null && json['name'].toString().isNotEmpty ? aesEncryption.decryptAESFull(cipherText: json['name'].toString()):"",
        _profilePic = json['profile_pic'] ?? "",
        _phoneNumber = json['phone_number']!=null && json['phone_number'].toString().isNotEmpty ? aesEncryption.decryptAESFull(cipherText: json['phone_number'].toString()):"",
        _publicKey = json['public_key']!=null && json['public_key'].toString().isNotEmpty ? aesEncryption.decryptAESFull(cipherText: json['public_key'].toString()):"",
        _isDeleted = json['is_deleted'] ?? false,
        _pushToken = json['push_token'] ?? "",
        _about = json['about']!=null && json['about'].toString().isNotEmpty ? aesEncryption.decryptAESFull(cipherText: json['about'].toString()):"",
        _designation = json['designation'] ?? "",
        _status = json['status'] ?? "",
        _lastSeen = json['last_seen'] ?? "",
        _profileThumbnail=json["profile_thumbnail"] ?? "",
        _secretKey=json["secret_key"] ?? "",
        _status_bar=json["socket_status"] ?? "",
        _last_seen=json["last_seen"] ?? "",
        _created=json['created'] ?? "";


  Map<String, dynamic> toJson() =>
      {
        'created': _created,

        'id':_id,

        'name': _name,

        'status':_status,

        'profile_pic': _profilePic,

        'phone_number': _phoneNumber,

        'push_token': _pushToken,

        'about':_about,

        'designation':_designation,

        'is_deleted':_isDeleted,

        'public_key':_publicKey,

        'secret_key':_secretKey,

        'socket_status':_status_bar,

        'last_seen':_last_seen,

        "_profileThumbnail":_profileThumbnail,

        'last_seen':_lastSeen
      };


  String get statusBar => _status_bar;

  set statusBar(String value) {
    _status_bar = value;
  }

  String get secretKey => _secretKey;

  set secretKey(String value) {
    _secretKey = value;
  }

  String get profileThumbnail => _profileThumbnail;

  set profileThumbnail(String value) {
    _profileThumbnail = value;
  }

  String get lastSeen => _lastSeen;

  set lastSeen(String value) {
    _lastSeen = value;
  }

  String get status => _status;

  set status(String value) {
    _status = value;
  }

  String get designation => _designation;

  set designation(String value) {
    _designation = value;
  }

  String get about => _about;

  set about(String value) {
    _about = value;
  }

  String get pushToken => _pushToken;

  set pushToken(String value) {
    _pushToken = value;
  }


  bool get isDeleted => _isDeleted;

  set isDeleted(bool value) {
    _isDeleted = value;
  }

  String get publicKey => _publicKey;

  set publicKey(String value) {
    _publicKey = value;
  }

  String get phoneNumber => _phoneNumber;

  set phoneNumber(String value) {
    _phoneNumber = value;
  }

  String get profilePic => _profilePic;

  set profilePic(String value) {
    _profilePic = value;
  }

  String get name => _name;

  set name(String value) {
    _name = value;
  }

  String get id => _id;

  set id(String value) {
    _id = value;
  }

  String get created => _created;

  set created(String value) {
    _created = value;
  }

  String get last_seen => _last_seen;

  set last_seen(String value) {
    _last_seen = value;
  }

}