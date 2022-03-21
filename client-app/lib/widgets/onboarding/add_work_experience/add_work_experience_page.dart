import 'package:client_app/models/work_experience.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'work_experience_form_fields.dart';

class AddWorkExperiencePage extends StatefulWidget {
  AddWorkExperiencePageState? state;

  AddWorkExperiencePage({Key? key}) : super(key: key);

  @override
  AddWorkExperiencePageState createState() {
    AddWorkExperiencePageState state = AddWorkExperiencePageState();
    this.state = state;
    return state;
  }

  AddWorkExperiencePageState? getState() {
    return state;
  }
}

class AddWorkExperiencePageState extends State<AddWorkExperiencePage> {
  static List<WorkExperience?> workExperienceList = [null];
  late TextEditingController _controller;

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
            ..._getWorkExperience(),
            const SizedBox(
              height: 40,
            ),
          ],
        ),
      ),
    );
  }

  List<WorkExperience> getWorkExperience() {
    return List.from(workExperienceList.where((experience) => experience != null));
  }

  List<Widget> _getWorkExperience() {
    List<Widget> workExperienceTextFieldsList = [];
    for (int i = 0; i < workExperienceList.length; i++) {
      workExperienceTextFieldsList.add(Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: Row(
          children: [
            Expanded(child: WorkExperienceFormFields(i)),
            const SizedBox(
              width: 16,
            ),
            _addRemoveButton(i == workExperienceList.length - 1, i),
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
          workExperienceList.insert(0, null);
        } else {
          workExperienceList.removeAt(index);
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
