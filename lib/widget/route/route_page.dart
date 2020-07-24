import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'route_page_with_value.dart';

class RouteAppPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _RouteAppPageState();
}

class _RouteAppPageState extends State<RouteAppPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Route 学习'),
        centerTitle: true,
      ),
      body: Center(
        child: ListView(
          children: <Widget>[
            Padding(
              padding:
                  const EdgeInsets.only(left: 10.0, top: 10.0, right: 10.0),
              child: new RaisedButton(
                  child: new Text('路由测试1-MaterialPageRoute'),
                  onPressed: _onPressed1),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(left: 10.0, top: 10.0, right: 10.0),
              child: new RaisedButton(
                  child: new Text('路由测试2-showDialog'), onPressed: _onPressed2),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(left: 10.0, top: 10.0, right: 10.0),
              child: new RaisedButton(
                  child: new Text('路由测试3-传递参数'), onPressed: _onPressed3),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(left: 10.0, top: 10.0, right: 10.0),
              child: new RaisedButton(
                  child: new Text('路由测试4-带返回值'), onPressed: _onPressed4),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(left: 10.0, top: 10.0, right: 10.0),
              child: new Text('参数： $_result'),
            ),
          ],
        ),
      ),
    );
  }

  var _result;

  _onPressed1() async {
    bool value = await Navigator.push(context,
        new MaterialPageRoute<bool>(builder: (BuildContext context) {
      return new Center(
        child: new GestureDetector(
            child: new Text('OK'),
            onTap: () {
              Navigator.pop(context, true);
            }),
      );
    }));

    setState(() {
      _result = value;
    });
  }

  _onPressed2() {
    showDialog<Null>(
        context: context,
        builder: (context) => AlertDialog(
              content: Text('这是一个弹窗'),
              actions: <Widget>[
                FlatButton(
                  child: Text('确定'),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                )
              ],
            ));
  }

  _onPressed3() {
    Navigator.of(context).push(PageRouteBuilder(
      opaque: false, //是否是透明的
      pageBuilder: (BuildContext context, _, __) {
        return RoutePageWithValue('来自RoutePage路由测试3');
      },
      transitionsBuilder: (_, Animation<double> animation, __, Widget child) {
        return new FadeTransition(
          opacity: animation,
          child: new RotationTransition(
            turns: new Tween<double>(begin: 0.5, end: 1.0).animate(animation),
            child: child,
          ),
        );
      },
    ));
  }

  _onPressed4() {
    // 带返回值
    Navigator.of(context).pushNamed('/RoutePageWithValue1').then((value) {
      _result = value;

      setState(() {
        _result = value;
      });
    });
  }

}

class RoutePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RouteAppPage(),
    );
  }
}
