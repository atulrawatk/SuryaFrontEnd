import 'package:hive/hive.dart';

part 'isLogin.g.dart';
@HiveType(typeId: 0)
class IsLogin{

  @HiveField(0)
  bool isLogin;

  IsLogin({required this.isLogin});

}