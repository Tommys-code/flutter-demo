import 'dart:convert';
import 'dart:io';

import 'package:flutter_demo/model/gank_model.dart';

import '../../constant.dart';
import 'gank_repo.dart';

//https://gank.io/api/v2/data/category/<category>/type/<type>/page/<page>/count/<count>
//category 可接受参数 All(所有分类) | Article | GanHuo | Girl
//type 可接受参数 All(全部类型) | Android | iOS | Flutter | Girl ...，即分类API返回的类型数据
//count: [10, 50]
//page: >=1
class GankRepoImpl implements GankRepo {
  @override
  Future<List<GankModel>> fetch(String type, int pageNum, int pageSize) {
    return _getData(type, pageNum, pageSize);
  }
}

Future<List<GankModel>> _getData(String type, int pageNum, int pageSize) async {
  var httpClient = new HttpClient();
  var url = Constant.baseUrl +
      'data/category/GanHuo/type/$type/page/$pageNum/count/$pageSize';

  print(url);
  List gkModels;
  try {
    var request = await httpClient.getUrl(Uri.parse(url));
    var response = await request.close();
    if (response.statusCode == HttpStatus.ok) {
      var json = await response.transform(Utf8Decoder()).join();
      gkModels = jsonDecode(json)['data'];
    } else {
      //todo
    }
  } catch (exception) {
    //todo
  }

  return gkModels.map((model) {
    return new GankModel.fromJson(model);
  }).toList();
}
