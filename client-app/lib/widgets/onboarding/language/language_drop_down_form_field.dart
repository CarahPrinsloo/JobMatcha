import 'package:dropdown_formfield/dropdown_formfield.dart';
import 'package:flutter/cupertino.dart';

import 'language_form.dart';

class LanguageDropDownFormField extends StatefulWidget {
  final int index;
  final LanguageFormState formState;

  LanguageDropDownFormField({required this.index, required this.formState});

  @override
  _LanguageDropDownFormFieldState createState() => _LanguageDropDownFormFieldState(formState);
}

class _LanguageDropDownFormFieldState extends State<LanguageDropDownFormField> {
  final LanguageFormState _formState;

  late TextEditingController _textController;
  late String? _language;

  _LanguageDropDownFormFieldState(this._formState);

  @override
  void initState() {
    super.initState();

    _textController = TextEditingController();
    _language = null;
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      _textController.text = _formState.getLanguages()[widget.index] ?? '';
    });

    return _languageDropDownFormField();
  }

  DropDownFormField _languageDropDownFormField() {
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
          _formState.getLanguages()[0] = value;
          _language = value;
        });
      },
      dataSource: _getLanguageList(),
      textField: 'display',
      valueField: 'value',
      validator: (value) {
        if (value != null && value.isNotEmpty) {
          _language = value;
          return null;
        }
        _language = null;
        return "Required: Choose a language from the list.";
      },
    );
  }

  List<dynamic> _getLanguageList() {
    return const [
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
    ];
  }
}