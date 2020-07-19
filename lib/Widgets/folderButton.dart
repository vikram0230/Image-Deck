import 'dart:io';

import 'package:flutter/material.dart';

// ignore: must_be_immutable
class FolderButton extends StatelessWidget {
  FolderButton({this.folderName, this.pageController, this.images, this.editCallback});
  final String folderName;
  final PageController pageController;
  final List<Map<String, dynamic>> images;
  final Function editCallback;
  File imageFile;
  File tempFile;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: FlatButton(
        onPressed: (){
//          print(images[pageController.page.round()]['file'].path);
          imageFile = images[pageController.page.round()]['file'];
          String imageName = imageFile.path.substring(imageFile.path.lastIndexOf('/')+1);
          tempFile = File('/storage/emulated/0/Image Deck/$folderName/$imageName');
          imageFile.copy(tempFile.path);
          imageFile.deleteSync();
          editCallback();
          print(tempFile.path);
        },
        padding: EdgeInsets.fromLTRB(0, 0, 5, 0),
        child: Column(
          children: <Widget>[
            Icon(
              Icons.folder,
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
