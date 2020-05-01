import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:directory_picker/directory_picker.dart';
import 'package:path/path.dart' as path;
import 'dart:async';

class DirectoryOperations{

  static Future<String> createAppDirectory() async {
    String folderName = 'Image Deck';

    final Directory _appDocDir = await getExternalStorageDirectory();
    //App Document Directory + folder name
    final Directory _appDocDirFolder =  Directory('${_appDocDir.path}/');

    if(await _appDocDirFolder.exists()){
      //if folder already exists return path
      print('Folder already exists: ${_appDocDir.path}/$folderName/');
      return _appDocDirFolder.path;
    }
    else{//if folder not exists create folder and then return its path
      final Directory _appDocDirNewFolder = await _appDocDirFolder.create(recursive: true);
      print('Folder Created: ${_appDocDir.path}/$folderName/');
      return _appDocDirNewFolder.path;
    }
  }

  static Future<String> createDirectory(folderName) async {

    final Directory _appDocDir = await getExternalStorageDirectory();
    //App Document Directory + folder name
    final Directory _appDocDirFolder = Directory(path.join(_appDocDir.path,folderName));

    if(await _appDocDirFolder.exists()){
      //if folder already exists return path
      print('Folder already exists: ${_appDocDir.path}$folderName/');
      return _appDocDirFolder.path;
    }
    else{//if folder not exists create folder and then return its path
      final Directory _appDocDirNewFolder = await _appDocDirFolder.create(recursive: true);
      print('Folder Created: ${_appDocDir.path}$folderName/');
      return _appDocDirNewFolder.path;
    }
  }

  static Future<String> pickDirectory(BuildContext context, Directory selectedDirectory) async {
    Directory directory = selectedDirectory;
    if (directory == null) {
      directory = await getExternalStorageDirectory();
    }

    Directory newDirectory = await DirectoryPicker.pick(
        allowFolderCreation: true,
        context: context,
        rootDirectory: directory,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))));
    selectedDirectory = newDirectory;
    print(selectedDirectory.path);
    return selectedDirectory.path;
  }
}