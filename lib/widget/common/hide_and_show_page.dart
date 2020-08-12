import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HideAndShowPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HideAndShowPageState();
}

class _HideAndShowPageState extends State<HideAndShowPage> {
  bool switchA = true;
  bool switchB = true;
  bool switchC = true;
  bool switchD = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('widget显示与隐藏'), centerTitle: true),
      body: ListView(
        children: <Widget>[
          Wrap(
            alignment: WrapAlignment.center,
            children: <Widget>[
              Expanded(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text('A${switchA?'显示':'隐藏'}'),
                    Switch(
                      value: switchA,
                      onChanged: (v) {
                        setState(() {
                          switchA = v;
                        });
                      },
                    )
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text('B${switchB?'显示':'隐藏'}'),
                    Switch(
                      value: switchB,
                      onChanged: (v) {
                        setState(() {
                          switchB = v;
                        });
                      },
                    )
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text('C${switchC?'显示':'隐藏'}'),
                    Switch(
                      value: switchC,
                      onChanged: (v) {
                        setState(() {
                          switchC = v;
                        });
                      },
                    )
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text('D${switchD?'显示':'隐藏'}'),
                    Switch(
                      value: switchD,
                      onChanged: (v) {
                        setState(() {
                          switchD = v;
                        });
                      },
                    )
                  ],
                ),
              ),
            ],
          ),
          TestAWidget(visible: switchA),
          TestBWidget(visible: switchB),
          TestCWidget(visible: switchC),
          Divider(color: Colors.green,height: 5),
          Visibility(
            visible: switchD,
            child: Container(
              color: Colors.red,
              height: 100.0,
              child: Center(
                child: Text('Visibility'),
              ),
            ),
          ),
          Divider(color: Colors.blue,height: 5),
        ],
      ),
    );
  }
}

class TestBWidget extends StatelessWidget {
  final bool visible;

  const TestBWidget({Key key, this.visible}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: Duration(milliseconds: 300),
      opacity: visible ? 1.0 : 0.0,
      child: Container(
        color: Colors.blue,
        height: 100.0,
        child: Center(
          child: Text('TestBWidget'),
        ),
      ),
    );
  }
}

class TestCWidget extends StatelessWidget {
  final bool visible;

  const TestCWidget({Key key, this.visible}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Offstage(
      offstage: !visible,
      child: Container(
        color: Colors.orange,
        height: 100.0,
        child: Center(
          child: Text('TestCWidget'),
        ),
      ),
    );
  }
}

class TestAWidget extends StatelessWidget {
  final bool visible;

  const TestAWidget({Key key, this.visible}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return visible
        ? Container(
            color: Colors.orange,
            height: 100.0,
            child: Center(
              child: Text('TestAWidget'),
            ),
          )
        : Container();
  }
}
