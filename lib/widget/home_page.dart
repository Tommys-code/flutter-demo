import 'package:flutter/material.dart';
import 'package:flutter_demo/widget/drawer_page.dart';
import 'package:flutter_demo/widget/localizations/localizations_demo.dart';
import 'package:flutter_demo/widget/tab_android_page.dart';
import 'package:flutter_demo/widget/tab_first_page.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin{
  final _key = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  var _curIndex = 1;
  var _body;

  _initPage() {
    _body = new IndexedStack(
      children: <Widget>[
        new TabFirstPage(),
        new TabCategoryPage("Android"),
        new TabCategoryPage("iOS"),
      ],
      index: _curIndex,
    );
  }

  Future<bool> _onWillPop() {
    return showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            content: new Text('退出App'),
            actions: <Widget>[
              new FlatButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: new Text('确定'),
              ),
            ],
          ),
        ) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    _initPage();
    //双击返回与界面退出提示
    return new WillPopScope(
      child: new Scaffold(
        key: _key,
        appBar: new AppBar(
          title: new Text(DemoLocalizations.of(context).appTitle),
          centerTitle: true,
        ),
        bottomNavigationBar: new BottomNavigationBar(
          items: [
            new BottomNavigationBarItem(
                icon: new Icon(Icons.home), title: new Text("first")),
            new BottomNavigationBarItem(
                icon: new Icon(Icons.phone_android),
                title: new Text("android")),
            new BottomNavigationBarItem(
                icon: new Icon(Icons.phone_iphone), title: new Text("ios"))
          ],
          currentIndex: _curIndex,
          type: BottomNavigationBarType.fixed,
          onTap: (index) {
            setState(() {
              _curIndex = index;
            });
          },
        ),
        drawer: Drawer(
          child: DrawerPage(),
        ),
        body: _body,
      ),
      onWillPop: _onWillPop,
    );
  }
}
