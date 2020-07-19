import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:image_deck/Utilities/directoryOperations.dart';

import '../Utilities/constants.dart';
import '../Widgets/folderButton.dart';

class Classy extends StatefulWidget {
  static String id = 'classy';
  final bool isPreview = true;

  @override
  _ClassyState createState() => _ClassyState();
}

class _ClassyState extends State<Classy> {
  List<String> folderNames = [];
  List<Widget> folders = [];
  List<Map<String, dynamic>> images = [];
  String selectedDirectoryPath = '/storage/emulated/0/DCIM/Camera/';
  File imageFile;
  File tempFile;

  PageController _pageController = PageController();

  void getFolders() {
    folderNames = [];
    folders = [];
    final FolderNameArguments args = ModalRoute.of(context).settings.arguments;
    folderNames = args.folderNames;
    for (String i in folderNames) {
      folders.add(
        FolderButton(
          folderName: i,
          pageController: _pageController,
          images: images,
          editCallback: editCallback,
        ),
      );
    }
  }

  void getCamImages() {
    Directory(selectedDirectoryPath)
        .list(recursive: false, followLinks: false)
        .listen((FileSystemEntity entity) {
      FileStat fileStat = FileStat.statSync(entity.path);
      if (!images.contains(
              {'file': File(entity.path), 'date': fileStat.modified}) &&
          (entity.path.contains('jpg') ||
              entity.path.contains('jpeg') ||
              entity.path.contains('png'))) {
        print({'file': File(entity.path), 'date': fileStat.modified});
        images.add({'file': File(entity.path), 'date': fileStat.modified});
      }
      images.sort((a, b) => a['date'].compareTo(b['date']));
      images = images.reversed.toList();
      setState(() {});
    });
  }

  editCallback() {
    setState(() {
      _pageController.nextPage(
          duration: Duration(milliseconds: 100), curve: Curves.bounceOut);
      images.removeAt(_pageController.page.round());
    });
  }

  @override
  void initState() {
    super.initState();
    getCamImages();
  }

  @override
  Widget build(BuildContext context) {
    getFolders();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Image Deck",
          style: TextStyle(fontFamily: 'Berkshire'),
        ),
        backgroundColor: Colors.black,
        actions: <Widget>[
          IconButton(icon: Icon(Icons.delete), onPressed: (){
            imageFile = images[_pageController.page.round()]['file'];
            imageFile.deleteSync();
            editCallback();
          },),
        ],
      ),
      body: images.length == 0
          ? FlatButton(
              padding: EdgeInsets.all(0),
              splashColor: Colors.white,
              focusColor: Colors.white,
              onPressed: () async {
//                selectedDirectory = await DirectoryPicker.pick(context: context, rootDirectory: Directory('/Internal storage/DCIM/Camera'));

//                selectDirectory();
//                selectedDirectory = '/Internal storage/DCIM/Camera';
                selectedDirectoryPath = await DirectoryOperations.pickDirectory(
                        context, Directory('/storage/emulated/0/DCIM/Camera/'));
                // TODO: Dialog to choose btw gallery and storage
//                print(selectedDirectory);
                getCamImages();
              },
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
            )
          : PageView.builder(
              controller: _pageController,
              itemCount: images.length,
              itemBuilder: (context, index) {
//                print(images[index]['file'].path);
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.file(images[index]['file']),
                );
              },
            ),
      bottomNavigationBar: Container(
        height: 90,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: folders,
        ),
      ),
    );
  }
}
