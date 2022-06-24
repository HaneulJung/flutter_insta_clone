import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instaclone/src/controller/bottom_nav_controller.dart';
import 'package:instaclone/src/pages/active_history.dart';
import 'package:instaclone/src/pages/home.dart';
import 'package:instaclone/src/pages/search.dart';
import 'package:instaclone/src/pages/upload.dart';

import 'components/image_data.dart';

class App extends GetView<BottomNavController> {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Obx(() => Scaffold(
        body: IndexedStack(
          index: controller.pageIndex.value,
          children: [
            const Home(),
            Navigator(
              key: controller.searchPageNavigationKey,
              onGenerateRoute: (routeSetting){
                return MaterialPageRoute(
                    builder: (context)=> const Search()
                );
              },
            ),
            // const Upload(),
            Container(),
            const ActiveHistory(),
            Container(
              child : Center(
                  child: Text("MYPAGE")
              ),
            ),
          ],
        ),

        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          currentIndex: controller.pageIndex.value,
          elevation: 0,
          onTap: controller.chageBottomNav,
          items: [
            BottomNavigationBarItem(
              icon: ImageData(IconsPath.homeOff),
              activeIcon: ImageData(IconsPath.homeOn),
              label: "home"
            ),
            BottomNavigationBarItem(
                icon: ImageData(IconsPath.searchOff),
                activeIcon: ImageData(IconsPath.searchOn),
                label: "search"
            ),
            BottomNavigationBarItem(
                icon: ImageData(IconsPath.uploadIcon),
                label: "upload"
            ),
            BottomNavigationBarItem(
                icon: ImageData(IconsPath.activeOff),
                activeIcon: ImageData(IconsPath.activeOn),
                label: "active"
            ),
            BottomNavigationBarItem(
                icon: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey),
                  width: 30,
                  height: 30,
                ),
                label: "avatar"
            ),
          ],
        ),
      ),),
      onWillPop: controller.willPopAction,
    );
  }
}
