import 'package:flutter_demo/model/fl_model.dart';
import '../mvp.dart';

abstract class FLPresenter implements IPresenter {
  loadFLData(int pageNum, int pageSize);
}

abstract class FLView implements IView<FLPresenter> {
  void onLoadFLSuc(List<FLModel> list);

  void onLoadFLFail();
}
