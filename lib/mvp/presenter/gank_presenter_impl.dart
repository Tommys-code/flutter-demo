import 'package:flutter_demo/mvp/presenter/gank_presenter.dart';
import 'package:flutter_demo/mvp/repository/gank_repo.dart';
import 'package:flutter_demo/mvp/repository/gank_repo_impl.dart';

class GankPresenterImpl implements GankPresenter {
  GankView _view;
  GankRepo _repository;

  GankPresenterImpl(this._view) {
    _view.setPresenter(this);
  }

  @override
  init() {
    _repository = GankRepoImpl();
  }

  @override
  loadGankData(String type, int pageNum, int pageSize) {
    assert(_view != null);

    _repository.fetch(type, pageNum, pageSize).then((data) {
      _view.onLoadFLSuc(data);
    }).catchError((error) {
      print(error);
      _view.onLoadFLFail();
    });
  }
}
