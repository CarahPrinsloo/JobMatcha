import 'package:client_app/models/user.dart';
import 'package:client_app/widgets/home/choice_button.dart';
import 'package:client_app/widgets/home/custom_appbar.dart';
import 'package:client_app/widgets/home/user_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<User> users = [
    const User(
      fullName: "Jules Biden",
      age: 32,
      image: "images/girls/img_1.jpeg",
      bio: "Live Love Laugh",
      jobTitle: "Software Developer",
      education: [],
      workExperience: [],
      projectsLink: "",
    ),
    const User(
      fullName: "Jake Biden",
      age: 22,
      image: "images/girls/img_2.jpeg",
      bio: "This is my bio",
      jobTitle: "Full Stack Software Developer",
      education: [],
      workExperience: [],
      projectsLink: "",
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: Column(
        children: [
          Draggable(
            child: UserCard(user: users[0]),
            feedback: UserCard(user: users[0]),
            childWhenDragging: UserCard(user: users[1]),
            onDragEnd: (drag) {
              if (drag.velocity.pixelsPerSecond.dx < 0) {
                print('Swiped left');
              } else {
                print('Swiped right');
              }
            },
          ),
        ],
      ),
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
