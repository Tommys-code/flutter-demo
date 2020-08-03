import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RowAndColumnPage extends StatelessWidget {
  /*textDirection：
  表示水平方向子组件的布局顺序(是从左往右还是从右往左)，
  默认为系统当前Locale环境的文本方向(如中文、英语都是从左往右，而阿拉伯语是从右往左)。
  */
  //mainAxisSize：
  //表示Row在主轴(水平)方向占用的空间，默认是MainAxisSize.max，
  //表示尽可能多的占用水平方向的空间，此时无论子widgets实际占用多少水平空间，Row的宽度始终等于水平方向的最大宽度；
  //而MainAxisSize.min表示尽可能少的占用水平空间，当子组件没有占满水平剩余空间，则Row的实际宽度等于所有子组件占用的的水平空间；

  //mainAxisAlignment：
  //表示子组件在Row所占用的水平空间内对齐方式，
  //如果mainAxisSize值为MainAxisSize.min，则此属性无意义，因为子组件的宽度等于Row的宽度。
  //只有当mainAxisSize的值为MainAxisSize.max时，此属性才有意义，
  //MainAxisAlignment.start表示沿textDirection的初始方向对齐，
  //如textDirection取值为TextDirection.ltr时，则MainAxisAlignment.start表示左对齐，
  //textDirection取值为TextDirection.rtl时表示从右对齐。而MainAxisAlignment.end和MainAxisAlignment.start正好相反；
  //MainAxisAlignment.center表示居中对齐。读者可以这么理解：textDirection是mainAxisAlignment的参考系。

  //verticalDirection：表示Row纵轴（垂直）的对齐方向，默认是VerticalDirection.down，表示从上到下。

  //crossAxisAlignment：表示子组件在纵轴方向的对齐方式，Row的高度等于子组件中最高的子元素高度，
  //它的取值和MainAxisAlignment一样(包含start、end、 center三个值)，
  //不同的是crossAxisAlignment的参考系是verticalDirection，
  //即verticalDirection值为VerticalDirection.down时crossAxisAlignment.start指顶部对齐，
  //verticalDirection值为VerticalDirection.up时，crossAxisAlignment.start指底部对齐；
  //而crossAxisAlignment.end和crossAxisAlignment.start正好相反；

  //如果Row里面嵌套Row，或者Column里面再嵌套Column，
  //那么只有最外面的Row或Column会占用尽可能大的空间，里面Row或Column所占用的空间为实际大小，
  //如果要让里面的Column占满外部Column，可以使用Expanded 组件
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('布局类组件'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          //测试Row对齐方式，排除Column默认居中对齐的干扰
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(" hello world "),
                Text(" I am Jack "),
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(" hello world "),
                Text(" I am Jack "),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              textDirection: TextDirection.rtl,
              children: <Widget>[
                Text(" hello world "),
                Text(" I am Jack "),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              verticalDirection: VerticalDirection.up,
              children: <Widget>[
                Text(
                  " hello world ",
                  style: TextStyle(fontSize: 30.0),
                ),
                Text(" I am Jack "),
              ],
            ),
            FlexWidget(),
            WrapWidget(),
            StackAndPositionedWidget(),
            AlignWidget()
          ],
        ),
      ),
    );
  }
}

class FlexWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        children: <Widget>[
          Divider(),
          Text('Flex弹性布局'),
          Flex(
            direction: Axis.horizontal,
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Container(
                  height: 30,
                  color: Colors.red,
                ),
              ),
              Expanded(
                flex: 2,
                child: Container(
                  height: 30,
                  color: Colors.green,
                ),
              )
            ],
          ),
          Padding(
              padding: EdgeInsets.only(top: 10),
              child: SizedBox(
                child: Flex(
                  direction: Axis.vertical,
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        color: Colors.blue,
                      ),
                      flex: 2,
                    ),
                    Spacer(
                      flex: 1,
                    ),
                    Expanded(
                      child: Container(
                        color: Colors.green,
                      ),
                      flex: 1,
                    )
                  ],
                ),
                height: 100,
              )),
          Divider(),
        ],
      ),
    );
  }
}

class WrapWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        children: <Widget>[
          Text('线性布局Row和Column,Widget超出屏幕范围报溢出错误'),
          Row(
            //widget超出屏幕范围，则会报溢出错误
            children: <Widget>[Text("xxx" * 100)],
          ),
          SizedBox(height: 50),
          Text('Wrap流式布局'),
          Wrap(
            children: <Widget>[Text("xxx" * 100)],
          ),
          SizedBox(
            width: double.infinity,
            child: Wrap(
              spacing: 10.0, // 主轴(水平)方向间距
              runSpacing: 4.0, // 纵轴（垂直）方向间距
              alignment: WrapAlignment.center, //沿主轴方向居中
              children: <Widget>[
                Chip(
                  avatar: new CircleAvatar(
                      backgroundColor: Colors.blue, child: Text('A')),
                  label: new Text('Hamilton'),
                ),
                Chip(
                  avatar: new CircleAvatar(
                      backgroundColor: Colors.blue, child: Text('M')),
                  label: new Text('Lafayette'),
                ),
                Chip(
                  avatar: new CircleAvatar(
                      backgroundColor: Colors.blue, child: Text('H')),
                  label: new Text('Mulligan'),
                ),
                Chip(
                  avatar: new CircleAvatar(
                      backgroundColor: Colors.blue, child: Text('J')),
                  label: new Text('Laurens'),
                ),
              ],
            ),
          ),
          Divider(),
        ],
      ),
    );
  }
}

class StackAndPositionedWidget extends StatelessWidget {
  //alignment：此参数决定如何去对齐没有定位（没有使用Positioned）或部分定位的子组件。
  //所谓部分定位，在这里特指没有在某一个轴上定位：left、right为横轴，
  //top、bottom为纵轴，只要包含某个轴上的一个定位属性就算在该轴上有定位。

  //fit：此参数用于确定没有定位的子组件如何去适应Stack的大小。
  //StackFit.loose表示使用子组件的大小，StackFit.expand表示扩伸到Stack的大小。

  //overflow：此属性决定如何显示超出Stack显示空间的子组件；
  //值为Overflow.clip时，超出部分会被剪裁（隐藏），值为Overflow.visible 时则不会。
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        children: <Widget>[
          Text('Stack层叠布局'),
          SizedBox(
            width: double.infinity,
            height: 150,
            child: Stack(
              alignment: Alignment.center, //指定未定位或部分定位widget的对齐方式
              children: <Widget>[
                Container(
                  child: Text("Hello world",
                      style: TextStyle(color: Colors.white)),
                  color: Colors.red,
                ),
                Positioned(
                  left: 18.0,
                  child: Text("I am Jack"),
                ),
                Positioned(
                  top: 18.0,
                  child: Text("Your friend"),
                )
              ],
            ),
          ),
          Divider(),
          SizedBox(
            width: double.infinity,
            height: 150,
            child: Stack(
              alignment: Alignment.center, //指定未定位或部分定位widget的对齐方式
              fit: StackFit.expand, //未定位widget占满Stack整个空间
              children: <Widget>[
                Positioned(
                  left: 18.0,
                  child: Text("I am Jack"),
                ),
                Container(
                  child: Text("Hello world",
                      style: TextStyle(color: Colors.white)),
                  color: Colors.red,
                ),
                Positioned(
                  top: 18.0,
                  child: Text("Your friend"),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class AlignWidget extends StatelessWidget {
  //Alignment可以通过其坐标转换公式将其坐标转为子元素的具体偏移坐标：
  //(Alignment.x*childWidth/2+childWidth/2, Alignment.y*childHeight/2+childHeight/2)

  //FractionalOffset
  //实际偏移 = (FractionalOffse.x * childWidth, FractionalOffse.y * childHeight)
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Divider(),
        Container(
          color: Colors.blue[100],
          height: 120,
          width: 120,
          child: Align(
            alignment: Alignment.topRight,
            child: FlutterLogo(
              size: 60,
            ),
          ),
        ),
        Container(
          color: Colors.blue[50],
          child: Align(
            widthFactor: 2,
            heightFactor: 2,
            alignment: Alignment(2, 0.0),
            child: FlutterLogo(
              size: 60,
            ),
          ),
        ),
        Container(
          color: Colors.blue[50],
          child: Align(
            widthFactor: 2,
            heightFactor: 2,
            alignment: FractionalOffset(0.2, 0.6),//(12,36)
            child: FlutterLogo(
              size: 60,
            ),
          ),
        ),
        DecoratedBox(
          decoration: BoxDecoration(color: Colors.red),
          child: Center(
            child: Text("xxx"),
          ),
        ),
        DecoratedBox(
          decoration: BoxDecoration(color: Colors.red),
          child: Center(
            widthFactor: 1,
            heightFactor: 1,
            child: Text("xxx"),
          ),
        )
      ],
    );
  }
}
