import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ContainerPage extends StatelessWidget {
  //EdgeInsets
  //fromLTRB(double left, double top, double right, double bottom)：分别指定四个方向的填充。
  //all(double value) : 所有方向均使用相同数值的填充。
  //only({left, top, right ,bottom })：可以设置具体某个方向的填充(可以同时指定多个方向)。
  //symmetric({ vertical, horizontal })：用于设置对称方向的填充，vertical指top和bottom，horizontal指left和right。

  //BoxConstraints.tight(Size size)，它可以生成给定大小的限制
  //BoxConstraints.expand()可以生成一个尽可能大的用以填充另一个容器的BoxConstraints

  //AspectRatio，它可以指定子组件的长宽比、
  // LimitedBox 用于指定最大宽高、
  // FractionallySizedBox 可以根据父容器宽高的百分比来设置子组件宽高等
  @override
  Widget build(BuildContext context) {
    Widget redBox = DecoratedBox(
      decoration: BoxDecoration(color: Colors.red),
    );
    return Scaffold(
      appBar: AppBar(title: Text('容器类组件'), centerTitle: true),
      body: ListView(children: <Widget>[
        Center(child: Text('Padding')),
        Padding(
          //上下左右各添加16像素补白
          padding: EdgeInsets.all(16.0),
          child: Column(
            //显式指定对齐方式为左对齐，排除对齐干扰
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                //左边添加8像素补白
                padding: const EdgeInsets.only(left: 8.0),
                child: Text("Hello world"),
              ),
              Padding(
                //上下各添加8像素补白
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text("I am Jack"),
              ),
              Padding(
                // 分别指定四个方向的补白
                padding: const EdgeInsets.fromLTRB(20.0, .0, 20.0, 20.0),
                child: Text("Your friend"),
              )
            ],
          ),
        ),
        Divider(),
        Center(child: Text('尺寸限制类容器')),
        ConstrainedBox(
            constraints: BoxConstraints(
                minWidth: double.infinity, //宽度尽可能大
                minHeight: 50.0 //最小高度为50像素
                ),
            child: Container(
              height: 5.0,
              child: redBox,
            )),
        UnconstrainedBox(
          child: SizedBox(width: 80.0, height: 80.0, child: redBox),
        ),
        Center(child: Text('AspectRatio')),
        UnconstrainedBox(
          child: Container(
            height: 30,
            child: AspectRatio(
              aspectRatio: 1.5,
              child: redBox,
            ),
          ),
        ),
        Center(child: Text('FractionallySizedBox')),
        UnconstrainedBox(
          child: Container(
            width: 100,
            height: 100,
            color: Colors.green,
            child: FractionallySizedBox(
              widthFactor: 0.5,
              child: redBox,
            ),
          ),
        ),
        Divider(),
        DecoratedBoxWidget(),
        TransformWidget(),
        ContainerWidget(),
      ]),
    );
  }
}

class DecoratedBoxWidget extends StatelessWidget {
  //decoration：代表将要绘制的装饰，它的类型为Decoration。
  //Decoration是一个抽象类，它定义了一个接口 createBoxPainter()，
  //子类的主要职责是需要通过实现它来创建一个画笔，该画笔用于绘制装饰。

  //position：此属性决定在哪里绘制Decoration，它接收DecorationPosition的枚举类型，该枚举类有两个值：
  //background：在子组件之后绘制，即背景装饰。
  //foreground：在子组件之上绘制，即前景。
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text('DecoratedBox'),
        DecoratedBox(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [Colors.red, Colors.orange[700]]), //背景渐变
                borderRadius: BorderRadius.circular(3.0), //3像素圆角
                boxShadow: [
                  //阴影
                  BoxShadow(
                      color: Colors.black54,
                      offset: Offset(2.0, 2.0),
                      blurRadius: 4.0)
                ]),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
              child: Text(
                "Login",
                style: TextStyle(color: Colors.white),
              ),
            )),
      ],
    );
  }
}

class TransformWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text('Transform'),
        SizedBox(height: 50),
        Container(
          color: Colors.black,
          child: new Transform(
            alignment: Alignment.topRight, //相对于坐标系原点的对齐方式
            transform: new Matrix4.skewY(0.3), //沿Y轴倾斜0.3弧度
            child: new Container(
              padding: const EdgeInsets.all(8.0),
              color: Colors.deepOrange,
              child: const Text('Apartment for rent!'),
            ),
          ),
        ),
        SizedBox(height: 20),
        DecoratedBox(
          decoration: BoxDecoration(color: Colors.red),
          //默认原点为左上角，左移20像素，向上平移5像素
          child: Transform.translate(
            offset: Offset(-20.0, -5.0),
            child: Text("Hello world"),
          ),
        ),
        SizedBox(height: 50),
        DecoratedBox(
          decoration: BoxDecoration(color: Colors.red),
          child: Transform.rotate(
            //旋转90度
            angle: pi / 2,
            child: Text("Hello world"),
          ),
        ),
        SizedBox(height: 50),
        DecoratedBox(
            decoration: BoxDecoration(color: Colors.red),
            child: Transform.scale(
                scale: 1.5, //放大到1.5倍
                child: Text("Hello world"))),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            DecoratedBox(
                decoration: BoxDecoration(color: Colors.red),
                child: Transform.scale(scale: 1.5, child: Text("Hello world"))),
            Text(
              "你好",
              style: TextStyle(color: Colors.green, fontSize: 18.0),
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            DecoratedBox(
              decoration: BoxDecoration(color: Colors.red),
              //将Transform.rotate换成RotatedBox
              child: RotatedBox(
                quarterTurns: 1, //旋转90度(1/4圈)
                child: Text("Hello world"),
              ),
            ),
            Text(
              "你好",
              style: TextStyle(color: Colors.green, fontSize: 18.0),
            )
          ],
        ),
      ],
    );
  }
}

class ContainerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return UnconstrainedBox(
      child: Container(
          margin: EdgeInsets.only(top: 20,bottom: 100),
          constraints: BoxConstraints.tightFor(width: 150.0, height: 120.0),
          //卡片大小
          decoration: BoxDecoration(
            gradient: RadialGradient(
                radius: .98,
                colors: [Colors.red, Colors.orange],
                center: Alignment.topLeft),
            boxShadow: [
              BoxShadow(
                color: Colors.black54,
                offset: Offset(2.0, 2.0),
                blurRadius: 4,
              )
            ],
          ),
          transform: Matrix4.rotationZ(.5), //卡片倾斜变换
          alignment: Alignment.center,
          child: Text('520',
              style: TextStyle(color: Colors.white, fontSize: 30.0))),
    );
  }
}
