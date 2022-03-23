import 'package:client_app/views/onboarding_page.dart';
import 'package:client_app/views/register_login_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'controller/user_controller.dart';

void main() {
  runApp(
    ChangeNotifierProvider(create: (_) => UserController(), child: const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        // Define the default brightness and colors.
        primaryColor: Colors.indigo[700],

        // Define the default font family.
        fontFamily: 'Georgia',

        // Define the default `TextTheme`. Use this to specify the default
        // text styling for headlines, titles, bodies of text, and more.
        textTheme: const TextTheme(
          headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
          headline6: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
          bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: const Scaffold(
        body: RegisterLoginPage(),
      ),
    );
  }
}
