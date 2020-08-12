import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/widget/custom_widget/custom_widget.dart';

class CustomPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CustomPageState();
}

class _CustomPageState extends State<CustomPage> {
  double _turns = .0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('自定义控件'), centerTitle: true),
      body: SizedBox.expand(
        child: Column(
          children: <Widget>[
            GradientButton(
              colors: [Colors.orange, Colors.red],
              height: 50.0,
              child: Text("Submit"),
              onPressed: onTap,
            ),
            GradientButton(
              height: 50.0,
              colors: [Colors.lightGreen, Colors.green[700]],
              child: Text("Submit"),
              onPressed: onTap,
            ),
            GradientButton(
              height: 50.0,
              colors: [Colors.lightBlue[300], Colors.blueAccent],
              child: Text("Submit"),
              onPressed: onTap,
              borderRadius: BorderRadius.circular(30),
            ),
            Padding(
              padding: const EdgeInsets.all(0),
              child: TurnBox(
                turns: _turns,
                speed: 500,
                child: Icon(Icons.refresh, size: 50),
              )
            ),
            Padding(
                padding: const EdgeInsets.all(0),
                child: TurnBox(
                  turns: _turns,
                  speed: 1000,
                  child: Icon(Icons.refresh, size: 150),
                )
            ),
            RaisedButton(
              child: Text("顺时针旋转1/4圈"),
              onPressed: () {
                setState(() {
                  _turns += .25;
                });
              },
            ),
            RaisedButton(
              child: Text("逆时针旋转1/4圈"),
              onPressed: () {
                setState(() {
                  _turns -= .25;
                });
              },
            )
          ],
        ),
      ),
    );
  }

  onTap() {
    print("button click");
  }
}
