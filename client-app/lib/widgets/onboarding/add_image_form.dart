import 'dart:convert';
import 'dart:html' as html;

import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class AddImageForm extends StatefulWidget {
  _AddImageFormState? _state = null;

  AddImageForm({Key? key}) : super(key: key);

  @override
  _AddImageFormState createState() {
    _AddImageFormState state = _AddImageFormState();
    this._state = state;

    return state;
  }

  _AddImageFormState? getState() {
    return _state;
  }
}

class _AddImageFormState extends State<AddImageForm> {
  bool _imageAdded = false;
  String? _imageFilePath = null;

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;

    return Container(
      padding: EdgeInsets.only(left: height * (40/height), right: height * (40/height)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: height * 0.04),
          const Text(
            "ADD A PROFILE PICTURE",
            style: TextStyle(fontSize: 30, color: Colors.deepPurple),
          ),
          SizedBox(height: height * 0.05),
          _addImageIconButton(),
        ],
      ),
    );
  }

  Padding _addImageIconButton() {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;

    return Padding(
      padding: EdgeInsets.only(left: height * (10/height), right: height * (10/height)),
      child: Container(
        height: width * (150/width),
        width: width * (100/width),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: const Border(
            bottom: BorderSide(
              color: Colors.deepPurpleAccent,
              width: 1,
            ),
            top: BorderSide(
              color: Colors.deepPurpleAccent,
              width: 1,
            ),
            left: BorderSide(
              color: Colors.deepPurpleAccent,
              width: 1,
            ),
            right: BorderSide(
              color: Colors.deepPurpleAccent,
              width: 1,
            ),
          ),
        ),
        child: Align(
          alignment: Alignment.bottomRight,
          child: IconButton(
            onPressed: () async {
              ImagePicker _picker = ImagePicker();
              final XFile? image = await _picker.pickImage(
                source: ImageSource.gallery,
              );

              if (image == null) {
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("No image was selected.")));
              } else {
                _imageAdded = true;
                _imageFilePath = await _saveFile(await image.readAsBytes(), 'user/${const Uuid().v4()}');
              }
            },
            icon: const Icon(
              Icons.add,
              color: Colors.deepPurpleAccent,
            ),
          ),
        ),
      ),
    );
  }

  bool isImageAdded() {
    return _imageAdded;
  }

  String? getImageFilePath() {
    return _imageFilePath;
  }

  Future<String> _saveFile(Uint8List input, String fileName) async {
    final blob = html.Blob([input]);
    final url = html.Url.createObjectUrlFromBlob(blob);
    final anchor = html.document.createElement('a') as html.AnchorElement
      ..href = url
      ..style.display = 'none'
      ..download = '${fileName}.png';
    html.document.body!.children.add(anchor);
    anchor.click();

    html.document.body!.children.remove(anchor);
    html.Url.revokeObjectUrl(url);

    return fileName;

    // final myImagePath = '/home/carah/Documents/projects/JobMatcha/JobMatcha/client-app/assets' + "/${fileName}.png";
    //
    // File imageFile = File(myImagePath);
    // if(! await imageFile.exists()){
    //   imageFile.create(recursive: true);
    // }
    //
    // imageFile.writeAsBytes(input);
    // return '/home/carah/Documents/projects/JobMatcha/JobMatcha/client-app/assets' + "/${fileName}.png";
  }
}
