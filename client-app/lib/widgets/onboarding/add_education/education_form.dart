import 'package:client_app/models/education.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'education_text_form_fields.dart';

class EducationForm extends StatefulWidget  {
  final EducationFormState _state = EducationFormState();

  EducationForm({Key? key}) : super(key: key);

  @override
  EducationFormState createState() => _state;

  EducationFormState? getState() {
    return _state;
  }
}

class EducationFormState extends State<EducationForm> {
  final List<Education?> _education = [null];
  late TextEditingController _textController;

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController();
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            const Text(
              'Add Education',
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
            ),
            ..._dynamicEducationFormFields(),
            const SizedBox(
              height: 40,
            ),
          ],
        ),
      ),
    );
  }

  List<Education?> getEducation() {
    return _education;
  }

  List<Education> getCopyOfProvidedEducation() {
    return List.from(
        _education.where((education) => education != null));
  }

  List<Widget> _dynamicEducationFormFields() {
    List<Widget> educationTextFieldsList = [];
    for (int i = 0; i < _education.length; i++) {
      educationTextFieldsList.add(Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: Row(
          children: [
            Expanded(child: EducationTextFormFields(this)),
            const SizedBox(
              width: 16,
            ),
            _addRemoveButton(i == _education.length - 1, i),
          ],
        ),
      ));
    }
    return educationTextFieldsList;
  }

  Widget _addRemoveButton(bool add, int index) {
    return InkWell(
      onTap: () {
        if (add) {
          // add new drop down list at the top of all drop down lists
          _education.insert(0, null);
        } else {
          _education.removeAt(index);
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
