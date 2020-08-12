import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/model/page_model.dart';

class AdvancedPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AdvancedPageState();
}

class _AdvancedPageState extends State<AdvancedPage> {
  List<PageModel> list = [
    PageModel('InheritedWidget使用(数据共享)', '/InheritedWidgetTestPage'),
    PageModel('GlobalKey使用', '/GlobalKeyFromPage'),
    PageModel('Notification从下往上数据传递', '/NotificationPage'),
    PageModel('widget显示与隐藏', '/HideAndShowPage'),
    PageModel('StreamController', '/StreamPage'),
    PageModel('drag', '/DragPage'),
    PageModel('Animation', '/AnimationPage'),
    PageModel('AnimationWidget', '/AnimationWidgetPage'),
    PageModel('Channel (目前只在Android设备上学习)', '/ChannelPage'),
    PageModel('自定义控件', '/CustomPage'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('进阶 学习'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          var item = list[index];
          return Padding(
            padding: const EdgeInsets.only(left: 10.0, top: 10.0, right: 10.0),
            child: RaisedButton(
                textColor: Colors.black,
                child: new Text(item.title),
                onPressed: () {
                  Navigator.pushNamed(context, item.page);
                }),
          );
        },
        itemCount: list.length,
      ),
    );
  }
}
