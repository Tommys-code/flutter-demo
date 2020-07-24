import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_demo/common/progreess_dialog.dart';
import 'package:flutter_demo/model/fl_model.dart';
import 'package:flutter_demo/mvp/presenter/fl_presenter.dart';
import 'package:flutter_demo/mvp/presenter/fl_presenter_impl.dart';

import 'gesture/multi_touch_page.dart';

class FirstAppPage extends StatefulWidget {
  FirstAppPage({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    _FirstAppPageState view = new _FirstAppPageState();
    FLPresenter presenter = new FLPresenterImpl(view);
    presenter.init();
    return view;
  }
}

class _FirstAppPageState extends State<FirstAppPage> implements FLView {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();

  ScrollController _scrollController;

  List<FLModel> datas = [];
  FLPresenter _flPresenter;
  int curPageNum = 1;
  bool isSlideUp = false;

  void _scrollListener() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      _loadData(false);
    }
  }

  @override
  void initState() {
    super.initState();
    _loadData(true);
    _scrollController = new ScrollController()..addListener(_scrollListener);
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.removeListener(_scrollListener);
  }

//  Future<Null> _refreshData() {
//    isSlideUp = false;
//    final Completer<Null> completer = new Completer<Null>();
//    curPageNum = 1;
//    _flPresenter.loadFLData(curPageNum, 10);
//    setState(() {});
//    completer.complete(null);
//    return completer.future;
//  }

//  Future<Null> _loadData() {
//    isSlideUp = true;
//    final Completer<Null> completer = new Completer<Null>();
//    curPageNum = curPageNum + 1;
//    _flPresenter.loadFLData(curPageNum, 10);
//    setState(() {});
//    completer.complete(null);
//    return completer.future;
//  }

  Future<bool> _loadData(bool isFirst) {
    isSlideUp = !isFirst;
    final Completer<Null> completer = new Completer<Null>();
    curPageNum = isFirst ? 1 : curPageNum + 1;
    _flPresenter.loadFLData(curPageNum, 10);
    setState(() {});
    completer.complete(null);
    return completer.future;
  }

  @override
  Widget build(BuildContext context) {
    var content;
    if (datas.isEmpty) {
      content = getProgressDialog();
    } else {
      content = new ListView.builder(
        //设置physics属性总是可滚动
        physics: AlwaysScrollableScrollPhysics(),
        controller: _scrollController,
        itemCount: datas.length,
        itemBuilder: buildCard,
      );
    }

    var _refreshIndicator = new RefreshIndicator(
      key: _refreshIndicatorKey,
      onRefresh: () {
        return _loadData(true);
      },
      child: content,
    );

    return _refreshIndicator;
  }

  Widget buildCard(BuildContext context, int index) {
    final String item = datas[index].url;
    return new GestureDetector(
      onTap: () {
        _goPhotoView(item);
      },
      child: new Card(
        child: new Image.network(item),
      ),
    );
  }

  void _goPhotoView(String url) {
    Navigator.of(context).push(new PageRouteBuilder(
        opaque: false,
        pageBuilder: (BuildContext context, _, __) {
          return new MultiTouchPage(url);
        },
        transitionsBuilder: (_, Animation<double> animation, __, Widget child) {
          return new FadeTransition(
            opacity: animation,
            child: new RotationTransition(
              turns: new Tween<double>(begin: 0.5, end: 1.0).animate(animation),
              child: child,
            ),
          );
        }));
  }

  @override
  void onLoadFLFail() {
    // TODO: implement onLoadFLFail
  }

  @override
  void onLoadFLSuc(List<FLModel> list) {
    if (!mounted) return; //异步处理，防止报错
    setState(() {
      if (isSlideUp) {
        datas.addAll(list);
      } else {
        datas = list;
      }
    });
  }

  @override
  setPresenter(FLPresenter presenter) {
    _flPresenter = presenter;
  }
}

class TabFirstPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new FirstAppPage(),
    );
  }
}
