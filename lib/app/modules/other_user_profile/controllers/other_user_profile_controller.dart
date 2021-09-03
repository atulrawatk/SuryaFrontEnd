import 'package:get/get.dart';
import 'package:surya/app/data/models/chat_message_model.dart';
import 'package:surya/app/modules/chat/controllers/chat_controller.dart';
import 'package:surya/app/utils/strings.dart';

class OtherUserProfileController extends GetxController {

  @override
  void onInit() {
    super.onInit();
    RxList<ChatMessageModel> chatList=Get.arguments;
    chatList.forEach((element) {
      if(element.messageType==AppStrings.mediaSmall){
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
