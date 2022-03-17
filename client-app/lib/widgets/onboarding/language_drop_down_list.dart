import 'package:dropdown_formfield/dropdown_formfield.dart';
import 'package:flutter/cupertino.dart';

import 'add_bio_page.dart';

class LanguagesDropDownList extends StatefulWidget {
  final int index;

  const LanguagesDropDownList(this.index);

  @override
  _LanguagesDropDownListState createState() => _LanguagesDropDownListState();
}

class _LanguagesDropDownListState extends State<LanguagesDropDownList> {
  late TextEditingController _controller;
  late String _language;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _language = "";
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      _controller.text = AddLanguagePageState.languageList[widget.index] ?? '';
    });

    return languageDropDownList();
  }

  DropDownFormField languageDropDownList() {
    return DropDownFormField(
      titleText: 'Languages',
      hintText: 'Choose a language',
      value: _language,
      onSaved: (value) {
        setState(() {
          _language = value;
        });
      },
      onChanged: (value) {
        setState(() {
          AddLanguagePageState.languageList[0] = value;
          _language = value;
        });
      },
      dataSource: const [
        {
          "display": "English",
          "value": "English",
        },
        {
          "display": "Afrikaans",
          "value": "Afrikaans",
        },
        {
          "display": "Xhosa",
          "value": "Xhosa",
        },
        {
          "display": "Zulu",
          "value": "Zulu",
        },
        {
          "display": "Southern Sotho",
          "value": "Southern Sotho",
        },
        {
          "display": "Venda",
          "value": "Venda",
        },
        {
          "display": "Tswana",
          "value": "Tswana",
        },
        {
          "display": "Northern Sotho",
          "value": "Northern Sotho",
        },
        {
          "display": "Tsonga",
          "value": "Tsonga",
        },
        {
          "display": "Swati",
          "value": "Swati",
        },
        {
          "display": "Ndebele",
          "value": "Ndebele",
        },
      ],
      textField: 'display',
      valueField: 'value',
      validator: (value) {
        if (value != null && value.isNotEmpty) {
          _language = value;
          return null;
        }
        _language = "";
        return "Required: Choose a job title";
      },
    );
  }
}