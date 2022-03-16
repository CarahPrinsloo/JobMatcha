import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({Key? key}) : super(key: key);

  @override
  _OnboardingPageState createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final controller = PageController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(bottom: 80),
        child: PageView(
          controller: controller,
          children: [
            page(Colors.deepPurpleAccent, "Page 1"),
            page(Colors.deepPurple, "Page 2"),
            page(Colors.purple, "Page 3"),
          ],
        ),
      ),
      bottomSheet: bottomSheet(),
    );
  }

  Container bottomSheet() {
    return Container(
      height: 80,
      padding: const EdgeInsets.symmetric(horizontal: 80),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextButton(
            child: const Text("SKIP"),
            onPressed: () => controller.jumpToPage(2),
          ),
          Center(
            child: pageIndicator(),
          ),
          TextButton(
            child: const Text("NEXT"),
            onPressed: () {
              controller.nextPage(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeOut,
              );
            },
          ),
        ],
      ),
    );
  }

  SmoothPageIndicator pageIndicator() {
    return SmoothPageIndicator(
              controller: controller,
              count: 3,
              onDotClicked: (index) => controller.animateToPage(
                  index,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeIn,
              ),
            );
  }

  Container page(Color color, String text) {
    return Container(
            color: color,
            child: Center(
              child: Text(text),
            ),
          );
  }
}
