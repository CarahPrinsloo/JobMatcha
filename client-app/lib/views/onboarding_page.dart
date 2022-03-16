import 'package:client_app/views/home_page.dart';
import 'package:dropdown_formfield/dropdown_formfield.dart';
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
            const SignUpPage(),
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

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final formKey = GlobalKey<FormState>(); //key for form

  late String email;
  late String fullName;
  late int age;
  late String jobTitle;

  @override
  void initState() {
    super.initState();
    jobTitle = "";
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;

    return Container(
      padding: const EdgeInsets.only(left: 40, right: 40),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: height * 0.04),
            const Text(
              "WELCOME",
              style: TextStyle(fontSize: 30, color: Colors.deepPurple),
            ),
            SizedBox(height: height * 0.05),
            TextFormField(
              decoration: const InputDecoration(
                labelText: "Enter your email address",
              ),
              validator: (value) {
                if (value != null && value.isNotEmpty && _isValidEmail(value)) {
                  email = value;
                  return null;
                }
                email = "";
                return "Required: Enter a valid email address";
              },
            ),
            SizedBox(height: height * 0.05),
            TextFormField(
              decoration: const InputDecoration(
                labelText: "Enter your full name",
              ),
              validator: (value) {
                if (value != null && value.isNotEmpty) {
                  fullName = value;
                  return null;
                }
                fullName = "";
                return "Required: Enter your full name";
              },
            ),
            SizedBox(height: height * 0.05),
            TextFormField(
              decoration: const InputDecoration(
                labelText: "Enter your age",
              ),
              validator: (value) {
                if (value != null && value.isNotEmpty && _isInteger(value) && (int.parse(value) >= 1)) {
                  age = int.parse(value);
                  return null;
                }
                age = -1;
                return "Required: Enter your age";
              },
            ),
            SizedBox(height: height * 0.05),
            jobTitleDropDownList(),
            ElevatedButton(
              onPressed: () async {
                if (formKey.currentState!.validate()) {
                  formKey.currentState!.save();
                  // add user here w/ async method

                  if (!(fullName == null || fullName.isEmpty)
                  && !(email == null || email.isEmpty)
                  && !(age == null && age <= 0)
                  && !(jobTitle == null || jobTitle.isEmpty)) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const HomePage()),
                    );
                  }
                }
              },
              child: Text("Submit"),
            ),
          ],
        ),
      ),
    );
  }

  DropDownFormField jobTitleDropDownList() {
    return DropDownFormField(
      titleText: 'Job Title',
      hintText: 'Choose your job title',
      value: jobTitle,
      onSaved: (value) {
        setState(() {
          jobTitle = value;
        });
      },
      onChanged: (value) {
        setState(() {
          jobTitle = value;
        });
      },
      dataSource: const [
        {
          "display": "Full Stack Software Developer",
          "value": "Full Stack Software Developer",
        },
        {
          "display": "Backend Software Developer",
          "value": "Backend Software Developer",
        },
        {
          "display": "Frontend Software Developer",
          "value": "Frontend Software Developer",
        },
        {
          "display": "Web Developer",
          "value": "Web Developer",
        },
        {
          "display": "Data Scientist",
          "value": "Data Scientist",
        },
        {
          "display": "Mobile Developer",
          "value": "Mobile Developer",
        },
        {
          "display": "DevOps Developer",
          "value": "DevOps Developer",
        },
      ],
      textField: 'display',
      valueField: 'value',
      validator: (value) {
        if (value != null && value.isNotEmpty) {
          jobTitle = value;
          return null;
        }
        jobTitle = "";
        return "Required: Choose a job title";
      },
    );
  }

  bool _isValidEmail(String email) {
    return RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
  }

  bool _isInteger(value) {
    try {
      double.parse(value);
    } on FormatException {
      return false;
    }
    return true;
  }
}
