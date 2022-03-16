import 'package:client_app/views/onboarding_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    title: 'JobMatcha',
    debugShowCheckedModeBanner: false,
    // initialRoute: OnboardingPage.routeName,
    home: OnboardingPage(),
  ));
}