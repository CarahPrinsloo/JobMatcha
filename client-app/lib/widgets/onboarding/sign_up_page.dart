import 'package:dropdown_formfield/dropdown_formfield.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final PageController controller;
  late final _SignUpPageState state;

  SignUpPage({Key? key, required this.controller, required this.formKey}) : super(key: key);

  @override
  _SignUpPageState createState() {
    _SignUpPageState state = _SignUpPageState(controller: controller, formKey: formKey);
    this.state = state;

    return state;
  }

  String getFullName() {
    return state.getFullName();
  }

  String getEmailAddress() {
    return state.getEmailAddress();
  }

  int getAge() {
    return state.getAge();
  }

  String getJobTitle() {
    return state.getJobTitle();
  }
}

class _SignUpPageState extends State<SignUpPage> {
  final PageController controller;
  final GlobalKey<FormState> formKey;

  late String email;
  late String fullName;
  late int age;
  late String jobTitle;

  _SignUpPageState({required this.controller, required this.formKey});

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

  String getFullName() {
    return fullName;
  }

  String getEmailAddress() {
    return email;
  }

  int getAge() {
    return age;
  }

  String getJobTitle() {
    return jobTitle;
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