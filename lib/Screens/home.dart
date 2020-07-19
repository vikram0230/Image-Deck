import 'package:flutter/material.dart';

import '../Utilities/constants.dart';
import '../Utilities/directoryOperations.dart';
import '../Widgets/customTextField.dart';
import 'classy.dart';

class Home extends StatefulWidget {
  static String id = '/';

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<CustomTextField> homeWidgets = [CustomTextField()];
  String dropdownValue = '1';
  List<String> folderNames = [];

  void getTextFields(folderCount) {
    homeWidgets = [CustomTextField()];
    for (int i = 1; i < folderCount; i++) {
      homeWidgets.add(CustomTextField());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            "Image Deck",
            style: TextStyle(fontFamily: 'Berkshire', color: Colors.white),
          ),
        ),
        backgroundColor: Colors.black,
      ),
      body: Column(
        children: <Widget>[
          Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text(
                    'Folder Count :',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                    ),
                  ),
                  DropdownButton<String>(
                    value: dropdownValue,
                    icon: Icon(Icons.arrow_drop_down),
                    iconSize: 30,
                    elevation: 16,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                    ),
                    onChanged: (String newValue) {
                      setState(() {
                        dropdownValue = newValue;
                        getTextFields(int.parse(dropdownValue));
                      });
                    },
                    items: <String>['1', '2', '3', '4', '5', '6', '7', '8', '9', '10']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: TextStyle(fontSize: 25),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: homeWidgets.length,
                itemBuilder: (BuildContext context, int index) {
                  return homeWidgets[index];
                }),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(vertical: 50.0, horizontal: 100.0),
        child: FlatButton(
          padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
          onPressed: () async {
            folderNames = [];
            for (CustomTextField i in homeWidgets) {
              folderNames.add(i.folderName);
            }
            print(folderNames);
            // TODO: Show error message if null

            // File System
            DirectoryOperations.createAppDirectory();

            for (String i in folderNames) {
              DirectoryOperations.createDirectory(i);
            }

            Navigator.pushNamed(
              context,
              Classy.id,
              arguments: FolderNameArguments(
                folderNames: folderNames,
              ),
            );
          },
          color: Colors.black,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
          child: Text(
            'Get Started',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
          ),
        ),
      ),
    );
  }
}
