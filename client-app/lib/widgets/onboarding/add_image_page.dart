import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddImagePage extends StatefulWidget {
  _AddImagePageState? state = null;

  AddImagePage({Key? key}) : super(key: key);

  @override
  _AddImagePageState createState() {
    _AddImagePageState state = _AddImagePageState();
    this.state = state;

    return state;
  }

  _AddImagePageState? getState() {
    return state;
  }
}

class _AddImagePageState extends State<AddImagePage> {
  bool _imageAdded = false;

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
          addImageIconButton(),
        ],
      ),
    );
  }

  Padding addImageIconButton() {
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
                // TODO: connect to DB and save image
                _imageAdded = true;
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
}
