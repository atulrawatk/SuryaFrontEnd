import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:surya/app/data/models/ContactUsers.dart';
import 'package:surya/app/modules/home/controllers/home_controller.dart';
import 'package:surya/app/utils/utils.dart';
// import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class ContactsController extends GetxController {
  //
  HomeController homeController = Get.find<HomeController>();

  ScrollController scrollController = ScrollController();

  int pageSize = 20;

  // final PagingController<int, ContactUsers> pagingController =
  //     PagingController(firstPageKey: 0);

  // fetchpaging() {
  //   pagingController.addPageRequestListener((pageKey) {
  //     // fetchPage(pageKey);
  //   });
  // }

  RxBool _isSearch = false.obs;
  bool get isSearch => this._isSearch.value;
  set isSearch(bool v) => this._isSearch.value = v;

  Rx<AppBarchange> _isAppBarChange = AppBarchange.normal.obs;
  AppBarchange get isAppBarChange => this._isAppBarChange.value;
  set isAppBarChange(AppBarchange i) => this._isAppBarChange.value = i;

  late ContactList contactList;

  //Getter & Setter for Contact List
  RxList<Contact> _mobileContactList = RxList<Contact>.empty();
  List<Contact> get mobileContactsList => _mobileContactList;
  set mobileContactsList(Iterable<Contact> list) {
    _mobileContactList.addAll(list);
  }

  //Get Contacts
  Future getContacts() async {
    mobileContactsList =
        await ContactsService.getContacts(withThumbnails: false);
    Logger().i(
        "Here is total number of contacts =====>>>>> ${mobileContactsList.length}");
  }

  // search
  TextEditingController searchController = TextEditingController();

  RxList<Contact> _searchContactList = [Contact()].obs;
  List<Contact> get searchContactList => this._searchContactList;
  set searchContactList(List<Contact> contactList) =>
      this._searchContactList.assignAll(contactList);

  RxString _searchContacts = "".obs;
  String get searchContacts => this._searchContacts.value;
  set searchContacts(String v) => this._searchContacts.value = v;

  RxList<int> _groupMemberList = RxList.empty(growable: true);
  List<int> get groupMemberList => _groupMemberList;
  set setGroupMemberList(int singleValue) {
    _groupMemberList.add(singleValue);
  }

  int listLength = 0;

  RxMap<String, ContactUsers> contacts = <String, ContactUsers>{}.obs;
  RxList<ContactUsers> _totalList = RxList.empty();
  List<ContactUsers> get totalList => _totalList;
  set setTotalList(List<ContactUsers> list) {
    _totalList.addAll(list);
  }

  // setTotalList1(index, List<ContactUsers> list) {
  //   _totalList.insertAll(index, list);
  //   print(_totalList);
  // }

  RxList<ContactUsers> selectedContacts = RxList.empty(growable: true);

  PageController? pageController = PageController();

  ScrollController controller = ScrollController();

  var selectedPageIndex = 0.obs;
  bool get isLastPage => selectedPageIndex.value == totalList.length - 1;

  forwardAction() {
    if (isLastPage) {
      // Get.offNamed(Routes.SIGN_IN);
    } else
      pageController!.nextPage(duration: 300.milliseconds, curve: Curves.ease);
  }

  void _scrollListener() {
    // print(controller.position);
    // if (controller.position.extentAfter < 100) {
    //   setTotalList = ContactUsers.contacts.sublist(8, 15);
    // }
    // scrollController.addListener(() {
    //   setTotalList1(10, ContactUsers.contacts);
    //   if (scrollController.position.maxScrollExtent ==
    //       scrollController.position.pixels) {
    //     for (int i = 0; i < 8; i++) {
    //       listLength++;
    //       setTotalList1(listLength, ContactUsers.contacts);
    //       print(listLength);
    //       // update();
    //     }
    //   }
    // });
  }

  @override
  void onInit() {
    super.onInit();
    debugPrint(homeController.chatType);
    contactList = Get.arguments;
    mobileContactsList = homeController.mobileContactsList;
    setTotalList = ContactUsers.contacts;
    // scrollController.addListener(_scrollListener);
    // _scrollListener();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    scrollController.removeListener(_scrollListener);
    super.onClose();
  }
}
