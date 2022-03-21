import 'dart:convert';
import 'dart:typed_data';

import 'package:client_app/controller/user_controller.dart';
import 'package:client_app/models/user.dart';
import 'package:client_app/widgets/onboarding/about_me_page.dart';
import 'package:client_app/widgets/onboarding/add_education/add_education_page.dart';
import 'package:client_app/widgets/onboarding/add_language/add_language_page.dart';
import 'package:client_app/widgets/onboarding/add_image_page.dart';
import 'package:client_app/widgets/onboarding/add_work_experience/add_work_experience_page.dart';
import 'package:client_app/widgets/onboarding/sign_up_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pointycastle/api.dart';
import 'package:pointycastle/block/aes_fast.dart';
import 'package:pointycastle/block/modes/cbc.dart';
import 'package:pointycastle/padded_block_cipher/padded_block_cipher_impl.dart';
import 'package:pointycastle/paddings/pkcs7.dart';
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
    AddLanguagePage addLanguagePage =
        AddLanguagePage(formKey: GlobalKey<FormState>());
    AboutMePage aboutMePage = AboutMePage(formKey: GlobalKey<FormState>());
    AddEducationPage addEducationPage = AddEducationPage();
    AddWorkExperiencePage addWorkExperiencePage = AddWorkExperiencePage();

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
      bottomSheet:
          bottomSheet(signUpPage, imagePage, addLanguagePage, aboutMePage, addEducationPage, addWorkExperiencePage),
    );
  }

  Container bottomSheet(SignUpPage signUpPage, AddImagePage imagePage,
      AddLanguagePage addLanguagePage, AboutMePage aboutMePage, AddEducationPage addEducationPage, AddWorkExperiencePage addWorkExperiencePage) {
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
            onPressed: () async {
              if ((controller.page == 0 && _userFormDetailsCompleted(signUpPage)) ||
                  (imagePage.getState() != null && controller.page == 1 && imagePage.getState()!.isImageAdded()) ||
                  (addLanguagePage.getState() != null && controller.page == 2 && addLanguagePage.getState()!.isAdded()) ||
                  (controller.page != null && controller.page! > 2 && controller.page != 5)) {
                controller.nextPage(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeOut,
                );
              } else if (
              controller.page == 0 && signUpPage.getState()!.getPassword() != null &&
                  signUpPage.getState()!.getConfirmedPassword() != null &&
                  !signUpPage.getState()!.isPasswordValid()
              ) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("The password entries do not match."),
                  ),
                );
              } else if (imagePage.getState() != null &&
                  !imagePage.getState()!.isImageAdded()) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("No image was selected."),
                  ),
                );
              } else if (controller.page == 5 &&
                  _aboutMeDetailsCompleted(aboutMePage)) {
                User user = User(
                  email: signUpPage.getState()!.getEmailAddress()!,
                  password: _encrypt(signUpPage.getState()!.getPassword()!)!,
                  fullName: signUpPage.getState()!.getFullName()!,
                  age: signUpPage.getState()!.getAge()!,
                  image: "",
                  bio: aboutMePage.getState().getBio() ?? "",
                  jobTitle: signUpPage.getState()!.getJobTitle() ?? "",
                  education: addEducationPage.getState()!.getEducation(),
                  workExperience: addWorkExperiencePage.getState()!.getWorkExperience(),
                  projectsLink: aboutMePage.getState().getGithubLink()!,
                );

                UserController controller = UserController();
                await controller.addUser(user, context);
                redirectIfOnboardingSuccessful(controller);
              }
            },
          ),
        ],
      ),
    );
  }

  void redirectIfOnboardingSuccessful(UserController controller) {
    if (
    controller.getIsSuccessfulResponse() != null
        && controller.getIsSuccessfulResponse() == true
    ) {
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

  final Uint8List _key = Uint8List.fromList(<int>[
    0x5a,
    0x22,
    0x62,
    0x7e,
    0x64,
    0x45,
    0x52,
    0x75,
    0x58,
    0x21,
    0x71,
    0x26,
    0x7a,
    0x6a,
    0x2d,
    0x2c,
    0x3e,
    0x64,
    0x7d,
    0x36,
    0x61,
    0x45,
    0x77,
    0x2d,
    0x5f,
    0x39,
    0x26,
    0x78,
    0x4a,
    0x5e,
    0x40,
    0x38
  ]);

  final Uint8List _iv = Uint8List.fromList(
    <int>[
      0xda,
      0x39,
      0xa3,
      0xee,
      0x5e,
      0x6b,
      0x4b,
      0x0d,
      0x32,
      0x55,
      0xbf,
      0xef,
      0x95,
      0x60,
      0x18,
      0x90
    ],
  );

  String? _encrypt(String text) {
    List<int> temp = utf8.encode(text);
    Uint8List bytes = Uint8List.fromList(temp);

    Uint8List? unit8 = _encryptList(bytes);
    if (unit8 == null) {
      return null;
    }

    return base64Encode(unit8);
  }

  Uint8List? _encryptList(Uint8List data) {
    final CBCBlockCipher cbcCipher = CBCBlockCipher(AESFastEngine());
    final ParametersWithIV<KeyParameter> ivParams =
    ParametersWithIV<KeyParameter>(KeyParameter(_key), _iv);
    final PaddedBlockCipherParameters<ParametersWithIV<KeyParameter>, Null>
    paddingParams =
    PaddedBlockCipherParameters<ParametersWithIV<KeyParameter>, Null>(
        ivParams, null);

    final PaddedBlockCipherImpl paddedCipher =
    PaddedBlockCipherImpl(PKCS7Padding(), cbcCipher);
    paddedCipher.init(true, paddingParams);

    try {
      return paddedCipher.process(data);
    } catch (e) {
      print(e);
      return null;
    }
  }

  String? decrypt(String data) {
    Uint8List? unit8 = decryptList(base64Decode(data));
    if (unit8 == null) {
      return null;
    }

    return utf8.decode(unit8);
  }

  Uint8List? decryptList(Uint8List data) {
    final CBCBlockCipher cbcCipher = CBCBlockCipher(AESFastEngine());
    final ParametersWithIV<KeyParameter> ivParams =
    ParametersWithIV<KeyParameter>(KeyParameter(_key), _iv);
    final PaddedBlockCipherParameters<ParametersWithIV<KeyParameter>, Null>
    paddingParams =
    PaddedBlockCipherParameters<ParametersWithIV<KeyParameter>, Null>(
        ivParams, null);
    final PaddedBlockCipherImpl paddedCipher =
    PaddedBlockCipherImpl(PKCS7Padding(), cbcCipher);
    paddedCipher.init(false, paddingParams);

    try {
      return paddedCipher.process(data);
    } catch (e) {
      print(e);
      return null;
    }
  }

  bool _userFormDetailsCompleted(SignUpPage signUpPage) {
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

  bool _aboutMeDetailsCompleted(AboutMePage aboutMePage) {
    if (!(aboutMePage.getState().formKey.currentState!.validate())) {
      return false;
    }
    aboutMePage.getState().formKey.currentState!.save();

    String? bio = aboutMePage.getState().getBio();
    String? link = aboutMePage.getState().getGithubLink();

    return !(bio == null || bio.isEmpty) && !(link == null || link.isEmpty);
  }
}
