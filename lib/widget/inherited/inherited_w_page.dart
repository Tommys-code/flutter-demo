import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/model/inherited_test_model.dart';
import 'package:flutter_demo/widget/inherited/inherited_w_test.dart';

class InheritedWidgetTestContainer extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _InheritedWidgetTestContainerState();
}

class _InheritedWidgetTestContainerState
    extends State<InheritedWidgetTestContainer> {
  InheritedTestModel inheritedTestModel;

  _initData() {
    inheritedTestModel = new InheritedTestModel(0);
  }


  @override
  void initState() {
    _initData();
    super.initState();
  }

  _incrementCount() {
    setState(() {
      inheritedTestModel = new InheritedTestModel(inheritedTestModel.count + 1);
    });
  }

  _decrementCount() {
    setState(() {
      inheritedTestModel = new InheritedTestModel(inheritedTestModel.count - 1);
    });
  }

  @override
  Widget build(BuildContext context) {
    return InheritedContext(
      inheritedTestModel: inheritedTestModel,
      increment: _incrementCount,
      decrement: _decrementCount,
      child: Scaffold(
        appBar: AppBar(
          title: Text('InheritedWidget'),
          centerTitle: true,
        ),
        body: Column(
          children: <Widget>[
            Padding(
              padding:
                  const EdgeInsets.only(left: 10.0, top: 10.0, right: 10.0),
              child:  Text(
                '我们常使用的\nTheme.of(context).textTheme\nMediaQuery.of(context).size等\n就是通过InheritedWidget实现的',
              ),
            ),
            TestWidgetA(),
            TestWidgetB(),
            TestWidgetC(),
          ],
        ),
      ),
    );
  }
}

class InheritedContext extends InheritedWidget {
  //数据
  final InheritedTestModel inheritedTestModel;

  //点击+号的方法
  final Function() increment;

  //点击-号的方法
  final Function() decrement;

  InheritedContext({
    Key key,
    @required this.inheritedTestModel,
    @required this.increment,
    @required this.decrement,
    @required Widget child,
  }) : super(key: key, child: child);

  static InheritedContext of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<InheritedContext>();
  }

  @override
  bool updateShouldNotify(InheritedContext oldWidget) {
    return inheritedTestModel != oldWidget.inheritedTestModel;
  }
}
