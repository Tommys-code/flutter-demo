import 'package:flutter/material.dart';
import 'package:flutter_demo/model/page_model.dart';

class DrawerWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  List<PageModel> list = [
    PageModel('lifecycle 学习', '/LifecyclePage'),
    PageModel('Route 学习', '/RoutePage'),
    PageModel('数据存储 学习', '/DataPage'),
    PageModel('Gesture 学习', '/GesturePage'),
    PageModel('加载图片 学习', '/LoadImgPage'),
  ];

/*ListView(
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
        Divider(),
        ListTile(
          title: Text('Gesture 学习'),
          trailing: Icon(Icons.arrow_right),
          onTap: () {
            Navigator.popAndPushNamed(context, '/GesturePage');
          },
        ),
        Divider(),
        ListTile(
            title: new Text('加载图片 学习'),
            trailing: new Icon(Icons.arrow_right),
            onTap: () {
              Navigator.popAndPushNamed(context, '/LoadImgPage');
            }),
      ],
    );*/
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverToBoxAdapter(
          child: UserAccountsDrawerHeader(
            accountName: Text('UserName'),
            accountEmail: Text('test@example.com'),
            currentAccountPicture: CircleAvatar(
              backgroundImage: NetworkImage(
                  'https://dss0.bdstatic.com/70cFvHSh_Q1YnxGkpoWK1HF6hhy/it/u=3088300133,2558185601&fm=26&gp=0.jpg'),
            ),
          ),
        ),
        SliverList(
            delegate:
                SliverChildBuilderDelegate((BuildContext context, int index) {
          return Column(
            children: <Widget>[
              ListTile(
                  title: Text(list[index].title),
                  trailing: Icon(Icons.arrow_right),
                  onTap: () {
                    Navigator.of(context).popAndPushNamed(list[index].page);
                  }),
              if (index != list.length - 1) Divider()
            ],
          );
        }, childCount: list.length)),
      ],
    );
  }
}

class DrawerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => DrawerWidget();
}
