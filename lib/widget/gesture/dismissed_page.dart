import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DismissedAppPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _DismissedAppPageState();
}

class _DismissedAppPageState extends State<DismissedAppPage> {
  List<String> list = [
    'A',
    'B',
    'C',
    'D',
    'E',
    'F',
    'G',
    'H',
    'I',
    'J',
    'K',
    'L'
  ];

  _showSnakeBar(String str) {
    final snackBar = SnackBar(content: Text(str));
    Scaffold.of(context).showSnackBar(snackBar);
  }

  Widget _buildItem(BuildContext context, int index) {
    var curItem = list[index];
    //滑动删除
    return Dismissible(
      key: Key(curItem),
      child: ListTile(
        title: Text(curItem),
      ),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        list.removeAt(index);
        _showSnakeBar("$curItem 被划走了");
      },
      background: Container(
          child: Center(
            child: Text('即将被删除'),
          ),
          color: Colors.red),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dismissed 学习'),
        centerTitle: true,
      ),
      body: ListView.builder(itemCount: list.length, itemBuilder: _buildItem),
    );
  }
}

class DismissedPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: DismissedAppPage());
  }
}
