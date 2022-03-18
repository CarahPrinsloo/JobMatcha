import 'package:client_app/widgets/onboarding/about_me_page.dart';
import 'package:client_app/widgets/onboarding/add_education/add_education_page.dart';
import 'package:client_app/widgets/onboarding/add_language/add_language_page.dart';
import 'package:client_app/widgets/onboarding/add_image_page.dart';
import 'package:client_app/widgets/onboarding/add_work_experience/add_work_experience_page.dart';
import 'package:client_app/widgets/onboarding/sign_up_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'home_page.dart';

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
    SignUpPage signUpPage =
        SignUpPage(controller: controller, formKey: GlobalKey<FormState>());
    AddImagePage imagePage = AddImagePage();
    AddLanguagePage addLanguagePage = AddLanguagePage(formKey: GlobalKey<FormState>());
    AboutMePage aboutMePage = AboutMePage(formKey: GlobalKey<FormState>());

    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(bottom: 80),
        child: PageView(
          controller: controller,
          children: [
            signUpPage,
            imagePage,
            addLanguagePage,
            const AddEducationPage(),
            const AddWorkExperiencePage(),
            aboutMePage,
          ],
        ),
      ),
      bottomSheet: bottomSheet(signUpPage, imagePage, addLanguagePage, aboutMePage),
    );
  }

  Container bottomSheet(SignUpPage signUpPage, AddImagePage imagePage, AddLanguagePage addLanguagePage, AboutMePage aboutMePage) {
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
                      _userFormDetailsCompleted(signUpPage)) ||
                  (controller.page == 1 && imagePage.getState().isImageAdded()) ||
                  (controller.page == 2 && addLanguagePage.state.isAdded()) ||
                  (controller.page != null && controller.page! > 2 && controller.page != 5)
              ) {
                controller.nextPage(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeOut,
                );
              } else if (!imagePage.getState().isImageAdded()) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("No image was selected."),
                  ),
                );
              } else if (controller.page == 5 && _aboutMeDetailsCompleted(aboutMePage)) {
                // TODO: add user to server DB
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const HomePage()),
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

  bool _userFormDetailsCompleted(SignUpPage signUpPage) {
    if (!(signUpPage.getKey().currentState!.validate())) {
      return false;
    }
    signUpPage.getKey().currentState!.save();

    String fullName = signUpPage.getState().getFullName();
    String email = signUpPage.getState().getEmailAddress();
    String jobTitle = signUpPage.getState().getJobTitle();
    int age = signUpPage.getState().getAge();

    return !(fullName == null || fullName.isEmpty) &&
        !(email == null || email.isEmpty) &&
        !(age == null && age <= 0) &&
        !(jobTitle == null || jobTitle.isEmpty);
  }

  bool _aboutMeDetailsCompleted(AboutMePage aboutMePage) {
    if (!(aboutMePage.getState().formKey.currentState!.validate())) {
      return false;
    }
    aboutMePage.getState().formKey.currentState!.save();

    String? bio = aboutMePage.getState().getBio();
    String? link = aboutMePage.getState().getGithubLink();

    return !(bio == null || bio.isEmpty) &&
        !(link == null || link.isEmpty);
  }
}
