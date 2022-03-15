import 'dart:html';

import 'package:client_app/data/explore_json.dart';
import 'package:client_app/data/icons.dart';
import 'package:client_app/theme/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_tindercard/flutter_tindercard.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  List itemsTemp = [];
  int itemLength = 0;

  @override
  void initState() {
    super.initState();
    setState(() {
      itemsTemp = explore_json;
      itemLength = explore_json.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: getBody(),
      bottomSheet: getFooter(),
    );
  }

  Widget getFooter() {
    var size = MediaQuery
        .of(context)
        .size;

    return Container(
      width: size.width,
      height: 120,
      decoration: const BoxDecoration(color: white),
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(item_icons.length, (index) {
            return getContainer(
              item_icons[index]["icon"],
              item_icons[index]["size"],
              item_icons[index]["icon_size"]
            );
          }),
        ),
      ),
    );
  }

  Container getContainer(String svgPath, double size, double iconSize) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: white,
          boxShadow: [BoxShadow(
            color: grey.withOpacity(0.1),
            spreadRadius: 5,
            blurRadius: 10,
          )
          ]
      ),
      child: Center(
        child: SvgPicture.asset(
          svgPath,
          width: iconSize,
        ),
      ),
    );
  }

  Widget getBody() {
    var size = MediaQuery
        .of(context)
        .size;

    return Padding(
      padding: const EdgeInsets.only(bottom: 120),
      child: Container(
        height: size.height,
        child: TinderSwapCard(
          maxWidth: size.width,
          maxHeight: size.height * 0.75,
          minWidth: size.width * 0.75,
          minHeight: size.height * 0.6,
          cardBuilder: (context, index) => Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              boxShadow: [BoxShadow(
                color: grey.withOpacity(0.3),
                blurRadius: 5,
                spreadRadius: 2,
              )],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Stack(
                children: [
                  Container(
                    width: size.width,
                    height: size.height,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                          itemsTemp[index]['img']
                        ),
                        fit: BoxFit.cover
                      ),
                    ),
                  ),
                  Container(
                    width: size.width,
                    height: size.height,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          black.withOpacity(0.25),
                          black.withOpacity(0),
                        ],
                        end: Alignment.topCenter,
                        begin: Alignment.bottomCenter,
                      )
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: size.width * 0.75,
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                          itemsTemp[index]["name"],
                                        style: const TextStyle(
                                          fontSize: 24,
                                          color: white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      )
                                    ],
                                  )
                                ],
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          totalNum: itemLength,
        ),
      ),
    );
  }
}
