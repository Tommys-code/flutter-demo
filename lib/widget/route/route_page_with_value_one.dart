import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RoutePageWithValue1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    _onPressed() {
      Navigator.of(context).pop('这是来自RoutePageWithValue1的返回值');
    }

    _onPressed1() {
      //第一个参数表示将要加入栈中的页面，第二个参数表示栈中要保留的页面底线，意思就是在predicate和newRoute之间的页面都会被移除栈
      Navigator.of(context).pushNamedAndRemoveUntil(
          '/HomePage', (Route<dynamic> route) => false);
    }

    _onPressed2() {
      //第一个参数表示将要加入栈中的页面，第二个参数表示栈中要保留的页面底线，意思就是在predicate和newRoute之间的页面都会被移除栈
      Navigator.of(context).pushNamedAndRemoveUntil(
          '/RoutePageWithValue2', ModalRoute.withName('/HomePage'),);
    }

    _onPressed3() {
      Navigator.popUntil(context, ModalRoute.withName('/HomePage'));
    }

    _onPressed4() {
      Navigator.of(context).pushReplacementNamed('/RoutePageWithValue2');
    }

    _onPressed5() {
      Navigator.popAndPushNamed(context, '/RoutePageWithValue2');
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('RoutePageWithValue1'),
        centerTitle: true,
      ),
      body: Center(
        child: ListView(
          children: <Widget>[
            Padding(
              padding:
              const EdgeInsets.only(left: 10.0, top: 10.0, right: 10.0),
              child: RaisedButton(
                child: Text('点击带参数返回'),
                onPressed: _onPressed,
              ),
            ),
            Padding(
              padding:
              const EdgeInsets.only(left: 10.0, top: 10.0, right: 10.0),
              child: RaisedButton(
                child: Text('销毁其他所有的页面，点击直接去新的HomePage'),
                onPressed: _onPressed1,
              ),
            ),
            Padding(
              padding:
              const EdgeInsets.only(left: 10.0, top: 10.0, right: 10.0),
              child: RaisedButton(
                child: Text('跳转页面，并销毁除HomePage的所有页面'),
                onPressed: _onPressed2,
              ),
            ),
            Padding(
              padding:
              const EdgeInsets.only(left: 10.0, top: 10.0, right: 10.0),
              child: RaisedButton(
                child: Text('一直退出直到HomePage'),
                onPressed: _onPressed3,
              ),
            ),
            Padding(
              padding:
              const EdgeInsets.only(left: 10.0, top: 10.0, right: 10.0),
              child: RaisedButton(
                child: Text('跳转并销毁当前页面（1）'),
                onPressed: _onPressed4,
              ),
            ),
            Padding(
              padding:
              const EdgeInsets.only(left: 10.0, top: 10.0, right: 10.0),
              child: RaisedButton(
                child: Text('跳转并销毁当前页面（视觉效果上是先退出再进入）'),
                onPressed: _onPressed5,
              ),
            )
          ],
        ),
      ),
    );
  }
}
