import 'package:client_app/models/work_experience.dart';
import 'package:dropdown_formfield/dropdown_formfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'add_work_experience_page.dart';

class WorkExperienceFormFields extends StatefulWidget {
  final int index;

  const WorkExperienceFormFields(this.index);

  @override
  _WorkExperienceFormFieldsState createState() => _WorkExperienceFormFieldsState();
}

class _WorkExperienceFormFieldsState extends State<WorkExperienceFormFields> {
  late TextEditingController _controller;
  late String? _startYear;
  late String? _endYear;

  bool _completedStartYearField = false;
  bool _completedEndYearField = false;

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
        yearDropDownList("Start year", true),
        const SizedBox(
          height: 10,
        ),
        yearDropDownList("End year", false),
        const SizedBox(
          height: 10,
        ),
        workExperienceTextFormField(),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }

  DropDownFormField yearDropDownList(String title, bool isStartYear) {
    return DropDownFormField(
      titleText: title,
      hintText: 'Choose a year',
      value: (isStartYear) ? _startYear : _endYear,
      onSaved: (value) {
        setState(() {
          if (isStartYear) {
            _startYear = value;
            _completedStartYearField = true;
          } else {
            _endYear = value;
            _completedEndYearField = true;
          }
        });
      },
      onChanged: (value) {
        setState(() {
          if (isStartYear) {
            _startYear = value;
            _completedStartYearField = true;
          } else {
            _endYear = value;
            _completedEndYearField = true;
          }
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
          if (isStartYear) {
            _startYear = value;
          } else {
            if ((_completedStartYearField && value != null) && !(_isDateBeforeOrEqual(_startYear!, _endYear!))) {
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("No image was selected.")));
            }
            _endYear = value;
          }

          return null;
        }
        _resetGlobals();
        return "Required: Choose a year";
      },
    );
  }

  TextFormField workExperienceTextFormField() {
    return TextFormField(
      controller: _controller,
      decoration: const InputDecoration(
        labelText: "Enter the name of the business",
      ),
      onChanged: (value) {
        if (_completedStartYearField && _completedEndYearField && _isDateBeforeOrEqual(_startYear!, _endYear!)) {
          AddWorkExperiencePageState.workExperienceList[0] =
              WorkExperience(startYear: _startYear!, endYear: _endYear!, businessName: value);
          for (int i = 0; i < AddWorkExperiencePageState.workExperienceList.length; i++) {
            print(AddWorkExperiencePageState.workExperienceList[i]!.businessName);
          }
        }
      },
      validator: (value) {
        if (value!.trim().isEmpty) return 'Required: Enter the business name';
        return null;
      },
    );
  }

  void _resetGlobals() {
    _startYear = null;
    _endYear = null;
    _completedEndYearField = false;
    _completedStartYearField = false;
  }

  bool _isDateBeforeOrEqual(String startYear, String endYear) {
    try {
      var df1 = DateFormat('dd-MM-yyyy').parse('01-01-${startYear}');
      var df2 = DateFormat('dd-MM-yyyy').parse('01-01-${endYear}');

      return df1.isBefore(df2) || df1.isAtSameMomentAs(df2);
    } catch (ignore) {}

    return false;
  }
}
