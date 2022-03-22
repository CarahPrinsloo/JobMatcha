import 'package:client_app/models/education.dart';
import 'package:dropdown_formfield/dropdown_formfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'education_form.dart';

class EducationTextFormFields extends StatefulWidget {
  final EducationFormState _formState;

  const EducationTextFormFields(this._formState);

  @override
  _EducationTextFormFieldsState createState() => _EducationTextFormFieldsState(_formState);
}

class _EducationTextFormFieldsState extends State<EducationTextFormFields> {
  final EducationFormState _formState;
  
  late TextEditingController _textController;
  late String? _graduationYear;
  
  _EducationTextFormFieldsState(this._formState);

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController();

    _graduationYear = null;
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _graduationYearDropDownFormField(),
        const SizedBox(
          height: 10,
        ),
        _educationTextFormField(),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }

  DropDownFormField _graduationYearDropDownFormField() {
    return DropDownFormField(
      titleText: "Graduated",
      hintText: 'Choose a year',
      value: _graduationYear,
      onSaved: (value) {
        setState(() {
          _graduationYear = value;
        });
      },
      onChanged: (value) {
        setState(() {
          _graduationYear = value;
        });
      },
      dataSource: _yearList(),
      textField: 'display',
      valueField: 'value',
      validator: (value) {
        if (value != null && value.isNotEmpty) {
          _graduationYear = value;
          return null;
        }
        _graduationYear = null;
        return "Required: Choose a year";
      },
    );
  }

  TextFormField _educationTextFormField() {
    return TextFormField(
      controller: _textController,
      decoration: const InputDecoration(
        labelText: "Enter the institution name",
      ),
      onChanged: (value) {
        if (_isYearSelected()) {
          _formState.getEducation()[0] =
              Education(graduationYear: _graduationYear!, institution: value);
        }
      },
      validator: (value) {
        if (value!.trim().isEmpty) return 'Required: Enter an institution';
        return null;
      },
    );
  }

  bool _isYearSelected() {
    return _graduationYear != null;
  }

  List<dynamic> _yearList() {
    return const [
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
    ];
  }
}
