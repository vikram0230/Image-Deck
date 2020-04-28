import 'package:flutter/material.dart';

class FolderButton extends StatelessWidget {
  FolderButton({this.folderName});
  String folderName;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: FlatButton(
        onPressed: (){},
        padding: EdgeInsets.fromLTRB(0, 0, 5, 0),
        child: Column(
          children: <Widget>[
            Icon(Icons.folder,
              size: 50,
              color: Colors.black,
            ),
            Text(folderName)
          ],
        ),
      ),
    );
  }
}