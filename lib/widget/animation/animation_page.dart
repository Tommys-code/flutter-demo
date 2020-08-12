import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AnimationPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AnimationPageState();
}

class _AnimationPageState extends State<AnimationPage> {
  int _aniIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('animation'), centerTitle: true),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: <Widget>[
              RaisedButton(
                child: Text('透明'),
                onPressed: () {
                  setState(() {
                    _aniIndex = 0;
                  });
                },
              ),
              RaisedButton(
                child: Text('平移'),
                onPressed: () {
                  setState(() {
                    _aniIndex = 1;
                  });
                },
              ),
              RaisedButton(
                child: Text('缩放'),
                onPressed: () {
                  setState(() {
                    _aniIndex = 2;
                  });
                },
              ),
              RaisedButton(
                child: Text('旋转'),
                onPressed: () {
                  setState(() {
                    _aniIndex = 3;
                  });
                },
              ),
              RaisedButton(
                child: Text('Radius'),
                onPressed: () {
                  setState(() {
                    _aniIndex = 4;
                  });
                },
              ),
              RaisedButton(
                child: Text('Color'),
                onPressed: () {
                  setState(() {
                    _aniIndex = 5;
                  });
                },
              ),
              RaisedButton(
                child: Text('组合'),
                onPressed: () {
                  setState(() {
                    _aniIndex = 6;
                  });
                },
              ),
            ],
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              alignment: Alignment.topLeft,
              child: _buildAnimation(),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildAnimation() {
    Widget widget;
    switch (_aniIndex) {
      case 0:
        widget = OpacityAniWidget();
        break;
      case 1:
        widget = MovementAniWidget();
        break;
      case 2:
        widget = ScaleAniWidget();
        break;
      case 3:
        widget = RotationAniWidget();
        break;
      case 4:
        widget = RadiusAniWidget();
        break;
      case 5:
        widget = ColorAniWidget();
        break;
      case 6:
        widget = StaggeredAniWidget();
        break;
    }
    return widget;
  }
}

class OpacityAniWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _OpacityAniWidgetState();
}

class _OpacityAniWidgetState extends State<OpacityAniWidget>
    with TickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _animation;

  ///Curves.linear匀速的 decelerate匀减速 ease开始加速，后面减速
  ///easeIn开始慢，后面快  easeOut开始快，后面慢
  ///easeInOut	开始慢，然后加速，最后再减速
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    );
    _animation = Tween(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
        parent: _controller,
        curve: Interval(
          0.0,
          0.5,
          curve: Curves.easeIn,
        )));

    _animation.addStatusListener((status) {
      print(status);
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _controller.forward();
    return FadeTransition(
      child: Container(
        color: Colors.red,
        height: 180.0,
        width: 180.0,
        child: Center(
          child: Text(
            'opacity',
            style: TextStyle(color: Colors.white, fontSize: 16.0),
          ),
        ),
      ),
      opacity: _animation,
    );
  }
}

class MovementAniWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MovementAniWidgetState();
}

class _MovementAniWidgetState extends State<MovementAniWidget>
    with TickerProviderStateMixin {
  AnimationController _controller;
  Animation _animation;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(duration: Duration(seconds: 3), vsync: this);
//    _animation = Tween(begin: Offset.zero, end: Offset(1, 1)).animate(
//        CurvedAnimation(parent: _controller, curve: Curves.elasticOut));

    _animation = Tween<AlignmentGeometry>(
            begin: Alignment.topLeft, end: Alignment.bottomRight)
        .animate(
            CurvedAnimation(parent: _controller, curve: Curves.elasticOut));

    _animation.addStatusListener((status) {
      print(status);
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _controller.forward();
    return _buildAlignTransition();
  }

  SlideTransition _buildSlideTransition() {
    return SlideTransition(
      position: _animation,
      child: Container(
        color: Colors.blue,
        height: 180.0,
        width: 180.0,
        child: new Center(
          child: new Text(
            'movement',
            style: new TextStyle(color: Colors.white, fontSize: 16.0),
          ),
        ),
      ),
    );
  }

  AlignTransition _buildAlignTransition() {
    _controller.forward();
    return AlignTransition(
      alignment: _animation,
      child: Container(
        color: Colors.blue,
        height: 180.0,
        width: 180.0,
        child: new Center(
          child: new Text(
            'movement',
            style: new TextStyle(color: Colors.white, fontSize: 16.0),
          ),
        ),
      ),
    );
  }
}

class ScaleAniWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ScaleAniWidgetState();
}

class _ScaleAniWidgetState extends State<ScaleAniWidget>
    with TickerProviderStateMixin {
  AnimationController _controller;
  Animation _animation;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(duration: Duration(seconds: 2), vsync: this);
    _animation = Tween(begin: 0.5, end: 1.5)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.bounceOut));

    _animation.addStatusListener((status) {
      print(status);
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _controller.repeat();
    return Center(
      child: ScaleTransition(
        scale: _animation,
        child: Container(
          color: Colors.green,
          height: 180.0,
          width: 180.0,
          child: new Center(
            child: new Text(
              'scale',
              style: new TextStyle(color: Colors.white, fontSize: 16.0),
            ),
          ),
        ),
      ),
    );
  }
}

class RotationAniWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _RotationAniWidgetState();
}

class _RotationAniWidgetState extends State<RotationAniWidget>
    with TickerProviderStateMixin {
  AnimationController _controller;
  Animation _animation;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(duration: Duration(seconds: 3), vsync: this);
    _animation = Tween(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(parent: _controller, curve: Curves.elasticOut));
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _controller.forward();
    return Center(
      child: RotationTransition(
        turns: _animation,
        child: Container(
          width: 180,
          height: 180,
          color: Colors.red,
          child: Text(
            'Rotate',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}

class RadiusAniWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _RadiusAniWidgetState();
}

class _RadiusAniWidgetState extends State<RadiusAniWidget>
    with TickerProviderStateMixin {
  AnimationController _controller;
  Animation<BorderRadius> _animation;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(duration: Duration(seconds: 1), vsync: this);
    _animation = Tween(
      begin: BorderRadius.circular(0.0),
      end: BorderRadius.circular(100.0),
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _controller.forward();
    return Center(
        child: AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Container(
          child: Text(
            'Radius',
            textAlign: TextAlign.center,
          ),
          height: 180,
          width: 180,
          decoration: BoxDecoration(
            color: Colors.purple,
            border: Border.all(
              color: Colors.purple,
              width: 2.0,
            ),
            borderRadius: _animation.value,
          ),
        );
      },
    ));
  }
}

class ColorAniWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ColorAniWidgetState();
}

class _ColorAniWidgetState extends State<ColorAniWidget>
    with TickerProviderStateMixin {
  AnimationController _controller;
  Animation<Color> _animation;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(duration: Duration(seconds: 2), vsync: this);
    _animation = ColorTween(
      begin: Colors.red[100],
      end: Colors.blue[900],
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Interval(
        0.0,
        1.0,
        curve: Curves.linear,
      ),
    ));
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _controller.forward();
    return Center(
        child: AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Container(
          child: Text(
            'color',
            textAlign: TextAlign.center,
          ),
          height: 180,
          width: 180,
          color: _animation.value,
        );
      },
    ));
  }
}

class StaggeredAniWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _StaggeredAniWidgetState();
}

class _StaggeredAniWidgetState extends State<StaggeredAniWidget>
    with TickerProviderStateMixin {
  AnimationController _controller;

  Animation<double> opacity;
  Animation<AlignmentGeometry> movement;
  Animation<Color> color;
  Animation<BorderRadius> radius;
  Animation<double> rotate;
  Animation<double> width;
  Animation<double> height;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 2000),
      vsync: this,
    );
    opacity = Tween(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
        parent: _controller, curve: Interval(0.0, 0.2, curve: Curves.ease)));
    movement = Tween<AlignmentGeometry>(
            begin: Alignment.topLeft, end: Alignment.bottomRight)
        .animate(CurvedAnimation(
            parent: _controller, curve: Interval(0.0, 1.0, curve: Curves.ease)));
    color = ColorTween(
      begin: Colors.indigo[100],
      end: Colors.orange[400],
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(0.2, 0.5, curve: Curves.ease),
      ),
    );
    radius = BorderRadiusTween(
      begin: BorderRadius.circular(0.0),
      end: BorderRadius.circular(100.0),
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(
          0.2,
          0.75,
          curve: Curves.ease,
        ),
      ),
    );
    height = Tween<double>(
      begin: 100.0,
      end: 200.0,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(
          0.375,
          0.6,
          curve: Curves.fastOutSlowIn,
        ),
      ),
    );
    width = Tween<double>(
      begin: 100.0,
      end: 200.0,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(
          0.375,
          0.6,
          curve: Curves.fastOutSlowIn,
        ),
      ),
    );
    _controller.forward();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: _buildAnimation,
    );
  }

  Widget _buildAnimation(BuildContext context,Widget child){
    return Container(
      alignment: movement.value,
      child: Opacity(//透明组件
        opacity: opacity.value,
        child: Container(
          width: width.value,
          height: height.value,
          decoration: BoxDecoration(
            color: color.value,
            border: Border.all(
                color: Colors.indigo[300],
                width: 3.0
            ),
            borderRadius: radius.value,
          ),
        ),
      ),
    );
  }
}
