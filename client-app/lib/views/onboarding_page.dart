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
  final _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    GeneralInformationForm generalInfoForm = GeneralInformationForm(
      controller: _pageController,
      formKey: GlobalKey<FormState>(),
    );
    AddImageForm addImageForm = AddImageForm();
    LanguageForm addLanguageForm = LanguageForm(
      formKey: GlobalKey<FormState>(),
    );
    BioAndLinkForm bioAndLinkForm = BioAndLinkForm(formKey: GlobalKey<FormState>());
    EducationForm educationForm = EducationForm();
    WorkExperienceForm workExperienceForm = WorkExperienceForm();

    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(bottom: 80),
        child: PageView(
          controller: _pageController,
          children: [
            generalInfoForm,
            addImageForm,
            addLanguageForm,
            educationForm,
            workExperienceForm,
            bioAndLinkForm,
          ],
        ),
      ),
      bottomSheet: bottomSheet(
        generalInfoForm,
        addImageForm,
        addLanguageForm,
        bioAndLinkForm,
        educationForm,
        workExperienceForm,
      ),
    );
  }

  Container bottomSheet(
    GeneralInformationForm generalInfoForm,
    AddImageForm addImageForm,
    LanguageForm languageForm,
    BioAndLinkForm bioAndLinkForm,
    EducationForm educationForm,
    WorkExperienceForm workExperienceForm,
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
                  generalInfoForm, addImageForm, languageForm)) {
                _pageController.nextPage(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeOut,
                );
              } else if (_isInvalidPasswordEntry(generalInfoForm)) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("The password entries do not match."),
                  ),
                );
              } else if (_isImageAdded(addImageForm)) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("No image was selected."),
                  ),
                );
              } else if (_isComplete(bioAndLinkForm)) {
                User user = _createUserFromInformation(
                  generalInfoForm,
                  bioAndLinkForm,
                  educationForm,
                  workExperienceForm,
                );

                UserController controller = UserController();
                await controller.addUser(user);
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
      controller: _pageController,
      count: 3,
    );
  }

  User _createUserFromInformation(
      GeneralInformationForm generalInfoForm,
      BioAndLinkForm bioAndLinkForm,
      EducationForm educationForm,
      WorkExperienceForm workExperienceForm,
      ) {

    GeneralInformationFormState generalInfoFormState = generalInfoForm.getState()!;
    // General user information
    String email = generalInfoFormState.getEmailAddress()!;
    String password = Encryption.encrypt(
      generalInfoFormState.getPassword()!,
    )!;
    String fullName = generalInfoFormState.getFullName()!;
    int age = generalInfoFormState.getAge()!;
    String bio = bioAndLinkForm.getState().getBio()!;

    // Work related Information
    String jobTitle = generalInfoFormState.getJobTitle()!;
    List<Education> education =
    educationForm.getState()!.getCopyOfProvidedEducation();
    List<WorkExperience> workExperience =
    workExperienceForm.getState()!.getCopyOfCompletedWorkExperience();
    String projectsLink = bioAndLinkForm.getState().getGithubLink()!;

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

  bool _isComplete(BioAndLinkForm bioAndLinkForm) {
    return _pageController.page == 5 && _bioAndProjectLinkCompleted(bioAndLinkForm);
  }

  bool _isImageAdded(AddImageForm addImageForm) {
    return addImageForm.getState() != null &&
        !addImageForm.getState()!.isImageAdded();
  }

  bool _isInvalidPasswordEntry(GeneralInformationForm generalInfoForm) {
    return _pageController.page == 0 &&
        generalInfoForm.getState()!.getPassword() != null &&
        generalInfoForm.getState()!.getConfirmedPassword() != null &&
        !generalInfoForm.getState()!.isPasswordValid();
  }

  bool _canRedirectToNextOnboardingPage(
    GeneralInformationForm generalInfoForm,
    AddImageForm addImageForm,
    LanguageForm languageForm,
  ) {
    return (_pageController.page == 0 && _userFormDetailsCompleted(generalInfoForm)) ||
        (addImageForm.getState() != null &&
            _pageController.page == 1 &&
            addImageForm.getState()!.isImageAdded()) ||
        (languageForm.getState() != null &&
            _pageController.page == 2 &&
            languageForm.getState()!.isAdded()) ||
        (_pageController.page != null &&
            _pageController.page! > 2 &&
            _pageController.page != 5);
  }

  void _redirectIfOnboardingSuccessful(UserController controller) {
    if (controller.getIsSuccessfulResponse() != null &&
        controller.getIsSuccessfulResponse()!) {
      controller.resetIsSuccessfulResponse();

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

  bool _userFormDetailsCompleted(GeneralInformationForm generalInfoForm) {
    if (!(generalInfoForm.getKey().currentState!.validate())) {
      return false;
    }
    generalInfoForm.getKey().currentState!.save();

    if (generalInfoForm.getState() == null) {
      return false;
    }

    String? fullName = generalInfoForm.getState()!.getFullName();
    String? email = generalInfoForm.getState()!.getEmailAddress();
    String? jobTitle = generalInfoForm.getState()!.getJobTitle();
    int? age = generalInfoForm.getState()!.getAge();

    return !(fullName == null || fullName.isEmpty) &&
        !(email == null || email.isEmpty) &&
        !(age == null || (age != null && age <= 0)) &&
        !(jobTitle == null || jobTitle.isEmpty) &&
        (generalInfoForm.getState()!.isPasswordValid());
  }

  bool _bioAndProjectLinkCompleted(BioAndLinkForm bioAndLinkForm) {
    if (!(bioAndLinkForm.getState().getFormKey().currentState!.validate())) {
      return false;
    }
    bioAndLinkForm.getState().getFormKey().currentState!.save();

    String? bio = bioAndLinkForm.getState().getBio();
    String? link = bioAndLinkForm.getState().getGithubLink();

    return !(bio == null || bio.isEmpty) && !(link == null || link.isEmpty);
  }
}
