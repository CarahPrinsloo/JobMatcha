import 'package:client_app/controller/user_controller.dart';
import 'package:client_app/models/security/encryption.dart';
import 'package:client_app/models/user.dart';
import 'package:client_app/views/onboarding_page.dart';
import 'package:flutter/material.dart';

import 'home_page.dart';

class RegisterLoginPage extends StatefulWidget {
  const RegisterLoginPage({Key? key}) : super(key: key);

  @override
  State<RegisterLoginPage> createState() => _RegisterLoginPageState();
}

class _RegisterLoginPageState extends State<RegisterLoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;

    return Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: <Widget>[
            _title(),
            _signInTitle(),
            _emailTextField(),
            _passwordTextField(),
            SizedBox(height: height * 0.05),
            _loginElevatedButton(),
            _signUpRow(context),
          ],
        ));
  }

  Container _title() {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(10),
      child: const Text(
        'JobMatcha',
        style: TextStyle(
          color: Colors.deepPurpleAccent,
          fontWeight: FontWeight.w500,
          fontSize: 30,
        ),
      ),
    );
  }

  Container _signInTitle() {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(10),
      child: const Text(
        'Sign in',
        style: TextStyle(
          fontSize: 20,
          color: Colors.deepPurpleAccent,
        ),
      ),
    );
  }

  Container _emailTextField() {
    return Container(
      padding: const EdgeInsets.all(10),
      child: TextField(
        style: const TextStyle(
          color: Colors.deepPurpleAccent,
        ),
        controller: _emailController,
        decoration: const InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.deepPurple, width: 1.1),
          ),
          labelText: 'Email',
          labelStyle: TextStyle(
            color: Colors.deepPurple,
          ),
        ),
      ),
    );
  }

  Container _passwordTextField() {
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
      child: TextField(
        style: const TextStyle(
          color: Colors.deepPurpleAccent,
        ),
        obscureText: true,
        controller: _passwordController,
        decoration: const InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.deepPurple, width: 1.1),
          ),
          labelText: 'Password',
          labelStyle: TextStyle(
            color: Colors.deepPurple,
          ),
        ),
      ),
    );
  }

  Container _loginElevatedButton() {
    return Container(
      height: 50,
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Colors.deepPurple,
        ),
        child: const Text(
          'Login',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        onPressed: () {
          _loginUser();
        },
      ),
    );
  }

  Row _signUpRow(BuildContext context) {
    return Row(
      children: <Widget>[
        const Text('Do not have an account?'),
        TextButton(
          child: const Text(
            'Sign up',
            style: TextStyle(
              fontSize: 20,
              color: Colors.deepPurple,
            ),
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const OnboardingPage()),
            );
          },
        )
      ],
      mainAxisAlignment: MainAxisAlignment.center,
    );
  }

  void _loginUser() async {
    UserController controller = UserController();

    if (_emailController.text.isEmpty || _passwordController.text.isEmpty || (_emailController.text.isNotEmpty && !_isValidEmail(_emailController.text))) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Required: Fill in your login details."),
        ),
      );
      return;
    }

    String? password = Encryption.encrypt(_passwordController.text);
    if (password == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Internal server error - try again."),
        ),
      );
      return;
    }

    User? user = await controller.getUser(_emailController.text);
    bool invalidLogin = user == null ||
        !controller.getIsSuccessfulResponse()! ||
        (user != null && user.getPassword() != password);

    if (invalidLogin) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Invalid login information."),
        ),
      );
      controller.resetIsSuccessfulResponse();
      return;
    }

    controller.resetIsSuccessfulResponse();
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => HomePage(user: user)),
    );
  }

  bool _isValidEmail(String email) {
    return RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
  }
}
