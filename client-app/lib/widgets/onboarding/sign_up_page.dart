import 'package:dropdown_formfield/dropdown_formfield.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final PageController controller;

  _SignUpPageState? state;

  SignUpPage({Key? key, required this.controller, required this.formKey}) : super(key: key);

  @override
  _SignUpPageState createState() {
    _SignUpPageState state = _SignUpPageState(controller: controller, formKey: formKey);
    this.state = state;

    return state;
  }

  _SignUpPageState? getState() {
    return state;
  }

  GlobalKey<FormState> getKey() {
    return formKey;
  }
}

class _SignUpPageState extends State<SignUpPage> {
  final PageController controller;
  final GlobalKey<FormState> formKey;

  late String? email;
  late String? fullName;
  late int? age;
  late String? jobTitle;
  String? password;
  String? confirmedPassword;

  _SignUpPageState({required this.controller, required this.formKey});

  @override
  void initState() {
    super.initState();
    jobTitle = null;
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;

    return Container(
      padding: EdgeInsets.only(left: height * (40/height), right: height * (40/height)),
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
            emailAddressTextFormField(),
            SizedBox(height: height * 0.05),
            passwordTextFormField(),
            SizedBox(height: height * 0.05),
            confirmPasswordTextFormField(),
            SizedBox(height: height * 0.05),
            fullNameTextFormField(),
            SizedBox(height: height * 0.05),
            ageTextFormField(),
            SizedBox(height: height * 0.05),
            jobTitleDropDownList(),
          ],
        ),
      ),
    );
  }

  TextFormField passwordTextFormField() {
    return TextFormField(
      decoration: const InputDecoration(
        labelText: "Enter your password",
      ),
      obscureText: true,
      enableSuggestions: false,
      autocorrect: false,
      validator: (value) {
        if (value != null && value.isNotEmpty) {
            password = value;
            return null;
        }
        password = null;
        return "Required: enter a password";
      },
    );
  }

  TextFormField confirmPasswordTextFormField() {
    return TextFormField(
      decoration: const InputDecoration(
        labelText: "Confirm your password",
      ),
      obscureText: true,
      enableSuggestions: false,
      autocorrect: false,
      validator: (value) {
        if (value != null && value.isNotEmpty) {
            confirmedPassword = value;
            return null;
        }
        confirmedPassword = null;
        return "Required: the passwords do not match";
      },
    );
  }

  TextFormField emailAddressTextFormField() {
    return TextFormField(
            decoration: const InputDecoration(
              labelText: "Enter your email address",
            ),
            validator: (value) {
              if (value != null && value.isNotEmpty && _isValidEmail(value)) {
                email = value;
                return null;
              }
              email = null;
              return "Required: Enter a valid email address";
            },
          );
  }

  TextFormField fullNameTextFormField() {
    return TextFormField(
      decoration: const InputDecoration(
        labelText: "Enter your full name",
      ),
      validator: (value) {
        if (value != null && value.isNotEmpty) {
          fullName = value;
          return null;
        }
        fullName = null;
        return "Required: Enter your full name";
      },
    );
  }

  TextFormField ageTextFormField() {
    return TextFormField(
      decoration: const InputDecoration(
        labelText: "Enter your age",
      ),
      validator: (value) {
        if (value != null && value.isNotEmpty && _isInteger(value) && (int.parse(value) >= 1)) {
          age = int.parse(value);
          return null;
        }
        age = null;
        return "Required: Enter your age";
      },
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
        jobTitle = null;
        return "Required: Choose a job title";
      },
    );
  }

  String? getFullName() {
    return fullName;
  }

  String? getEmailAddress() {
    return email;
  }

  int? getAge() {
    return age;
  }

  String? getJobTitle() {
    return jobTitle;
  }

  String? getPassword() {
    return password;
  }

  String? getConfirmedPassword() {
    return confirmedPassword;
  }

  bool passwordIsValid() {
    bool passwordIsAdded = !(password == null || password!.isEmpty);
    bool confirmedPasswordIsAdded = !(confirmedPassword == null || confirmedPassword!.isEmpty);
    return passwordIsAdded && confirmedPasswordIsAdded && password == confirmedPassword;
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