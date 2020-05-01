import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:image_deck/Widgets/directoryOperations.dart';
import 'package:image_picker/image_picker.dart';
import 'package:directory_picker/directory_picker.dart';
import 'Widgets/folderButton.dart';
import 'constants.dart';

class Classy extends StatefulWidget {
  static String id = 'classy';
  @override
  _ClassyState createState() => _ClassyState();
}

class _ClassyState extends State<Classy> {
  dynamic _image;
  List<String> folderNames = [];
  List<Widget> folders = [];

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      _image = image;
    });
  }

  void getFolders(){
    folderNames = [];
    folders = [];
    final FolderNameArguments args = ModalRoute.of(context).settings.arguments;
    folderNames = args.folderNames;
    for(String i in folderNames){
      folders.add(
        FolderButton(
          folderName: i,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    getFolders();
    return Scaffold(
      appBar: AppBar(
        title: Text("Image Deck",
          style: TextStyle(fontFamily: 'Berkshire'),
        ),
        backgroundColor: Colors.black,
      ),
      body: FlatButton(
        onPressed: () async {
          print('button pressed');
//          Directory _appDocDir = await getExternalStorageDirectory();
          String selectedDirectory = DirectoryOperations.pickDirectory(context, Directory('/storage/emulated/0/')).toString();
          print(selectedDirectory);
        },
        child: Container(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Icon(
                    Icons.add_circle_outline,
                    size: 100,
                    color: Colors.black26,
                  ),
                ),
                Text(
                  'Tap to add Images',
                  style: TextStyle(
                    color: Colors.black38,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 90,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: folders,
        )
      ),
    );
  }
}

//ListView.builder(
//scrollDirection: Axis.horizontal,
//physics: BouncingScrollPhysics(),
//itemCount: folders.length,
//itemBuilder: (BuildContext context, int index){
//return folders[index];
//}
//),


//Center(
//child: _image == null
//? Text('No image selected.')
//: Image.file(_image),
//),

