import 'package:client_app/controller/user_controller.dart';
import 'package:client_app/models/education.dart';
import 'package:client_app/models/security/encryption.dart';
import 'package:client_app/models/user.dart';
import 'package:client_app/models/work_experience.dart';
import 'package:client_app/widgets/onboarding/bio_and_link_form.dart';
import 'package:client_app/widgets/onboarding/add_image_form.dart';
import 'package:client_app/widgets/onboarding/education/education_form.dart';
import 'package:client_app/widgets/onboarding/language/language_form.dart';
import 'package:client_app/widgets/onboarding/general_information_form.dart';
import 'package:client_app/widgets/onboarding/work_experience/work_experience_form.dart';
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
    GeneralInformationForm signUpPage = GeneralInformationForm(
      controller: controller,
      formKey: GlobalKey<FormState>(),
    );
    AddImageForm imagePage = AddImageForm();
    LanguageForm addLanguagePage = LanguageForm(
      formKey: GlobalKey<FormState>(),
    );
    BioAndLinkForm aboutMePage = BioAndLinkForm(formKey: GlobalKey<FormState>());
    EducationForm addEducationPage = EducationForm();
    WorkExperienceForm addWorkExperiencePage = WorkExperienceForm();

    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(bottom: 80),
        child: PageView(
          controller: controller,
          children: [
            signUpPage,
            imagePage,
            addLanguagePage,
            addEducationPage,
            addWorkExperiencePage,
            aboutMePage,
          ],
        ),
      ),
      bottomSheet: bottomSheet(
        signUpPage,
        imagePage,
        addLanguagePage,
        aboutMePage,
        addEducationPage,
        addWorkExperiencePage,
      ),
    );
  }

  Container bottomSheet(
    GeneralInformationForm signUpPage,
    AddImageForm imagePage,
    LanguageForm addLanguagePage,
    BioAndLinkForm aboutMePage,
    EducationForm addEducationPage,
    WorkExperienceForm addWorkExperiencePage,
  ) {
    return Container(
      height: 80,
      padding: const EdgeInsets.symmetric(horizontal: 80),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(width: 42),
          Center(
            child: _pageIndicator(),
          ),
          TextButton(
            child: const Text("NEXT"),
            onPressed: () async {
              if (_canRedirectToNextOnboardingPage(
                  signUpPage, imagePage, addLanguagePage)) {
                controller.nextPage(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeOut,
                );
              } else if (_isInvalidPasswordEntry(signUpPage)) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("The password entries do not match."),
                  ),
                );
              } else if (_isImageAdded(imagePage)) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("No image was selected."),
                  ),
                );
              } else if (_isComplete(aboutMePage)) {
                User user = _createUserFromInformation(
                  signUpPage,
                  aboutMePage,
                  addEducationPage,
                  addWorkExperiencePage,
                );

                UserController controller = UserController();
                await controller.addUser(user, context);
                _redirectIfOnboardingSuccessful(controller);
              }
            },
          ),
        ],
      ),
    );
  }

  SmoothPageIndicator _pageIndicator() {
    return SmoothPageIndicator(
      controller: controller,
      count: 3,
    );
  }

  User _createUserFromInformation(
    GeneralInformationForm signUpPage,
    BioAndLinkForm aboutMePage,
    EducationForm addEducationPage,
    WorkExperienceForm addWorkExperiencePage,
  ) {
    String email = signUpPage.getState()!.getEmailAddress()!;
    String password = Encryption.encrypt(
      signUpPage.getState()!.getPassword()!,
    )!;
    String fullName = signUpPage.getState()!.getFullName()!;
    int age = signUpPage.getState()!.getAge()!;
    String bio = aboutMePage.getState().getBio() ?? "";
    String jobTitle = signUpPage.getState()!.getJobTitle() ?? "";
    List<Education> education =
        addEducationPage.getState()!.getCopyOfProvidedEducation();
    List<WorkExperience> workExperience =
        addWorkExperiencePage.getState()!.getCopyOfCompletedWorkExperience();
    String projectsLink = aboutMePage.getState().getGithubLink()!;

    User user = User(
      email: email,
      password: password,
      fullName: fullName,
      age: age,
      image: "",
      bio: bio,
      jobTitle: jobTitle,
      education: education,
      workExperience: workExperience,
      projectsLink: projectsLink,
    );
    return user;
  }

  bool _isComplete(BioAndLinkForm aboutMePage) {
    return controller.page == 5 && _aboutMeDetailsCompleted(aboutMePage);
  }

  bool _isImageAdded(AddImageForm imagePage) {
    return imagePage.getState() != null &&
        !imagePage.getState()!.isImageAdded();
  }

  bool _isInvalidPasswordEntry(GeneralInformationForm signUpPage) {
    return controller.page == 0 &&
        signUpPage.getState()!.getPassword() != null &&
        signUpPage.getState()!.getConfirmedPassword() != null &&
        !signUpPage.getState()!.isPasswordValid();
  }

  bool _canRedirectToNextOnboardingPage(
    GeneralInformationForm signUpPage,
    AddImageForm imagePage,
    LanguageForm addLanguagePage,
  ) {
    return (controller.page == 0 && _userFormDetailsCompleted(signUpPage)) ||
        (imagePage.getState() != null &&
            controller.page == 1 &&
            imagePage.getState()!.isImageAdded()) ||
        (addLanguagePage.getState() != null &&
            controller.page == 2 &&
            addLanguagePage.getState()!.isAdded()) ||
        (controller.page != null &&
            controller.page! > 2 &&
            controller.page != 5);
  }

  void _redirectIfOnboardingSuccessful(UserController controller) {
    if (controller.getIsSuccessfulResponse() != null &&
        controller.getIsSuccessfulResponse() == true) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Could not register."),
        ),
      );
    }
  }

  bool _userFormDetailsCompleted(GeneralInformationForm signUpPage) {
    if (!(signUpPage.getKey().currentState!.validate())) {
      return false;
    }
    signUpPage.getKey().currentState!.save();

    if (signUpPage.getState() == null) {
      return false;
    }

    String? fullName = signUpPage.getState()!.getFullName();
    String? email = signUpPage.getState()!.getEmailAddress();
    String? jobTitle = signUpPage.getState()!.getJobTitle();
    int? age = signUpPage.getState()!.getAge();

    return !(fullName == null || fullName.isEmpty) &&
        !(email == null || email.isEmpty) &&
        !(age == null || (age != null && age <= 0)) &&
        !(jobTitle == null || jobTitle.isEmpty) &&
        (signUpPage.getState()!.isPasswordValid());
  }

  bool _aboutMeDetailsCompleted(BioAndLinkForm aboutMePage) {
    if (!(aboutMePage.getState().getFormKey().currentState!.validate())) {
      return false;
    }
    aboutMePage.getState().getFormKey().currentState!.save();

    String? bio = aboutMePage.getState().getBio();
    String? link = aboutMePage.getState().getGithubLink();

    return !(bio == null || bio.isEmpty) && !(link == null || link.isEmpty);
  }
}
