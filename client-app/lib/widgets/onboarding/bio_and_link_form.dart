import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BioAndLinkForm extends StatefulWidget {
  GlobalKey<FormState> formKey;
  late _BioAndLinkFormState _state;

  BioAndLinkForm({Key? key, required this.formKey}) : super(key: key);

  @override
  _BioAndLinkFormState createState() {
    _BioAndLinkFormState state = _BioAndLinkFormState(formKey);
    this._state = state;

    return state;
  }

  _BioAndLinkFormState getState() {
    return _state;
  }
}

class _BioAndLinkFormState extends State<BioAndLinkForm> {
  GlobalKey<FormState> _formKey;

  String? _bio = null;
  String? _linkToGithub = null;

  _BioAndLinkFormState(this._formKey);

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;

    return Container(
      padding: const EdgeInsets.only(left: 40, right: 40),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: height * 0.04),
            const Text(
              "ALMOST DONE, BUT FIRST",
              style: TextStyle(fontSize: 30, color: Colors.deepPurple),
            ),
            SizedBox(height: height * 0.05),
            TextFormField(
              decoration: const InputDecoration(
                labelText: "Add a summary paragraph about yourself",
              ),
              validator: (value) {
                if (value != null && value.isNotEmpty) {
                  _bio = value;
                  return null;
                }
                _bio = null;
                return "Required: Add a summary paragraph about yourself";
              },
            ),
            SizedBox(height: height * 0.05),
            TextFormField(
              decoration: const InputDecoration(
                labelText: "Add the link to your Github/Gitlab profile",
              ),
              validator: (value) {
                if (value != null && value.isNotEmpty) {
                  _linkToGithub = value;
                  return null;
                }
                _linkToGithub = null;
                return "Required: Add the link to your Github/Gitlab profile";
              },
            ),
            SizedBox(height: height * 0.05),
          ],
        ),
      ),
    );
  }

  String? getBio() {
    return _bio;
  }

  String? getGithubLink() {
    return _linkToGithub;
  }
  
  GlobalKey<FormState> getFormKey() {
    return _formKey;
  }
}
