import 'package:client_app/theme/colors.dart';
import 'package:client_app/views/explore_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RootApp extends StatefulWidget {
  const RootApp({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _RootAppState();
}

class _RootAppState extends State<RootApp> {
  int pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: getAppBar(),
      body: getBody(),
    );
  }

  AppBar getAppBar() {
    var items = [
      (pageIndex == 0)
          ? "assets/images/explore_active_icon.svg"
          : "assets/images/explore_icon.svg",
      (pageIndex == 1)
          ? "assets/images/likes_active_icon.svg"
          : "assets/images/likes_icon.svg",
      (pageIndex == 2)
          ? "assets/images/chat_active_icon.svg"
          : "assets/images/chat_icon.svg",
      (pageIndex == 3)
          ? "assets/images/account_active_icon.svg"
          : "assets/images/account_icon.svg",
    ];

    return AppBar(
      backgroundColor: white,
      elevation: 0,
      title: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(items.length, (index) {
            return IconButton(
              onPressed: () {
                setState(() {
                  pageIndex = index;
                });
              },
              icon: SvgPicture.asset(items[index]),
            );
          }),
        ),
      ),
    );
  }

  Widget getBody() {
    return IndexedStack(
      index: pageIndex,
      children: [
        ExplorePage(),
        ExplorePage(),
        ExplorePage(),
        ExplorePage(),
      ],
    );
  }
}
