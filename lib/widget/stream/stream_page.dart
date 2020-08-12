import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/common/progreess_dialog.dart';

class StreamPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _StreamPageState();
}

class _StreamPageState extends State<StreamPage> {
  List<int> item;

  StreamController<List<int>> _controller;

  _initStreamController() {
    _controller = StreamController.broadcast();
    _controller.stream.listen((event) {
      print(event);
      if (item == null) item = [];
      item.addAll(event);
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller?.close();
    _controller = null;
  }

  @override
  void initState() {
    super.initState();
    _initStreamController();
    mockNetworkData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('StreamController'), centerTitle: true),
      body: Center(
        child: _build(),
      ),
    );
  }

  Widget _build() {
    return item == null
        ? getProgressDialog()
        : item.isEmpty
            ? Text('暂无数据')
            : ListView.builder(
                itemBuilder: (context, index) {
                  return ListTile(title: Text('${item[index]}'));
                },
                itemCount: item.length,
              );
  }

  mockNetworkData() async {
    var empty = List<int>();
    var data = [0,1,2,3,4,5,6,7,8,9];
    Future.delayed(Duration(seconds: 2), () => data)
        .asStream()
        .map((event) => event)
        .pipe(_controller);
  }
}
