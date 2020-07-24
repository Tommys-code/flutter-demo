import 'package:flutter_demo/model/gank_model.dart';
import 'package:flutter_demo/mvp/mvp.dart';

abstract class GankPresenter implements IPresenter {
  loadGankData(String type, int pageNum, int pageSize);
}

abstract class GankView implements IView{
  void onLoadFLSuc(List<GankModel> list);

  void onLoadFLFail();
}
