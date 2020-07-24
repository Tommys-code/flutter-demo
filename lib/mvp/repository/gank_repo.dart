import 'package:flutter_demo/model/gank_model.dart';

abstract class GankRepo {
  Future<List<GankModel>> fetch(String type, int pageNum, int pageSize);
}
