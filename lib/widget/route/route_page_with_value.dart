import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class RoutePageWithValue extends StatelessWidget {
  final String lastPageName;

  RoutePageWithValue(this.lastPageName);

  BuildContext context;

  @override
  Widget build(BuildContext context) {
    this.context = context;
    return WillPopScope(
      child: Scaffold(
        appBar: AppBar(
          title: Text('RoutePageWithValue'),
        ),
        body: Center(
          child: Text('$lastPageName'),
        ),
      ),
      onWillPop: _onWillPop,
    );
  }

  Future<bool> _onWillPop() {
    showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        content: Text('退出当前界面'),
        actions: <Widget>[
          FlatButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.of(context).pop();
            },
            child: Text('确定'),
          ),
        ],
      ),
    );
    return Future.value(false);
  }
}
