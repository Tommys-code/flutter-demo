import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ChannelPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ChannelPageState();
}

class _ChannelPageState extends State<ChannelPage> {
  //获取到插件与原生的交互通道
  static const jumpPlugin = const MethodChannel('com.tommy.jump/plugin');
  static const counterPlugin = const EventChannel('com.tommy.counter/plugin');

  Future<dynamic> platformCallHandler(MethodCall call) async {
    switch (call.method) {
      case "getFlutterName":
        return "Flutter name flutter";
        break;
    }
  }

  StreamSubscription _counterSub;
  var _count;

  @override
  void initState() {
    super.initState();
    _startCounterPlugin();
    jumpPlugin.setMethodCallHandler(platformCallHandler);
  }

  @override
  void dispose() {
    super.dispose();
    _endCounterPlugin();
  }

  void _startCounterPlugin() {
    if (_counterSub == null) {
      _counterSub = counterPlugin.receiveBroadcastStream().listen((event) {
        setState(() {
          _count = event;
        });
      }, onError: (error) {
        setState(() {
          _count = "计时器异常";
          print(error);
        });
      });
    }
  }

  void _endCounterPlugin(){
    if(_counterSub != null){
      _counterSub.cancel();
    }
  }

  Future<Null> _jumpToNative() async {
    String result = await jumpPlugin.invokeMethod('oneAct');
    print(result);
  }

  Future<Null> _jumpToNativeWithValue() async {
    Map<String, String> map = {"flutter": "这是一条来自flutter的参数"};
    String result = await jumpPlugin.invokeMethod('twoAct', map);
    print(result);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Channel'), centerTitle: true),
      body: Center(
        child: ListView(
          children: <Widget>[
            Padding(
              padding:
                  const EdgeInsets.only(left: 10.0, top: 10.0, right: 10.0),
              child: RaisedButton(
                  textColor: Colors.black,
                  child: Text('跳转到原生界面'),
                  onPressed: () {
                    _jumpToNative();
                  }),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(left: 10.0, top: 10.0, right: 10.0),
              child: RaisedButton(
                  textColor: Colors.black,
                  child: Text('跳转到原生界面(带参数)'),
                  onPressed: () {
                    _jumpToNativeWithValue();
                  }),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 10.0, top: 10.0, right: 10.0),
              child: Text('这是一个从原生发射过来的计时器：$_count'),
            )
          ],
        ),
      ),
    );
  }
}
