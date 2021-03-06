import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instaclone/src/controller/upload_controller.dart';

import '../components/message_popup.dart';
import '../pages/upload.dart';

enum PageName { HOME, SEARCH, UPLOAD, ACTIVITY, MYPAGE }

class BottomNavController extends GetxController{
  static BottomNavController get to => Get.find();
  RxInt pageIndex = 0.obs;
  GlobalKey<NavigatorState> searchPageNavigationKey =
      GlobalKey<NavigatorState>();
  List<int> bottomHistory = [ 0 ];

  void chageBottomNav(int value, {bool hasGesture = true}) {
    var page = PageName.values[value];
    switch (page){
      case PageName.UPLOAD:
        Get.to(() => Upload(), 
            binding: BindingsBuilder(() {
              Get.put(UploadController());
            })
        );
        break;
      case PageName.HOME:
      case PageName.SEARCH:
      case PageName.ACTIVITY:
      case PageName.MYPAGE:
        _changePage(value, hasGesture: hasGesture);
        break;
    }
  }

  void _changePage(int value, {bool hasGesture = true}){
    pageIndex(value);
    if (!hasGesture) return;
    if (bottomHistory.last != value){
      bottomHistory.add(value);
      print(bottomHistory);
    }
    // if (bottomHistory.contains(value)){
    //   bottomHistory.remove(value);
    // }
  }

  Future<bool> willPopAction() async {
    if (bottomHistory.length == 1){
      showDialog(
        context: Get.context!,
        builder: (context) => MessagePopup(
          title: "시스템",
          message: "종료하시겠습니까?",
          okCallback: () {
            exit(0);
          },
          cancelCallback: Get.back,
        )
      );
      print('exit');
      return true;
    }
    else{
      var page = PageName.values[bottomHistory.last];
      if (page == PageName.SEARCH){
        var result = await searchPageNavigationKey.currentState!.maybePop();
        if (result) return false;
      }

      print('goto before page');
      bottomHistory.removeLast();
      var index = bottomHistory.last;
      chageBottomNav(index, hasGesture: false);
      print(bottomHistory);
      return false;
    }
  }
}