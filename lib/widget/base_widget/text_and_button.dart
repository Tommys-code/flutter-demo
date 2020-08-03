import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class TextAndButtonWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TextAndButtonWidget();
}

class _TextAndButtonWidget extends State<TextAndButtonWidget> {
  /*
    this.style, // 样式
    this.strutStyle, // 使用的支柱风格
    this.textAlign, // 对齐方式
    this.textDirection, // 文本方向
    this.locale, //
    this.softWrap, // 是否允许换行显示
    this.overflow, // 超出屏幕显示方式
    this.textScaleFactor, // 代表文本相对于当前字体大小的缩放因子，相对于去设置文本的样式style属性的fontSize，它是调整字体大小的一个快捷方式。该属性的默认值可以通过MediaQueryData.textScaleFactor获得，如果没有MediaQuery，那么会默认值将为1.0。
    this.maxLines, // 最大行数
    this.semanticsLabel, // 文本的另一个语义标签
   */

  /*
    TextStyle
    this.color, // 字体颜色
    this.fontSize, // 字体大小
    this.letterSpacing, // 字间距
    this.wordSpacing, // 字符间距
    this.height, // 行高
    this.foreground, // 前景色
    this.background, // 背景色
    this.shadows, // 阴影
    this.decoration, // 装饰
    this.decorationColor,// 装饰颜色
    this.decorationStyle, // 装饰样式
    String fontFamily, // 字体
   */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Text和Button 学习'),
        centerTitle: true,
      ),
      body: Builder(
        builder: (BuildContext context) {
          return ListView(
            children: <Widget>[
              Text(
                "Hello world",
                textAlign: TextAlign.left,
              ),
              Text(
                "Hello world! I'm Jack. " * 4,
                softWrap: false,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                "Hello world",
                textScaleFactor: 1.5,
              ),
              Text.rich(
                TextSpan(
                  text: "这段文字是红色",
                  style: TextStyle(color: Colors.red),
                  children: <TextSpan>[
                    TextSpan(
                        text: "这段文字是蓝色",
                        style: TextStyle(color: Colors.blue),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            _showSnackBar(context, "蓝色文字被点击了");
                          }),
                    TextSpan(
                      text: "这段文字是绿色",
                      style: TextStyle(color: Colors.green),
                    )
                  ],
                ),
                style: TextStyle(fontSize: 16.0), // 设置整体大小
              ),
              RaisedButton(
                child: Text('RaisedButton'),
                onPressed: () {
                  _showSnackBar(context, 'RaisedButtonOnPressed');
                },
                onLongPress: () {
                  _showSnackBar(context, 'onLongPress');
                },
              ),
              FlatButton(
                child: Text('FlatButton'),
                onPressed: () {},
              ),
              OutlineButton(
                child: Text('OutlineButton'),
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(Icons.thumb_up),
                onPressed: () {},
              ),
              RaisedButton.icon(
                icon: Icon(Icons.send),
                label: Text("发送"),
                onPressed: () {},
              ),
              Center(
                child: RaisedButton(
                  onPressed: () {},
                  child: Text('finish'),
                  color: Colors.blue,
                  textColor: Colors.white,
                  highlightColor: Colors.blue[700],
                  //BeveledRectangleBorder 顶端斜角
                  //BoxBorder
                  //CircleBorder 圆形
                  //InputBorder
                  //RoundedRectangleBorder 圆角矩形。
                  //StadiumBorder 体育场形状。即两边是半圆。
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  final TapGestureRecognizer recognizer = new TapGestureRecognizer();

  _showSnackBar(BuildContext context, String content) {
    final snackBar = SnackBar(content: Text(content));
    Scaffold.of(context).showSnackBar(snackBar);
  }
}
