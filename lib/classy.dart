import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:image_picker/image_picker.dart';
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
      body: Center(
        child: _image == null
            ? Text('No image selected.')
            : Image.file(_image),
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

