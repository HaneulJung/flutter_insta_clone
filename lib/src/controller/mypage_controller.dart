import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instaclone/src/controller/auth_controller.dart';
import 'package:instaclone/src/model/instagram_user.dart';

class MyPageController extends GetxController with GetTickerProviderStateMixin{

  late TabController tabController;
  Rx<IUser> targetUser = IUser().obs;

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 2, vsync: this);
    _loadData();
  }

  void setTargetUser(){
    var uid = Get.parameters['targetUid'];
    if (uid == null){
      targetUser(AuthController.to.user.value);
    }
    else{

    }
  }

  void _loadData(){
    setTargetUser();
  }
}