import 'package:get/get.dart';
import 'package:surya/app/data/models/my_chat_user_model.dart';

class MediaLinksDocsController extends GetxController {
  //TODO: Implement MediaLinksDocsController
  late ChatUserDBModel model;
  late RxList<MessageDBList> chatList;
  @override
  void onInit() {
    super.onInit();
    getChatValues();
  }

  getChatValues(){
    model=Get.arguments;
    chatList=model.messageList!;
    chatList.forEach((element) {
      if(element.messageType=="media"){
        model.messageList?.add(element);
      }
    });
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
