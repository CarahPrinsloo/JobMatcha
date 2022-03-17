import 'package:client_app/models/education.dart';
import 'package:dropdown_formfield/dropdown_formfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'add_education_page.dart';

class EducationFormFields extends StatefulWidget {
  final int index;

  const EducationFormFields(this.index);

  @override
  _EducationFormFieldsState createState() => _EducationFormFieldsState();
}

class _EducationFormFieldsState extends State<EducationFormFields> {
  late TextEditingController _controller;

  late String? _graduationYear;

  bool _completedGraduationYearField = true;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();

    _resetGlobals();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {});

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        yearDropDownList(),
        const SizedBox(
          height: 10,
        ),
        educationTextFormField(),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }

  DropDownFormField yearDropDownList() {
    return DropDownFormField(
      titleText: "Graduated",
      hintText: 'Choose a year',
      value: _graduationYear,
      onSaved: (value) {
        setState(() {
          _graduationYear = value;
          _completedGraduationYearField = true;
        });
      },
      onChanged: (value) {
        setState(() {
          _graduationYear = value;
          _completedGraduationYearField = true;
        });
      },
      dataSource: const [
        {
          "display": "2022",
          "value": "2022",
        },
        {
          "display": "2021",
          "value": "2021",
        },
        {
          "display": "2020",
          "value": "2020",
        },
        {
          "display": "2019",
          "value": "2019",
        },
        {
          "display": "2018",
          "value": "2018",
        },
        {
          "display": "2017",
          "value": "2017",
        },
        {
          "display": "2016",
          "value": "2016",
        },
        {
          "display": "2015",
          "value": "2015",
        },
        {
          "display": "2014",
          "value": "2014",
        },
        {
          "display": "2013",
          "value": "2013",
        },
        {
          "display": "2012",
          "value": "2012",
        },
      ],
      textField: 'display',
      valueField: 'value',
      validator: (value) {
        if (value != null && value.isNotEmpty) {
          _graduationYear = value;
          return null;
        }
        _resetGlobals();
        return "Required: Choose a year";
      },
    );
  }

  TextFormField educationTextFormField() {
    return TextFormField(
      controller: _controller,
      decoration: const InputDecoration(
        labelText: "Enter the institution name",
      ),
      onChanged: (value) {
        if (_completedGraduationYearField) {
          AddEducationPageState.educationList[0] =
              Education(graduationYear: _graduationYear!, institution: value);
        }
      },
      validator: (value) {
        if (value!.trim().isEmpty) return 'Required: Enter an institution';
        return null;
      },
    );
  }

  void _resetGlobals() {
    _graduationYear = null;
    _completedGraduationYearField = false;
  }
}
