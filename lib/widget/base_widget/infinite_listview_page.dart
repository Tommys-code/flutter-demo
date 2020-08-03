import 'package:english_words/english_words.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class InfiniteListViewPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _InfiniteListViewPageState();
}

class _InfiniteListViewPageState extends State<InfiniteListViewPage> {
  static const loadingTag = "##loading##"; //表尾标记
  var _words = <String>[loadingTag];

  static const maxSize = 100;
  ScrollController _scrollController;

  void _scrollListener() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      if(_words.length-1 < 100) _loadData();
    }
  }

  @override
  void initState() {
    super.initState();
    _scrollController = new ScrollController()..addListener(_scrollListener);
    _loadData();
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('无限加载列表'),
        centerTitle: true,
      ),
      body: ListView.separated(
        itemBuilder: _itemBuilder,
        separatorBuilder: (context, index) => Divider(),
        itemCount: _words.length,
        controller: _scrollController,
      ),
    );
  }

  Widget _itemBuilder(BuildContext context, int index) {
    if (_words[index] == loadingTag) {
      if (_words.length - 1 < maxSize) {
        return Container(
          padding: const EdgeInsets.all(16.0),
          alignment: Alignment.center,
          child: SizedBox(
              width: 24.0,
              height: 24.0,
              child: CircularProgressIndicator(strokeWidth: 2.0)),
        );
      } else {
        //已经加载了100条数据，不再获取数据。
        return Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(16.0),
            child: Text(
              "没有更多了",
              style: TextStyle(color: Colors.grey),
            ));
      }
    }
    return ListTile(title: Text(_words[index]));
  }

  _loadData() async {
    Future.delayed(Duration(seconds: 2)).then((value) {
      setState(() {
        //重新构建列表
        _words.insertAll(_words.length - 1,
            //每次生成20个单词
            generateWordPairs().take(20).map((e) => e.asPascalCase).toList()
        );
      });
    });
  }
}
