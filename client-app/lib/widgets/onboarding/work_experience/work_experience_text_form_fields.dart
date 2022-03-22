import 'package:client_app/models/work_experience.dart';
import 'package:dropdown_formfield/dropdown_formfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'work_experience_form.dart';

class WorkExperienceFormFields extends StatefulWidget {
  WorkExperienceFormState _formState;

  WorkExperienceFormFields(this._formState);

  @override
  _WorkExperienceFormFieldsState createState() =>
      _WorkExperienceFormFieldsState(_formState);
}

class _WorkExperienceFormFieldsState extends State<WorkExperienceFormFields> {
  WorkExperienceFormState _formState;

  late TextEditingController _textController;
  late String? _startYear;
  late String? _endYear;

  _WorkExperienceFormFieldsState(this._formState);

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController();

    _startYear = null;
    _endYear = null;
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
        _yearDropDownList("Start year", true),
        const SizedBox(
          height: 10,
        ),
        _yearDropDownList("End year", false),
        const SizedBox(
          height: 10,
        ),
        _dynamicWorkExperienceTextFormField(),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }

  DropDownFormField _yearDropDownList(String title, bool isStartYear) {
    return DropDownFormField(
      titleText: title,
      hintText: 'Choose a year',
      value: (isStartYear) ? _startYear : _endYear,
      onSaved: (value) {
        setState(() {
          _updateYear(isStartYear, value);
        });
      },
      onChanged: (value) {
        setState(() {
          _updateYear(isStartYear, value);
        });
      },
      dataSource: _yearOptions(),
      textField: 'display',
      valueField: 'value',
      validator: (value) {
        bool isValidInput = value != null && value.isNotEmpty;

        if (isStartYear) {
          if (isValidInput) {
            _startYear = value;
            return null;
          }
          _startYear = null;
        } else {
          if (isValidInput) {
            _endYear = value;
            return null;
          }
          _endYear = null;
        }
        return "Required: Choose a year";
      },
    );
  }

  TextFormField _dynamicWorkExperienceTextFormField() {
    return TextFormField(
      controller: _textController,
      decoration: const InputDecoration(
        labelText: "Enter the name of the business",
      ),
      onChanged: (value) {
        bool _validWorkExperience = _startYear != null &&
            _endYear != null &&
            _isDateBeforeOrEqual(_startYear!, _endYear!);

        if (_validWorkExperience) {
          _formState.getWorkExperience()[0] = WorkExperience(
              startYear: _startYear!, endYear: _endYear!, businessName: value);
        }
      },
      validator: (value) {
        if (value!.trim().isEmpty) return 'Required: Enter the business name';
        return null;
      },
    );
  }

  void _updateYear(bool isStartYear, value) {
    if (isStartYear) {
      _startYear = value;
    } else {
      _endYear = value;
    }
  }

  bool _isDateBeforeOrEqual(String startYear, String endYear) {
    try {
      var df1 = DateFormat('dd-MM-yyyy').parse('01-01-${startYear}');
      var df2 = DateFormat('dd-MM-yyyy').parse('01-01-${endYear}');

      return df1.isBefore(df2) || df1.isAtSameMomentAs(df2);
    } catch (ignore) {}

    return false;
  }

  List<dynamic> _yearOptions() {
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
