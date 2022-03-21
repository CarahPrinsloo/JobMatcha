import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'language_drop_down_list.dart';

class AddLanguagePage extends StatefulWidget {
  AddLanguagePageState? state;
  late GlobalKey<FormState> formKey;

  AddLanguagePage({Key? key, required this.formKey}) : super(key: key);

  @override
  AddLanguagePageState createState() {
    AddLanguagePageState state = AddLanguagePageState(formKey: formKey);
    this.state = state;
    return state;
  }

  AddLanguagePageState? getState() {
    return state;
  }
}

class AddLanguagePageState extends State<AddLanguagePage> {
  List<String?> languageList = [null];

  late GlobalKey<FormState> formKey;
  late TextEditingController _controller;

  bool _languageIsAdded = false;

  AddLanguagePageState({Key? key, required this.formKey});

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
      key: formKey,
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
            ..._getLanguages(),
            const SizedBox(
              height: 40,
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _getLanguages() {
    List<Widget> languagesTextFieldsList = [];
    for (int i = 0; i < languageList.length; i++) {
      languagesTextFieldsList.add(Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: Row(
          children: [
            Expanded(child: LanguagesDropDownList(index: i, addLanguageState: this)),
            const SizedBox(
              width: 16,
            ),
            _addRemoveButton(i == languageList.length - 1, i),
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
          // add new drop down list at the top of all drop down lists
          languageList.insert(0, null);
        } else {
          languageList.removeAt(index);
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

  bool isAdded(){
    return _languageIsAdded;
  }

  void setLanguageIsAdded(bool value) {
    _languageIsAdded = value;
  }
}
