import 'package:client_app/models/work_experience.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'work_experience_text_form_fields.dart';

class WorkExperienceForm extends StatefulWidget {
  final WorkExperienceFormState _formState = WorkExperienceFormState();

  WorkExperienceForm({Key? key}) : super(key: key);

  @override
  WorkExperienceFormState createState() => _formState;

  WorkExperienceFormState? getState() {
    return _formState;
  }
}

class WorkExperienceFormState extends State<WorkExperienceForm> {
  List<WorkExperience?> _workExperience = [null];
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
              'Add your work experience',
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
            ),
            ..._dynamicWorkExperienceFormFields(),
            const SizedBox(
              height: 40,
            ),
          ],
        ),
      ),
    );
  }

  List<WorkExperience?> getWorkExperience() {
    return _workExperience;
  }

  List<WorkExperience> getCopyOfCompletedWorkExperience() {
    return List.from(_workExperience.where((experience) => experience != null));
  }

  List<Widget> _dynamicWorkExperienceFormFields() {
    List<Widget> workExperienceTextFieldsList = [];
    for (int i = 0; i < _workExperience.length; i++) {
      workExperienceTextFieldsList.add(Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: Row(
          children: [
            Expanded(child: WorkExperienceFormFields(this)),
            const SizedBox(
              width: 16,
            ),
            _addRemoveButton(i == _workExperience.length - 1, i),
          ],
        ),
      ));
    }
    return workExperienceTextFieldsList;
  }

  Widget _addRemoveButton(bool add, int index) {
    return InkWell(
      onTap: () {
        if (add) {
          _workExperience.insert(0, null);
        } else {
          _workExperience.removeAt(index);
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
