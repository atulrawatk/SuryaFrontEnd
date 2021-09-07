import 'package:get/get.dart';
import 'package:surya/app/data/models/chat_message_model.dart';
import 'package:surya/app/data/models/chat_user_model.dart';
import 'package:surya/app/modules/chat/controllers/chat_controller.dart';
import 'package:surya/app/utils/enum_navigation.dart';
import 'package:surya/app/utils/strings.dart';

class OtherUserProfileController extends GetxController {

  late ChatUserModel model;
  @override
  void onInit() {
    super.onInit();
    model=Get.arguments;
    RxList<ChatMessageModel> chatList=model.messageList;
    chatList.forEach((element) {
      if(element.messageType==MessageType.media){
        _mediaMessages.add(element);
      }
    });
  }
  RxList<ChatMessageModel> _mediaMessages=<ChatMessageModel>[].obs;

  List<ChatMessageModel> get mediaMessages=>_mediaMessages.value;

  set mediaMessages(List<ChatMessageModel> list){

  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    _mediaMessages.clear();
  }

}
