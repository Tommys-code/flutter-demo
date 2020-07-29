import 'dart:convert';
import 'dart:io';

import 'package:flutter_demo/model/fl_model.dart';
import 'package:flutter_demo/mvp/repository/fl_repository.dart';

import '../../constant.dart';

//分类数据: https://gank.io/api/v2/data/category/<category>/type/<type>/page/<page>/count/<count>
//https://api.apiopen.top/getJoke?page=1&count=2&type=image
//数据类型： 福利 | Android | iOS | 休息视频 | 拓展资源 | 前端 | all
//请求个数： 数字，大于0
//第几页：数字，大于0
//@param pageNum
//@param pageSize
//@return
class FLRepositoryImpl implements FLRepository {
  @override
  Future<List<FLModel>> fetch(int pageNum, int pageSize) {
    return _getData(pageNum, pageSize);
  }
}

Future<List<FLModel>> _getData(int pageNum, int pageSize) async {
  var httpClient = new HttpClient();
  var url = Constant.baseUrl + 'data/category/Girl/type/Girl/page/$pageNum/count/$pageSize';

  print(url);
  List flModels;
  try {
    var request = await httpClient.getUrl(Uri.parse(url));
    var response = await request.close();
    if (response.statusCode == HttpStatus.ok) {
      var json = await response.transform(Utf8Decoder()).join();
      flModels = jsonDecode(json)['data'];
    } else {
      //todo
    }
  } catch (exception) {
    //todo
  }

  return flModels.map((model) {
    return new FLModel.fromJson(model);
  }).toList();
}
