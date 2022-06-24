import 'package:flutter/material.dart';
import 'package:instaclone/src/components/avatar_widget.dart';

class ActiveHistory extends StatelessWidget {
  const ActiveHistory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    Widget _activeitemOne(){
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: Row(
          children: [
            AvatarWidget(
              thumbPath: "https://letsenhance.io/static/334225cab5be263aad8e3894809594ce/75c5a/MainAfter.jpg",
              size: 40,
              type: AvatarType.TYPE2
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text.rich(
                TextSpan(
                  text: 'Cielo',
                  style: TextStyle(
                    fontWeight: FontWeight.bold
                  ),
                  children: [
                    TextSpan(
                      text: '님이 회원님의 게시물을 좋아합니다.',
                      style: TextStyle(
                        fontWeight: FontWeight.normal
                      ),
                    ),
                    TextSpan(
                      text: ' 5 일전',
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 13,
                        color: Colors.black54
                      ),
                    )
                  ]
                )
              )
            )
          ],
        ),
      );
    }

    Widget _newRecentlyActiveView(String title) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16
              ),
            ),
            SizedBox(height: 15),
            _activeitemOne(),
            _activeitemOne(),
            _activeitemOne(),
            _activeitemOne(),
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text(
          "활동",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.black
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _newRecentlyActiveView("오늘"),
            _newRecentlyActiveView("이번 주"),
            _newRecentlyActiveView("이번 달"),
          ],
        ),
      ),
    );
  }
}
