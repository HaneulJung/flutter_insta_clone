import 'package:cached_network_image/cached_network_image.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:instaclone/src/components/avatar_widget.dart';
import 'package:instaclone/src/components/image_data.dart';
import 'package:instaclone/src/model/post.dart';
import 'package:timeago/timeago.dart' as timeago;

class PostWidget extends StatelessWidget {
  final Post post;

  const PostWidget({Key? key, required this.post}) : super(key: key);

  Widget _header() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AvatarWidget(
            thumbPath: post.userInfo!.thumbnail!,
            type: AvatarType.TYPE3,
            nickName: post.userInfo!.nickname,
            size: 40,
          ),
          GestureDetector(
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ImageData(
                IconsPath.postMoreIcon,
                width: 30,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _image() {
    return CachedNetworkImage(
      imageUrl: post.thumbnail!
    );
  }

  Widget _infoCount(){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              ImageData(IconsPath.likeOffIcon, width: 65),
              SizedBox(width: 15),
              ImageData(IconsPath.replyIcon, width: 60),
              SizedBox(width: 15),
              ImageData(IconsPath.directMessage, width: 55),
            ],
          ),
          ImageData(IconsPath.bookMarkOffIcon, width: 50),
        ],
      ),
    );
  }

  Widget _infoDescription() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            "????????? ${post.likeCount??0}???",
            style: const TextStyle(
              fontWeight: FontWeight.bold
            ),
          ),
          ExpandableText(
            post.description??'',
            prefixText: post.userInfo!.nickname,
            onPrefixTap: () {
              print('cielo page move');
            },
            prefixStyle:const TextStyle(
              fontWeight: FontWeight.bold
            ),
            expandText: "?????????",
            collapseText: '??????',
            maxLines: 3,
            expandOnTextTap: true,
            collapseOnTextTap: true,
            linkColor: Colors.grey,
          )
        ],
      ),
    );
  }

  Widget _replytextBtn(){
    return GestureDetector(
      onTap: () {

      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Text(
          "?????? 199??? ?????? ??????",
          style: TextStyle(
            color: Colors.grey,
            fontSize: 13
          )
        ),
      ),
    );
  }

  Widget _dateAgo() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Text(
        timeago.format(post.createdAt!),
        style: const TextStyle(
          color: Colors.grey,
          fontSize: 11
        ),),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _header(),
          SizedBox(height: 15,),
          _image(),
          SizedBox(height: 15,),
          _infoCount(),
          SizedBox(height: 5,),
          _infoDescription(),
          SizedBox(height: 5,),
          _replytextBtn(),
          SizedBox(height: 5,),
          _dateAgo(),
        ],
      ),
    );
  }
}
