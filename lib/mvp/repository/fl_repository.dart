import 'package:flutter_demo/model/fl_model.dart';

abstract class FLRepository {
  Future<List<FLModel>> fetch(int pageNum, int pageSize);
}
