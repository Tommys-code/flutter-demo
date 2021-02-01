import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

abstract class BaseListPageState<T extends StatefulWidget> extends State<T> {
  EasyRefreshController _controller;

  EasyRefreshController get controller => _controller;

  int _page = 0;
  var params = Map<String, dynamic>();

  List<String> _lists = [];

  @override
  void initState() {
    super.initState();
    _controller = EasyRefreshController();
  }

  @override
  void dispose() {
    super.dispose();
    _controller?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('空视图5'), centerTitle: true),
      body: EasyRefresh(
        firstRefresh: true,
        enableControlFinishRefresh: true,
        enableControlFinishLoad: true,
        controller: _controller,
        child: buildListView(),
        firstRefreshWidget: Container(),
        emptyWidget: _lists?.isEmpty ?? false
            ? Container(
                height: double.infinity,
                child: Center(
                  child: Text('暂无数据'),
                ),
              )
            : null,
        onRefresh: () async {
          onRefresh();
        },
        onLoad: () async {
          loadMore();
        },
      ),
    );
  }

  Widget buildListView() {
    return ListView.builder(
      itemCount: _lists?.length ?? 0,
      itemBuilder: (context, index) {
        return GestureDetector(
          child: Container(
            margin: EdgeInsets.all(10),
            color: Colors.grey,
          ),
          onTap: () {
            onItemTap(context, index);
          },
        );
      },
    );
  }

  onItemTap(BuildContext context, int index) {}

  onRefresh() {
    _page = 0;

    _lists.clear();
    params['page'] = _page;
    loadData(true);
  }

  loadMore() {
    _page = _page + 1;
    params['page'] = _page;
    loadData(false);
  }

  loadData(bool isFirst) {
    Future.delayed(Duration(seconds: 2)).then((value) {
      List<String> data = [];
      if (mounted) {
        setState(() {
          _lists.addAll(data);
          if (isFirst) {
            _controller.resetLoadState();
            _controller.finishRefresh(success: true);
          } else {
            _controller.finishLoad(success: true, noMore: data.isEmpty);
          }
        });
      }
    });
  }

}
