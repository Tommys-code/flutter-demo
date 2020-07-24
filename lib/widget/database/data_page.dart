import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DataAppPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _DataAppPageState();
}

class _DataAppPageState extends State<DataAppPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('数据存储 学习'),
        centerTitle: true,
      ),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 10.0, top: 10.0, right: 10.0),
            child: Text('对用户名和密码进行增删改查的操作'),
          )
        ],
      ),
    );
  }
}

class DataPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DataAppPage(),
    );
  }
}
