import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomTextField extends StatelessWidget {
  String folderName;
  var textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    textController.clear();
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: TextField(
        controller: textController,
        onChanged: (value) {
          folderName = value;
        },
        cursorColor: Colors.black,
        decoration: InputDecoration(
            border: OutlineInputBorder(
                borderSide: BorderSide(
              color: Colors.black,
            )),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 2.0, color: Colors.black)),
            labelText: 'Folder Name',
            labelStyle: TextStyle(color: Colors.black54)),
        textCapitalization: TextCapitalization.words,
      ),
    );
  }
}
