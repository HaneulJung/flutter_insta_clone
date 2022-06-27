import 'package:get/get.dart';
import 'package:instaclone/src/controller/auth_controller.dart';
import 'package:instaclone/src/controller/bottom_nav_controller.dart';
import 'package:instaclone/src/controller/home_controller.dart';
import 'package:instaclone/src/controller/mypage_controller.dart';
import 'package:instaclone/src/controller/upload_controller.dart';

class InitBinding extends Bindings{
  @override
  void dependencies() {
    Get.put(BottomNavController(), permanent: true);
    Get.put(AuthController(), permanent: true);
  }

  static additionalBinding() {
    Get.put(MyPageController(), permanent: true);
    Get.put(HomeController(), permanent: true);
  }
}