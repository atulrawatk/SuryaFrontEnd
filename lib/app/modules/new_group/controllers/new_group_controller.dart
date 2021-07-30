import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:surya/app/data/models/ContactUsers.dart';

class NewGroupController extends GetxController {
  ScrollController scrollController = ScrollController();

  RxBool _isSearch = false.obs;
  bool get isSearch => this._isSearch.value;
  set isSearch(bool v) => this._isSearch.value = v;


  //Group List Adding and Removing Dynamically
  RxList<int> _groupMemberList=RxList.empty(growable: true);
  List<int> get groupMemberList=>_groupMemberList;
  set setGroupMemberList(int singleValue){
    _groupMemberList.add(singleValue);
  }

  RxMap<String,ContactUsers> contacts=<String,ContactUsers>{}.obs;
  RxList<ContactUsers> _totalList=RxList.empty();
  List<ContactUsers> get totalList=>_totalList;
  set setTotalList(List<ContactUsers> list){
    _totalList.addAll(list);
  }

  RxList<ContactUsers> selectedContacts=RxList.empty(growable: true);

  @override
  void onInit() {
    super.onInit();
    setTotalList=ContactUsers.contacts;
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
