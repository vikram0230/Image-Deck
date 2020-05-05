import 'dart:async';
import 'package:photo_manager/photo_manager.dart';

class AssetProvider {
  Map<AssetPathEntity, AssetPaging> _dataMap = {};

  AssetPathEntity current;
  var paging;

//  AssetPathEntity get _current => current;

//  set _current(AssetPathEntity _current) {
//    current = _current;
//    print(_dataMap[_current].toString());
//    if (_dataMap[_current] == null) {
//      final paging = AssetPaging(_current);
//      print('called Asset paging');
//      _dataMap[_current] = paging;
//    }
//  }

  AssetPaging getPaging(){
    if (_dataMap[current] == null) {
//      print(current.toString());
      final paging = AssetPaging(current);
//      print('called Asset paging \nPaging: '+paging.data.toString());
      _dataMap[current] = paging;
    }
//    print('DataMap: '+_dataMap.toString());
    return _dataMap[current];
  }


  List<AssetEntity> getData(){
    print('Data: '+ paging?.data.toString());
    return _dataMap[current]?.data ?? [];
  }

  Future<List<AssetEntity>> loadMore(current) async {
    this.current = current;
    paging = getPaging();
    if (paging != null) {
      await paging.loadMore();
      print('Paging: ' + paging.data.length.toString());
    }
    return paging.data;
  }

//  List<AssetEntity> getData() => data;

//  AssetPaging getPaging() => _dataMap[_current];

  bool get noMore => getPaging()?.noMore ?? false;

//  int get count => data?.length ?? 0;
}

class AssetPaging {
  int page = 0;

  List<AssetEntity> data = [];

  final AssetPathEntity path;

  final int pageCount;

  bool noMore = false;

  AssetPaging(this.path, {this.pageCount = 20000});

  Future<void> loadMore() async {
    if (noMore == true) {
      return;
    }
    print(this.path.toString());
    var data = await path.getAssetListPaged(page, pageCount);
//    print('Data: '+data.toString());
    if (data.length == 0) {
      noMore = true;
    }
    page++;
    this.data.addAll(data);
    print('Data Length: '+ data.length.toString());
  }
}
