import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';


class Classy extends StatefulWidget {
  static String id = 'classy';
  @override
  _ClassyState createState() => _ClassyState();
}

class _ClassyState extends State<Classy> {
  dynamic _image;
  List<Widget> folders = [];

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);

    setState(() {
      _image = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text("Image Deck",
            style: TextStyle(fontFamily: 'Berkshire'),),
        ),
      ),
      body: Center(
        child: _image == null
            ? Text('No image selected.')
            : Image.file(_image),
      ),
      bottomNavigationBar: Container(
        color: Colors.black45,
        height: 80,
        child: Row(
          children: folders,
        ),
      ),
    );
  }
}

