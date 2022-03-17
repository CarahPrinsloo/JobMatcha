import 'package:client_app/models/education.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'education_form_fields.dart';

class AddEducationPage extends StatefulWidget {
  const AddEducationPage({Key? key}) : super(key: key);

  @override
  AddEducationPageState createState() => AddEducationPageState();
}

class AddEducationPageState extends State<AddEducationPage> {
  static List<Education?> educationList = [null];

  final _formKey = GlobalKey<FormState>();
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
              'Add Education',
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
            ),
            ..._getEducation(),
            const SizedBox(
              height: 40,
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _getEducation() {
    List<Widget> educationTextFieldsList = [];
    for (int i = 0; i < educationList.length; i++) {
      educationTextFieldsList.add(Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: Row(
          children: [
            Expanded(child: EducationFormFields(i)),
            const SizedBox(
              width: 16,
            ),
            _addRemoveButton(i == educationList.length - 1, i),
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
          educationList.insert(0, null);
        } else {
          educationList.removeAt(index);
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
