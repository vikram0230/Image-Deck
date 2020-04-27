import 'package:flutter/material.dart';


class Home extends StatefulWidget {
  static String id = '/';
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Widget> homeWidgets = [];
  String dropdownValue = '2';

  void getInitialWidgets(){
    homeWidgets.add(
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
                items: <String>['1','2','3','4','5'].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      )
    );
  }

  void getTextFields(folderCount){
    for(int i = 1; i <= folderCount; i++){
      homeWidgets.add(
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                cursorColor: Colors.white,
                onChanged: (value){},
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                      )
                  ),
                  labelText: 'Folder $i',
                ),
              ),
            ),
          )
      );
    }
  }

   @override
  void initState() {
    super.initState();
    getInitialWidgets();
  }

  @override
  Widget build(BuildContext context) {
//    getInitialWidgets();
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text("Folder Details",
            style: TextStyle(),
          ),
        ),
      ),
      body: ListView(
        children: homeWidgets,
      )
    );
  }
}


//Text("Image Deck",
//style: TextStyle(fontFamily: 'Berkshire'),),