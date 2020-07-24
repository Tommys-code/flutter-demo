import 'package:flutter/material.dart';

class DrawerWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.only(),
      children: <Widget>[
        UserAccountsDrawerHeader(
          accountName: Text('UserName'),
          accountEmail: Text('test@example.com'),
          currentAccountPicture: CircleAvatar(
            backgroundImage: NetworkImage(
                'https://dss0.bdstatic.com/70cFvHSh_Q1YnxGkpoWK1HF6hhy/it/u=3088300133,2558185601&fm=26&gp=0.jpg'),
          ),
        ),
        ListTile(
          title: Text('lifecycle 学习'),
          trailing: Icon(Icons.arrow_right),
          onTap: () {
            Navigator.of(context).pop();
            Navigator.of(context).pushNamed('/LifecyclePage');
          },
        ),
        Divider(),
        ListTile(
          title: Text('Route 学习'),
          trailing: Icon(Icons.arrow_right),
          onTap: () {
            Navigator.of(context).pop();
            Navigator.of(context).pushNamed('/RoutePage');
          },
        ),
        Divider(),
        ListTile(
          title: Text('数据存储 学习'),
          trailing: Icon(Icons.arrow_right),
          onTap: () {
            Navigator.of(context).popAndPushNamed('/DataPage');
          },
        ),
      ],
    );
  }
}

class DrawerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => DrawerWidget();
}
