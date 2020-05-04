import 'dart:async';
import 'package:photo_manager/photo_manager.dart';

class AssetProvider {
  Map<AssetPathEntity, AssetPaging> _dataMap = {};

  AssetPathEntity current;

  AssetPathEntity get _current => current;

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
    if (_dataMap[_current] == null) {
      print(_current.toString());
      final paging = AssetPaging(_current);
      print('called Asset paging');
      _dataMap[_current] = paging;
    }
    return _dataMap[_current];
  }

  List<AssetEntity> get data => _dataMap[_current]?.data ?? [];

  Future<void> loadMore() async {
    final paging = getPaging();
    if (paging != null) {
      await paging.loadMore();
    }
  }

//  AssetPaging getPaging() => _dataMap[_current];

  bool get noMore => getPaging()?.noMore ?? false;

  int get count => data?.length ?? 0;
}

class AssetPaging {
  int page = 0;

  List<AssetEntity> data = [];

  final AssetPathEntity path;

  final int pageCount;

  bool noMore = false;

  AssetPaging(this.path, {this.pageCount = 50});

  Future<void> loadMore() async {
    if (noMore == true) {
      return;
    }
    print(this.path.toString());
    var data = await path.getAssetListPaged(page, pageCount);
    if (data.length == 0) {
      noMore = true;
    }
    page++;
    this.data.addAll(data);
  }
}
