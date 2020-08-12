import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AsyncPage extends StatelessWidget {
  ///ConnectionState.none:当前没有异步任务，比如[FutureBuilder]的[future]为null时
  ///ConnectionState.waiting: 异步任务处于等待状态
  ///ConnectionState.active: Stream处于激活状态（流上已经有数据传递了），对于FutureBuilder没有该状态。
  ///ConnectionState.done: 异步任务已经终止.

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FutureBuilder和StreamBuilder'),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Center(child: _futureBuilder()),
          Center(child: _streamBuilder()),
        ],
      ),
    );
  }

  FutureBuilder _futureBuilder() {
    return FutureBuilder(
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        // 请求已结束
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            // 请求失败，显示错误
            return Text("Error: ${snapshot.error}");
          } else {
            // 请求成功，显示数据
            return Text("Contents: ${snapshot.data}");
          }
        } else {
          // 请求未结束，显示loading
          return CircularProgressIndicator();
        }
      },
      future: mockNetworkData(),
      initialData: 'initialData',
    );
  }

  Future<String> mockNetworkData() async {
//    return Future.delayed(Duration(seconds: 2),()=> throw Exception("错误"));
    return Future.delayed(Duration(seconds: 2), () => "我是从互联网上获取的数据");
  }

  StreamBuilder _streamBuilder() {
    return StreamBuilder<int>(
      builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
        if (snapshot.hasError) return Text('Error: ${snapshot.error}');
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            return Text('没有Stream');
          case ConnectionState.waiting:
            return Text('等待数据...');
          case ConnectionState.active:
            return Text('active: ${snapshot.data}');
          case ConnectionState.done:
            return Text('Stream已关闭');
        }
        return null; // unreachable
      },
      stream: counter(),
    );
  }

  Stream<int> counter() {
    return Stream.periodic(Duration(seconds: 1), (i) => i).take(10);
  }
}
