import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instaclone/src/components/image_data.dart';
import 'package:instaclone/src/controller/upload_controller.dart';
import 'package:photo_manager/photo_manager.dart';

class Upload extends GetView<UploadController> {
  Upload({Key? key}) : super(key: key);

  Widget _imagePreview() {
    var w = Get.width;
    return Obx(() => Container(
      width: w,
      height: w,
      color: Colors.grey,
      child: _photoWidget(controller.selectedImage.value, w.toInt(), true)
      ));
  }

  Widget _header() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              showModalBottomSheet(
                context: Get.context!,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20), topRight: Radius.circular(20))
                ),
                builder: (_) => Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Center(
                        child: Container(
                          margin: const EdgeInsets.only(top: 7),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.black54
                          ),
                          width: 40,
                          height: 4,
                        ),
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              ...List.generate(
                                controller.albums.length,
                                    (index) => GestureDetector(
                                      onTap: (){
                                        controller.changeAlbum(controller.albums[index]);
                                        Get.back();
                                      },
                                      child: Container(
                                  padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                                  child: Text(controller.albums[index].name),
                                ),
                                    )
                              ),
                            ],
                          ),
                        ),
                      )
                    ]
                  ),
                )
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Row(
                children: [
                  Obx(() => Text(
                    controller.headerTitle.value,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 18
                    ),
                  )),
                  const Icon(Icons.arrow_drop_down)
                ],
              ),
            ),
          ),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                decoration: BoxDecoration(
                  color: const Color(0xff808080),
                  borderRadius: BorderRadius.circular(30)
                ),
                child: Row(
                  children: [
                    ImageData(IconsPath.imageSelectIcon),
                    const SizedBox(width: 7),
                    const Text(
                      "여러 항목 선택",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(width: 5,),
              Container(
                padding: const EdgeInsets.all(6),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xff808080)
                ),
                child: ImageData(IconsPath.cameraIcon),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget _imageSelectList(){
    return Obx(() => GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        mainAxisSpacing: 1,
        crossAxisSpacing: 1,
        childAspectRatio: 1
      ),
      itemCount: controller.imgList.length,
      itemBuilder: (BuildContext context, int index){
        return GestureDetector(
          onTap: () {
            controller.changeSelectedImgae(controller.imgList[index]);
          },
          child: _photoWidget(controller.imgList[index], 200, false)
        );
      }
    ));
  }

  Widget _photoWidget(AssetEntity asset, int size, bool flag) {
    return FutureBuilder(
      future: asset.thumbnailDataWithSize(ThumbnailSize(size, size)),
      builder: (_, AsyncSnapshot<Uint8List?> snapshot){
        if (snapshot.hasData){
          if (flag){
            return Image.memory(
              snapshot.data!,
              fit: BoxFit.cover
            );
          }
          return Obx(() =>Opacity(
            opacity: asset == controller.selectedImage.value ? 0.3 : 1,
            child: Image.memory(
              snapshot.data!,
              fit: BoxFit.cover,)
          ));
        }
        else
        {
          return Container();
        }
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: GestureDetector(
          onTap: (){
            Get.back();
          },
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: ImageData(
              IconsPath.closeImage),
          ),
        ),
        title: const Text(
          "New post",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Colors.black
          ),
        ),
        actions: [
          GestureDetector(
            onTap: controller.gotoImageFilter,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: ImageData(IconsPath.nextImage, width: 50,),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _imagePreview(),
            _header(),
            _imageSelectList()
          ],
        ),
      ),
    );
  }
}
