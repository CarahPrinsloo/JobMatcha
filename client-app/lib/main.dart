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
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: RegisterLoginPage(),
      ),
    );
  }
}
