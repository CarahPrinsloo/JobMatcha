import 'package:dropdown_formfield/dropdown_formfield.dart';
import 'package:flutter/material.dart';

class GeneralInformationForm extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final PageController controller;

  GeneralInformationFormState? _state;

  GeneralInformationForm({Key? key, required this.controller, required this.formKey}) : super(key: key);

  @override
  GeneralInformationFormState createState() {
    GeneralInformationFormState state = GeneralInformationFormState(formKey);
    this._state = state;

    return state;
  }

  GeneralInformationFormState? getState() {
    return _state;
  }

  GlobalKey<FormState> getKey() {
    return formKey;
  }
}

class GeneralInformationFormState extends State<GeneralInformationForm> {
  final GlobalKey<FormState> _formKey;

  String? _email;
  String? _fullName;
  int? _age;
  String? _jobTitle;
  String? _password;
  String? _confirmedPassword;

  GeneralInformationFormState(this._formKey);

  @override
  void initState() {
    super.initState();
    _jobTitle = null;
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;

    return Container(
      padding: EdgeInsets.only(left: height * (40/height), right: height * (40/height)),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: height * 0.04),
            const Text(
              "WELCOME",
              style: TextStyle(fontSize: 30, color: Colors.deepPurple),
            ),
            SizedBox(height: height * 0.05),
            _emailAddressTextFormField(),
            SizedBox(height: height * 0.05),
            _passwordTextFormField(),
            SizedBox(height: height * 0.05),
            _confirmPasswordTextFormField(),
            SizedBox(height: height * 0.05),
            _fullNameTextFormField(),
            SizedBox(height: height * 0.05),
            _ageTextFormField(),
            SizedBox(height: height * 0.05),
            _jobTitleDropDownFormField(),
          ],
        ),
      ),
    );
  }

  TextFormField _emailAddressTextFormField() {
    return TextFormField(
      decoration: const InputDecoration(
        labelText: "Enter your email address",
      ),
      validator: (value) {
        if (value != null && value.isNotEmpty && _isValidEmail(value)) {
          _email = value;
          return null;
        }
        _email = null;
        return "Required: Enter a valid email address";
      },
    );
  }

  TextFormField _passwordTextFormField() {
    return TextFormField(
      decoration: const InputDecoration(
        labelText: "Enter your password",
      ),
      obscureText: true,
      enableSuggestions: false,
      autocorrect: false,
      validator: (value) {
        if (value != null && value.isNotEmpty) {
            _password = value;
            return null;
        }
        _password = null;
        return "Required: enter a password";
      },
    );
  }

  TextFormField _confirmPasswordTextFormField() {
    return TextFormField(
      decoration: const InputDecoration(
        labelText: "Confirm your password",
      ),
      obscureText: true,
      enableSuggestions: false,
      autocorrect: false,
      validator: (value) {
        if (value != null && value.isNotEmpty) {
            _confirmedPassword = value;
            return null;
        }
        _confirmedPassword = null;
        return "Required: the passwords do not match";
      },
    );
  }

  TextFormField _ageTextFormField() {
    return TextFormField(
      decoration: const InputDecoration(
        labelText: "Enter your age",
      ),
      validator: (value) {
        if (value != null && value.isNotEmpty && _isInteger(value) && (int.parse(value) >= 1)) {
          _age = int.parse(value);
          return null;
        }
        _age = null;
        return "Required: Enter your age";
      },
    );
  }

  TextFormField _fullNameTextFormField() {
    return TextFormField(
      decoration: const InputDecoration(
        labelText: "Enter your full name",
      ),
      validator: (value) {
        if (value != null && value.isNotEmpty) {
          _fullName = value;
          return null;
        }
        _fullName = null;
        return "Required: Enter your full name";
      },
    );
  }

  DropDownFormField _jobTitleDropDownFormField() {
    return DropDownFormField(
      titleText: 'Job Title',
      hintText: 'Choose your job title',
      value: _jobTitle,
      onSaved: (value) {
        setState(() {
          _jobTitle = value;
        });
      },
      onChanged: (value) {
        setState(() {
          _jobTitle = value;
        });
      },
      dataSource: _jobTitleOptions(),
      textField: 'display',
      valueField: 'value',
      validator: (value) {
        if (value != null && value.isNotEmpty) {
          _jobTitle = value;
          return null;
        }
        _jobTitle = null;
        return "Required: Choose a job title";
      },
    );
  }

  bool isPasswordValid() {
    bool passwordIsAdded = !(_password == null || _password!.isEmpty);
    bool confirmedPasswordIsAdded = !(_confirmedPassword == null || _confirmedPassword!.isEmpty);
    return passwordIsAdded && confirmedPasswordIsAdded && _password == _confirmedPassword;
  }

  String? getFullName() {
    return _fullName;
  }

  String? getEmailAddress() {
    return _email;
  }

  int? getAge() {
    return _age;
  }

  String? getJobTitle() {
    return _jobTitle;
  }

  String? getPassword() {
    return _password;
  }

  String? getConfirmedPassword() {
    return _confirmedPassword;
  }

  List<dynamic> _jobTitleOptions() {
    return const [
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
    ];
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