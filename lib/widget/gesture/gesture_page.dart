import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GestureAppPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _GestureAppPageState();
}

class _GestureAppPageState extends State<GestureAppPage> {
  var tapEvent = '';

  //定义一个状态，保存当前指针位置
  PointerEvent _event;

  _showSnakeBar(String str) {
    final snackBar = SnackBar(content: new Text(str));
    Scaffold.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gesture 学习'),
        centerTitle: true,
      ),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 10, top: 10, right: 10),
            child: RaisedButton(
              textColor: Colors.black,
              child: new Text('RaisedButton 点击'),
              onPressed: () {
                _showSnakeBar('这是一个 RaisedButton 点击事件,onPressed处理');
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10.0, top: 10.0, right: 10.0),
            child: new GestureDetector(
              onTap: () {
                _showSnakeBar("这是一个GestureDetector监听的onTap事件");
              },
              child: BorderButton('GestureDetector onTap 按钮'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10.0, top: 10.0, right: 10.0),
            child: Text(tapEvent, style: Theme.of(context).textTheme.headline4),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10.0, top: 10.0, right: 10.0),
            child: GestureDetector(
              onTapDown: (tapDown) {
                setState(() {
                  tapEvent = '这是GestureDetector监听的onTapDown事件';
                });
              },
              onTapUp: (tabUp) {
                setState(() {
                  tapEvent = '这是GestureDetector监听的onTapUp事件';
                });
              },
              onTapCancel: () {
                setState(() {
                  tapEvent = '这是GestureDetector监听的onTapCancel事件';
                });
              },
              onDoubleTap: () {
                setState(() {
                  tapEvent = '这是GestureDetector监听的onDoubleTap事件';
                });
              },
              onLongPress: () {
                setState(() {
                  tapEvent = '这是GestureDetector监听的onLongPress事件';
                });
              },
              child: BorderButton('GestureDetector onTap 分解事件按钮'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10.0, top: 10.0, right: 10.0),
            child: Text('上面的按钮通过GestureDetector监听事件后，涟漪效果消失了，使用下面的方案解决'),
          ),
          Padding(
              padding: const EdgeInsets.only(left: 10.0, top: 10.0, right: 10.0),
              child: InkWell(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                onTap: () {
                  _showSnakeBar("这是一个InkWell监听的onTap事件");
                },
                child: BorderButton('InkWell 按钮'),
              )),
          Padding(
              padding: const EdgeInsets.only(left: 10.0, top: 10.0, right: 10.0),
              child: InkWell(
                borderRadius: BorderRadius.all(new Radius.circular(10.0)),
                onTap: () {
                  Navigator.pushNamed(context, '/DismissedPage');
                },
                child: BorderButton('Dismissed 手势'),
              )),
          SizedBox(height: 20),
          Listener(
            child: Container(
              alignment: Alignment.center,
              color: Colors.blue,
              width: 300.0,
              height: 150.0,
              child: Text(_event?.toString()??"",style: TextStyle(color: Colors.white)),
            ),
            onPointerUp: (PointerUpEvent event) => setState(()=>_event=event),
            onPointerDown: (PointerDownEvent event) => setState(()=>_event=event),
            onPointerMove: (PointerMoveEvent event) => setState(()=>_event=event)
          )
        ],
      ),
    );
  }
}

class BorderButton extends StatelessWidget {
  final String text;

  BorderButton(this.text);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(10.0),
      height: 48.0,
      decoration: new BoxDecoration(
        border: new Border.all(
          width: 1.0,
          color: Colors.blue,
        ),
        borderRadius: new BorderRadius.all(new Radius.circular(10.0)),
      ),
//      foregroundDecoration: new BoxDecoration(
//        border: new Border.all(
//          width: 1.0,
//          color: Colors.red,
//        ),
//        borderRadius: new BorderRadius.all(new Radius.circular(10.0)),
//      ),
      child: new Text(text),
    );
  }
}

class GesturePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: GestureAppPage());
  }
}
