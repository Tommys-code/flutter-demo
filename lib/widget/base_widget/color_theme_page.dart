import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ColorAndThemePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ColorAndThemePageState();
}

class _ColorAndThemePageState extends State<ColorAndThemePage> {
  Color _themeColor = Colors.blue;

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return Theme(
      data: ThemeData(
          primarySwatch: _themeColor, //用于导航栏、FloatingActionButton的背景色等
          iconTheme: IconThemeData(color: _themeColor) //用于Icon颜色
          ),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            '颜色和主题',
            style: TextStyle(
                color: _themeColor.computeLuminance() < 0.5
                    ? Colors.white
                    : Colors.black),
          ),
          centerTitle: true,
        ),
        body: Column(
          children: <Widget>[
            NavBar(title: '动态确定文字的颜色', color: Colors.blue),
            NavBar(title: '动态确定文字的颜色', color: Colors.white),
            SizedBox(height: 20),
            Text('第一行Icon使用主题中的iconTheme'),
            //第一行Icon使用主题中的iconTheme
            Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
              Icon(Icons.favorite),
              Icon(Icons.airport_shuttle),
              Text("  颜色跟随主题")
            ]),
            SizedBox(height: 20),
            Text('第二行Icon自定义颜色（固定为黑色)'),
            //为第二行Icon自定义颜色（固定为黑色)
            Theme(
              data: themeData.copyWith(
                iconTheme: themeData.iconTheme.copyWith(color: Colors.black),
              ),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.favorite),
                    Icon(Icons.airport_shuttle),
                    Text("  颜色固定黑色")
                  ]),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
              _themeColor =
                  _themeColor == Colors.blue ? Colors.teal : Colors.blue;
            });
          },
          child: Icon(Icons.cached),
        ),
      ),
    );
  }
}

class NavBar extends StatelessWidget {
  final String title;
  final Color color; //背景颜色

  NavBar({
    Key key,
    this.color,
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        minHeight: 52,
        minWidth: double.infinity,
      ),
      decoration: BoxDecoration(
        color: color,
        boxShadow: [
          //阴影
          BoxShadow(
            color: Colors.black26,
            offset: Offset(0, 3),
            blurRadius: 3,
          ),
        ],
      ),
      child: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          //根据背景色亮度来确定Title颜色
          color: color.computeLuminance() < 0.5 ? Colors.white : Colors.black,
        ),
      ),
      alignment: Alignment.center,
    );
  }
}
