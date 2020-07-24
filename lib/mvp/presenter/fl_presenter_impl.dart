import 'package:flutter_demo/mvp/presenter/fl_presenter.dart';
import 'package:flutter_demo/mvp/repository/fl_repository.dart';
import 'package:flutter_demo/mvp/repository/fl_repository_impl.dart';

class FLPresenterImpl implements FLPresenter {
  FLView _view;
  FLRepository _repository;

  FLPresenterImpl(this._view) {
    _view.setPresenter(this);
  }

  @override
  init() {
    _repository = new FLRepositoryImpl();
  }

  @override
  loadFLData(int pageNum, int pageSize) {
    assert(_view != null);

    _repository.fetch(pageNum, pageSize).then((data) {
      _view.onLoadFLSuc(data);
    }).catchError((error) {
      print(error);
      _view.onLoadFLFail();
    });
  }
}
