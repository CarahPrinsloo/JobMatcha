import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'language_drop_down_form_field.dart';

class LanguageForm extends StatefulWidget {
  LanguageFormState? state;
  late GlobalKey<FormState> formKey;

  LanguageForm({Key? key, required this.formKey}) : super(key: key);

  @override
  LanguageFormState createState() {
    LanguageFormState state = LanguageFormState(formKey);
    this.state = state;

    return state;
  }

  LanguageFormState? getState() {
    return state;
  }
}

class LanguageFormState extends State<LanguageForm> {
  List<String?> _languages = [null];

  late GlobalKey<FormState> _formKey;
  late TextEditingController _controller;

  LanguageFormState(this._formKey);

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            const Text(
              'Add Languages',
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
            ),
            ..._dynamicLanguageDropDownFields(),
            const SizedBox(
              height: 40,
            ),
          ],
        ),
      ),
    );
  }

  bool isAdded() {
    return List.from(_languages.where((language) => language != null))
        .isNotEmpty;
  }

  List<String?> getLanguages() {
    return _languages;
  }

  List<Widget> _dynamicLanguageDropDownFields() {
    List<Widget> languagesTextFieldsList = [];
    for (int i = 0; i < _languages.length; i++) {
      languagesTextFieldsList.add(Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: Row(
          children: [
            Expanded(
                child: LanguageDropDownFormField(index: i, formState: this)),
            const SizedBox(
              width: 16,
            ),
            _addRemoveButton(i == _languages.length - 1, i),
          ],
        ),
      ));
    }
    return languagesTextFieldsList;
  }

  Widget _addRemoveButton(bool add, int index) {
    return InkWell(
      onTap: () {
        if (add) {
          _languages.insert(0, null);
        } else {
          _languages.removeAt(index);
        }
        setState(() {});
      },
      child: Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          color: (add) ? Colors.green : Colors.red,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Icon(
          (add) ? Icons.add : Icons.remove,
          color: Colors.white,
        ),
      ),
    );
  }
}
