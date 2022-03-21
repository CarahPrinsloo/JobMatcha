import 'package:client_app/models/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UserCard extends StatelessWidget {
  final User user;

  const UserCard({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 10,
        left: 20,
        right: 20,
      ),
      child: SizedBox(
        height: MediaQuery.of(context).size.height / 1.4,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            userCardMainPicture(),
            userCardGradient(),
            userCardUserDetails(context),
            Padding(
              padding: const EdgeInsets.only(
                bottom: 10,
                left: 20,
                right: 20,
              ),
              child: Container(
                alignment: Alignment.bottomRight,
                child: const Icon(
                  Icons.info_outline,
                  color: Colors.deepPurple,
                  size: 25,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Positioned userCardUserDetails(BuildContext context) {
    return Positioned(
      bottom: 30,
      left: 20,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${user.fullName}, ${user.age}',
            style: Theme.of(context)
                .textTheme
                .headline2!
                .copyWith(color: Colors.white),
          ),
          Text(
            user.jobTitle,
            style: Theme.of(context)
                .textTheme
                .headline3!
                .copyWith(color: Colors.white, fontWeight: FontWeight.normal),
          ),
        ],
      ),
    );
  }

  Container userCardGradient() {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          gradient: const LinearGradient(
            colors: [
              Color.fromARGB(200, 0, 0, 0),
              Color.fromARGB(0, 0, 0, 0),
            ],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
          )),
    );
  }

  Container userCardMainPicture() {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage(user.image[0]),
        ),
        borderRadius: BorderRadius.circular(5.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 4,
            blurRadius: 4,
            offset: const Offset(3, 3),
          ),
        ],
      ),
    );
  }
}