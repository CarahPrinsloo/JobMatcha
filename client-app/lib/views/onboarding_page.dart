import 'package:client_app/widgets/onboarding/add_image_page.dart';
import 'package:client_app/widgets/onboarding/sign_up_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icon.dart';
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
    final userInfoFormKey = GlobalKey<FormState>();

    SignUpPage signUpPage =
        SignUpPage(controller: controller, formKey: userInfoFormKey);
    AddImagePage imagePage = AddImagePage();

    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(bottom: 80),
        child: PageView(
          controller: controller,
          children: [
            signUpPage,
            imagePage,
            page(Colors.deepPurple, "Page 3"),
          ],
        ),
      ),
      bottomSheet: bottomSheet(userInfoFormKey, signUpPage, imagePage),
    );
  }

  Container bottomSheet(GlobalKey<FormState> userInfoFormKey,
      SignUpPage signUpPage, AddImagePage imagePage) {
    return Container(
      height: 80,
      padding: const EdgeInsets.symmetric(horizontal: 80),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(width: 42),
          Center(
            child: pageIndicator(),
          ),
          TextButton(
            child: const Text("NEXT"),
            onPressed: () {
              if ((controller.page == 0 &&
                      _userFormDetailsCompleted(signUpPage, userInfoFormKey)) ||
                  (controller.page == 1 && imagePage.isImageAdded()) ||
                  (controller.page == 2)) {
                controller.nextPage(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeOut,
                );
              } else if (!imagePage.isImageAdded()) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("No image was selected."),
                  ),
                );
              }
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

  bool _userFormDetailsCompleted(
      SignUpPage signUpPage, GlobalKey<FormState> userInfoFormKey) {
    if (!(userInfoFormKey.currentState!.validate())) {
      return false;
    }
    userInfoFormKey.currentState!.save();

    String fullName = signUpPage.getFullName();
    String email = signUpPage.getEmailAddress();
    String jobTitle = signUpPage.getJobTitle();
    int age = signUpPage.getAge();

    return !(fullName == null || fullName.isEmpty) &&
        !(email == null || email.isEmpty) &&
        !(age == null && age <= 0) &&
        !(jobTitle == null || jobTitle.isEmpty);
  }
}
