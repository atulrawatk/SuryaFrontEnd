class BasicUserModel{
  static late String _userId="";
 static late String _userToken="";
 static late String _userEncNumber="";


  static String get userId=>_userId;
 static  String get userToken=>_userToken;
  static String get userEncNumber=>_userEncNumber;

  static set userId(String id)=>_userId=id;
  static set userToken(String token)=>_userToken=token;
 static set userEncNumber(String number)=>_userEncNumber=number;



}