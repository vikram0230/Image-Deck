import 'dart:async';
import 'dart:io';

import 'package:directory_picker/directory_picker.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

class DirectoryOperations {
  static Future<String> createAppDirectory() async {
    String folderName = 'Image Deck';

//    final Directory _appDocDir = await getExternalStorageDirectory();
    final Directory _appDocDir = Directory('/storage/emulated/0');
    final Directory _appDocDirFolder = Directory('${_appDocDir.path}');

    if (await _appDocDirFolder.exists()) {
//      print('Folder already exists: ${_appDocDir.path}/$folderName');
      return _appDocDirFolder.path;
    }
    else {
      final Directory _appDocDirNewFolder =
          await _appDocDirFolder.create(recursive: true);
//      print('Folder Created: ${_appDocDir.path}/$folderName');
      return _appDocDirNewFolder.path;
    }
  }

  static Future<String> createDirectory(folderName) async {
//    final Directory _appDocDir = await getExternalStorageDirectory();
    final Directory _appDocDir = Directory('/storage/emulated/0/Image Deck/');
    final Directory _appDocDirFolder =
        Directory(path.join(_appDocDir.path, folderName));

    if (await _appDocDirFolder.exists()) {
      print('Folder already exists: ${_appDocDir.path}$folderName/');
      return _appDocDirFolder.path;
    }
    else {
      final Directory _appDocDirNewFolder =
          await _appDocDirFolder.create(recursive: true);
      print('Folder Created: ${_appDocDir.path}$folderName/');
      return _appDocDirNewFolder.path;
    }
  }

  static Future<String> pickDirectory(
      BuildContext context, Directory parentDirectory) async {
    Directory selectedDirectory;
    if (parentDirectory == null) {
      parentDirectory = await getExternalStorageDirectory();
    }

    Directory newDirectory = await DirectoryPicker.pick(
        allowFolderCreation: true,
        context: context,
        rootDirectory: parentDirectory,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))));
    selectedDirectory = newDirectory;
    print(selectedDirectory.path);

    return selectedDirectory.path;
  }
}
