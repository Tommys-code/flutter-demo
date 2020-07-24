import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LifecycleAppPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LifecycleAppPageState('构造函数');
}

class _LifecycleAppPageState extends State<LifecycleAppPage>
    with WidgetsBindingObserver {
  String str;

  _LifecycleAppPageState(this.str);

  @override
  void initState() {
    print(str);
    print('initState');
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeDependencies() {
    print('didChangeDependencies');
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(LifecycleAppPage oldWidget) {
    print('didUpdateWidget');
    super.didUpdateWidget(oldWidget);
  }

  @override
  void deactivate() {
    print('deactivate');
    super.deactivate();
  }

  @override
  void dispose() {
    print('dispose');
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print(state.toString());
    super.didChangeAppLifecycleState(state);
  }

  @override
  Widget build(BuildContext context) {
    print('build');
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('lifecycle 学习'),
        centerTitle: true,
      ),
      body: new Column(
        children: <Widget>[
          new Image.asset('images/lifecycle.png'),
          new Text('查看日志打印的状态'),
        ],
      ),
    );
  }
}

class LifecyclePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LifecycleAppPage(),
    );
  }
}
