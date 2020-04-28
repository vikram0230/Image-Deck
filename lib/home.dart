import 'package:flutter/material.dart';
import 'Widgets/customTextField.dart';
import 'constants.dart';
import 'classy.dart';

class Home extends StatefulWidget {
  static String id = '/';
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Widget> homeWidgets = [CustomTextField()];
  String dropdownValue = '1';

  void getTextFields(folderCount){
    homeWidgets = [CustomTextField()];
    for(int i = 1; i < folderCount; i++){
      homeWidgets.add(
          CustomTextField()
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text("Image Deck",
            style: TextStyle(
              fontFamily: 'Berkshire',
              color: Colors.white
            ),
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
                  Text('Folder Count :',
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
                    items: <String>['1','2','3','4','5','6'].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: TextStyle(fontSize: 25),
//                          textAlign: TextAlign.center,
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
              itemBuilder: (BuildContext context, int index){
                return homeWidgets[index];
              }
            ),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 100.0),
        child: FlatButton(
          padding: EdgeInsets.symmetric(vertical: 15.0,horizontal: 10.0),
          onPressed: (){
            Navigator.pushNamed(context, Classy.id,
              arguments: FolderNameArguments(
                f1: 'Folder 1',
                f2: 'Folder 2',
                f3: 'Folder 3',
                f4: 'Folder 4',
                f5: 'Folder 5',
                f6: 'Folder 6',
              ),
            );
          },
          color: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0)
          ),
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


