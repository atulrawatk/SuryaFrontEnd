import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChatController extends GetxController {

  RxBool sendStatus=false.obs;
  ScrollController scrollController=new ScrollController();
  TextEditingController textEditingController=new TextEditingController();
  var textFieldHeight=45.h.obs;


  @override
  void onInit() {
    super.onInit();
    sendStatusCheck();

  }
  sendStatusCheck(){
    textEditingController.addListener(() {
      if(textEditingController.text.trim().isNotEmpty){
        sendStatus.value=true;
      }
      else{
        sendStatus.value=false;
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
