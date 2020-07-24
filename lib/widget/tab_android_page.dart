import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_demo/common/progreess_dialog.dart';
import 'package:flutter_demo/model/gank_model.dart';
import 'package:flutter_demo/mvp/presenter/gank_presenter.dart';
import 'package:flutter_demo/mvp/presenter/gank_presenter_impl.dart';
import 'package:flutter_demo/util/routes_util.dart';

class CategoryAppPage extends StatefulWidget {
  final String category;

  const CategoryAppPage(this.category);

  @override
  State<StatefulWidget> createState() {
    _CategoryAppPageState view = new _CategoryAppPageState();
    GankPresenter presenter = new GankPresenterImpl(view);
    presenter.init();
    return view;
  }
}

class _CategoryAppPageState extends State<CategoryAppPage> implements GankView {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();

  ScrollController _scrollController;

  List<GankModel> datas = [];
  GankPresenter _gankPresenter;
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

  Future<Null> _loadData(bool isFirst) {
    isSlideUp = !isFirst;
    final Completer<Null> completer = new Completer<Null>();
    curPageNum = isFirst ? 1 : curPageNum + 1;
    _gankPresenter.loadGankData(widget.category, curPageNum, 10);
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
      content = new ListView.separated(
        //设置physics属性总是可滚动
        physics: AlwaysScrollableScrollPhysics(),
        controller: _scrollController,
        itemCount: datas.length,
        itemBuilder: buildItem,
        separatorBuilder: (BuildContext context, int index) {
          return Divider(
            height: 1.0,
            color: Colors.blue,
            indent: 10,
            endIndent: 10,
          );
        },
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

  Widget buildItem(BuildContext context, int index) {
    final item = datas[index];
    return ListTile(
      leading: CircleAvatar(
        backgroundImage:
            NetworkImage(item.images.length > 0 ? item.images[0] : ''),
      ),
      title: Text(item.author),
      subtitle: Text(item.desc),
      trailing: Icon(Icons.keyboard_arrow_right),
      onTap: () {
        RouteUtil.route2Web(context, item.author, item.url);
      },
    );
  }

  @override
  void onLoadFLFail() {
    // TODO: implement onLoadFLFail
  }

  @override
  void onLoadFLSuc(List<GankModel> list) {
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
  setPresenter(presenter) {
    _gankPresenter = presenter;
  }
}

class TabCategoryPage extends StatelessWidget {
  final String category;

  const TabCategoryPage(this.category);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new CategoryAppPage(category),
    );
  }
}
