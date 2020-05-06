//import 'dart:io';
//import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
//import 'package:image_deck/Widgets/directoryOperations.dart';
import 'package:image_picker/image_picker.dart';
//import 'package:directory_picker/directory_picker.dart';
import 'package:photo_manager/photo_manager.dart';
import 'Widgets/folderButton.dart';
import 'Provider/asset_provider.dart';
import 'package:image_deck/Provider/config_provider.dart';
import 'options.dart';
import 'constants.dart';
import 'dart:async';
import 'dart:typed_data';

class Classy extends StatefulWidget {
  static String id = 'classy';

  final List<AssetEntity> list;
//  final int initIndex;
  final bool isPreview = true;
//  final PhotoPreviewResult result;
//  final AssetProvider assetProvider;


  Classy({
    this.list,
//    this.initIndex,
//    this.result,
//    this.assetProvider,
  });

  @override
  _ClassyState createState() => _ClassyState();
}

class _ClassyState extends State<Classy> {
  dynamic _image;
  List<String> folderNames = [];
  List<Widget> folders = [];
  List<AssetPathEntity> photoList;

  PhotoPickerProvider get config => PhotoPickerProvider.of(context);
  AssetProvider get assetProvider => AssetProvider();
  Options get options => config.options;
  PageController pageController;
//  List<AssetEntity> get list {
//    return assetProvider.data;
//  }
  StreamController<int> pageChangeController = StreamController.broadcast();
  Stream<int> get pageStream => pageChangeController.stream;
  List<AssetEntity> list = [];

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
    });
    Navigator.of(context).pop();
  }

  void getImageList() async {
    photoList = await PhotoManager.getAssetPathList(type: RequestType.image);
    List<AssetPathEntity> videoList = await PhotoManager.getAssetPathList(type: RequestType.video);
    print('got images');
    for(var i in photoList){
      print(i.toString());
    }
    print('\n\n');
    for(var i in videoList){
      print(i.toString());
    }

    if (photoList.isNotEmpty) {
//      print('images passed to asset provider with ' + photoList[0].toString());
      assetProvider.current = photoList[0];
      list = await _loadMore();
      print('List: '+list.length.toString());
//      list = await assetProvider.loadMore(photoList[0]);
//      print('images loaded');
//      AssetPaging pagedAssets = assetProvider.getPaging();
//      print(pagedAssets.toString());
//      print('paging done');
    }
//    list = assetProvider.getData();
//
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
  void initState() {
    super.initState();
    pageController = PageController();
//    getImageList();
  }

  @override
  Widget build(BuildContext context) {
    getFolders();
    getImageList();

    int totalCount = assetProvider.current?.assetCount ?? 0;
    if (!widget.isPreview) {
      totalCount = assetProvider.current.assetCount;
    } else {
      totalCount = list?.length;
    }
    print('total count: ' + totalCount.toString());

    return Scaffold(
      appBar: AppBar(
        title: Text("Image Deck",
          style: TextStyle(fontFamily: 'Berkshire'),
        ),
        backgroundColor: Colors.black,
      ),
      body: Center(
        child:
//        _image == null ?
//        FlatButton(
//          onPressed: () async {
//            print('button pressed');
//  //          Directory _appDocDir = await getExternalStorageDirectory();
////            String selectedDirectory = DirectoryOperations.pickDirectory(context, Directory('/storage/emulated/0/')).toString();
////            print(selectedDirectory);
////            getImage();
//            getImageList();
//          },
//          child: Container(
//            child: Center(
//              child: Column(
//                mainAxisAlignment: MainAxisAlignment.center,
//                children: <Widget>[
//                  Padding(
//                    padding: const EdgeInsets.all(15.0),
//                    child: Icon(
//                      Icons.add_circle_outline,
//                      size: 100,
//                      color: Colors.black26,
//                    ),
//                  ),
//                  Text(
//                    'Tap to add Images',
//                    style: TextStyle(
//                      color: Colors.black38,
//                    ),
//                  ),
//                ],
//              ),
//            ),
//          ),
//        ):
        PageView.builder(
//          controller: pageController,
          itemBuilder: _buildItem,
          itemCount: totalCount,
//          onPageChanged: _onPageChanged,
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

  Future<List<AssetEntity>> _loadMore() async {
    return assetProvider.loadMore(photoList[0]);
  }

  void _onPageChanged(int value) {
    pageChangeController.add(value);
  }

  Widget _buildLoadingWidget(AssetEntity entity) {
    return options.loadingDelegate.buildBigImageLoading(context, entity, Colors.black);
  }

  Widget _buildItem(BuildContext context, int index) {
//    if (!widget.isPreview && index >= list.length - 5) {
//      _loadMore();
//    }
//    list = assetProvider.getData();
    print('List: '+list?.length.toString());
    var data = list[index];
    return BigPhotoImage(
      assetEntity: data,
      loadingWidget: _buildLoadingWidget(data),
    );
  }
}

class BigPhotoImage extends StatefulWidget {
  final AssetEntity assetEntity;
  final Widget loadingWidget;

  const BigPhotoImage({
    Key key,
    this.assetEntity,
    this.loadingWidget,
  }) : super(key: key);

  @override
  _BigPhotoImageState createState() => _BigPhotoImageState();
}

class _BigPhotoImageState extends State<BigPhotoImage>
    with AutomaticKeepAliveClientMixin {
  Widget get loadingWidget {
    return widget.loadingWidget ?? Container();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return FutureBuilder(
      future:
      widget.assetEntity.thumbDataWithSize(width.floor(), height.floor()),
      builder: (BuildContext context, AsyncSnapshot<Uint8List> snapshot) {
        var file = snapshot.data;
        if (snapshot.connectionState == ConnectionState.done && file != null) {
          print(file.length);
          return Image.memory(
            file,
            fit: BoxFit.contain,
            width: double.infinity,
            height: double.infinity,
          );
        }
        return loadingWidget;
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class PhotoPreviewResult {
  List<AssetEntity> previewSelectedList = [];
}


//ListView.builder(
//scrollDirection: Axis.horizontal,
//physics: BouncingScrollPhysics(),
//itemCount: folders.length,
//itemBuilder: (BuildContext context, int index){
//return folders[index];
//}
//),




