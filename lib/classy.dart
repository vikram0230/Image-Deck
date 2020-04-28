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
  List<Widget> folders = [];

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      _image = image;
    });
  }

  void getFolders(){
    folders = [];
    final FolderNameArguments args = ModalRoute.of(context).settings.arguments;
    if(args.f1 != null){
      folders.add(FolderButton(
          folderName: args.f1,
        ),
      );
      if(args.f2 != null){
        folders.add(FolderButton(
          folderName: args.f2,
        ),
        );
        if(args.f3 != null){
          folders.add(FolderButton(
            folderName: args.f3,
          ),
          );
          if(args.f4 != null){
            folders.add(FolderButton(
              folderName: args.f4,
            ),
            );
            if(args.f5 != null){
              folders.add(FolderButton(
                folderName: args.f5,
              ),
              );
              if(args.f6 != null){
                folders.add(FolderButton(
                  folderName: args.f6,
                ),
                );
              }
            }
          }
        }
      }
    }
  }

  @override
  void initState() {
    super.initState();
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
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            physics: BouncingScrollPhysics(),
            itemCount: folders.length,
            itemBuilder: (BuildContext context, int index){
              return folders[index];
            }
        ),
      ),
    );
  }
}



//ListView.builder(
//itemCount: null,
//itemBuilder: null,
//),
