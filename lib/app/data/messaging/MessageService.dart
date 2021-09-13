import 'package:get/get.dart';
import 'package:surya/app/data/models/my_chat_user_model.dart';

class MessageService{

  MessageService._();

  static final _messageInstance=MessageService._();
  factory MessageService(){
    return _messageInstance;
  }

}