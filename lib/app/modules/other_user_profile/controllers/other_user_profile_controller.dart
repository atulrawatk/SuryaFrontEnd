import 'package:get/get.dart';
import 'package:surya/app/data/models/my_chat_user_model.dart';

class OtherUserProfileController extends GetxController {

  late ChatUserDBModel model;
  @override
  void onInit() {
    super.onInit();
    model=Get.arguments;
    RxList<MessageDBList> chatList=model.messageList!;
    chatList.forEach((element) {
      if(element.messageType=="media"){
        _mediaMessages.add(element);
      }
    });
  }
  RxList<MessageDBList> _mediaMessages=<MessageDBList>[].obs;

  List<MessageDBList> get mediaMessages=>_mediaMessages.value;

  set mediaMessages(List<MessageDBList> list){

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
