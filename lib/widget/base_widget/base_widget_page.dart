import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/model/page_model.dart';

class BaseWidgetPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _BaseWidgetPageState();
}

class _BaseWidgetPageState extends State<BaseWidgetPage> {
  List<PageModel> list = [
    PageModel('Text和Button', '/TextAndButtonWidget'),
    PageModel('Image', '/ImageWidget'),
    PageModel('Switch-CheckBox-Radio', '/SwitchAndCheckBoxAndRadioWidget'),
    PageModel('布局组件', '/RowAndColumnPage'),
    PageModel('容器类组件', '/ContainerPage'),
    PageModel('Scaffold', '/ScaffoldPage'),
    PageModel('Clip', '/ClipPage'),
    PageModel('无限加载列表', '/InfiniteListViewPage'),
    PageModel('CustomScrollView', '/CustomScrollViewPage'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('基础Widget 学习'),
        centerTitle: true,
      ),
      body: ListView.separated(
          itemBuilder: _itemBuild,
          separatorBuilder: (BuildContext context, int index) =>
              Divider(color: Colors.blue),
          itemCount: list.length),
    );
  }

  Widget _itemBuild(BuildContext context, int index) {
    var item = list[index];
    return ListTile(
      title: Text(item.title),
      trailing: Icon(Icons.arrow_right),
      onTap: () {
        Navigator.of(context).pushNamed(item.page);
      },
    );
  }
}
