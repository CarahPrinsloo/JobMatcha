import 'dart:html';

import 'package:client_app/controller/user_controller.dart';
import 'package:client_app/models/user.dart';
import 'package:client_app/widgets/home/choice_button.dart';
import 'package:client_app/widgets/home/custom_appbar.dart';
import 'package:client_app/widgets/home/user_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:loading_animations/loading_animations.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  User user;

  HomePage({Key? key, required this.user}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomePageState(user);
}

class _HomePageState extends State<HomePage> {
  User _user;

  _HomePageState(this._user);

  @override
  void initState() {
    super.initState();
    Provider.of<UserController>(context, listen: false).populateUsers();
  }

  @override
  Widget build(BuildContext context) {
    UserController controller = Provider.of<UserController>(context);

    return Scaffold(
      appBar: const CustomAppBar(),
      body: (controller.getIsSuccessfulResponse() != null &&
              controller.users.isNotEmpty)
          ? body(controller)
          : LoadingFlipping.circle(
              borderColor: Colors.indigo,
            ),
    );
  }

  Column body(UserController controller) {
    return Column(
      children: [
        Draggable(
          child: UserCard(user: controller.users[0]),
          feedback: UserCard(user: controller.users[0]),
          childWhenDragging: UserCard(user: controller.users[1]),
          onDragEnd: (drag) {
            if (drag.velocity.pixelsPerSecond.dx < 0) {
              print('Swiped left');
            } else {
              print('Swiped right');
            }
          },
        ),
      ],
    );
  }

  Padding buttons() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 8.0,
        horizontal: 60,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: const [
          ChoiceButton(
            width: 60,
            height: 60,
            size: 25,
            color: Colors.deepPurple,
            icon: Icons.clear_rounded,
            hasGradient: false,
          ),
          ChoiceButton(
            width: 80,
            height: 80,
            size: 30,
            color: Colors.white,
            icon: Icons.favorite,
            hasGradient: true,
          ),
          ChoiceButton(
            width: 60,
            height: 60,
            size: 25,
            color: Colors.deepPurple,
            icon: Icons.watch_later,
            hasGradient: false,
          ),
        ],
      ),
    );
  }
}
