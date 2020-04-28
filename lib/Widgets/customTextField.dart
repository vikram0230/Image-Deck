import 'package:flutter/material.dart';


class CustomTextField extends StatelessWidget {
//  CustomTextField({});
  String folderName;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: TextField(
        onChanged: (value){
          folderName = value;
        },
        cursorColor: Colors.black,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.black,
            )
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              width: 2.0,
              color: Colors.black
            )
          ),
          labelText: 'Enter Folder Name',
          labelStyle: TextStyle(color: Colors.black54)
        ),
        textCapitalization: TextCapitalization.words,
      ),
    );
  }
}