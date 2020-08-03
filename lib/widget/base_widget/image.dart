import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ImageWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var img = AssetImage("images/avatar.png");
    return Scaffold(
      appBar: AppBar(
        title: Text('Image'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            ListTile(
              leading: Image(
                image: img,
                height: 40.0,
                width: 80.0,
                fit: BoxFit.fill,
              ),
              title: Text('BoxFit.fill'),
              subtitle: Text('会拉伸填充满显示空间，图片本身长宽比会发生变化，图片会变形。'),
            ),
            ListTile(
              leading: Image(
                image: img,
                height: 40.0,
                width: 80.0,
                fit: BoxFit.contain,
              ),
              title: Text('BoxFit.contain'),
              subtitle: Text('这是图片的默认适应规则，图片会在保证图片本身长宽比不变的情况下缩放以适应当前显示空间，图片不会变形'),
            ),
            ListTile(
              leading: Image(
                image: img,
                height: 40.0,
                width: 80.0,
                fit: BoxFit.cover,
              ),
              title: Text('BoxFit.cover'),
              subtitle: Text('会按图片的长宽比放大后居中填满显示空间，图片不会变形，超出显示空间部分会被剪裁。'),
            ),
            ListTile(
              leading: Image(
                image: img,
                height: 40.0,
                width: 80.0,
                fit: BoxFit.fitWidth,
              ),
              title: Text('BoxFit.fitWidth'),
              subtitle: Text('图片的宽度会缩放到显示空间的宽度，高度会按比例缩放，然后居中显示，图片不会变形，超出显示空间部分会被剪裁。'),
            ),
            ListTile(
              leading: Image(
                image: img,
                height: 40.0,
                width: 80.0,
                fit: BoxFit.fitHeight,
              ),
              title: Text('BoxFit.fitHeight'),
              subtitle: Text('图片的高度会缩放到显示空间的高度，宽度会按比例缩放，然后居中显示，图片不会变形，超出显示空间部分会被剪裁。'),
            ),
            ListTile(
              leading: Image(
                image: img,
                height: 40.0,
                width: 80.0,
                fit: BoxFit.none,
              ),
              title: Text('BoxFit.none'),
              subtitle: Text('图片没有适应策略，会在显示空间内显示图片，如果图片比显示空间大，则显示空间只会显示图片中间部分。'),
            ),
            ListTile(
              leading: Image(
                image: img,
                height: 40.0,
                width: 80.0,
                fit: BoxFit.scaleDown,
              ),
              title: Text('BoxFit.scaleDown'),
              subtitle: Text(''),
            ),
            Image(
              image: img,
              width: 100.0,
              color: Colors.blue,
              colorBlendMode: BlendMode.difference,
              fit: BoxFit.contain,
            ),
            Image(
              image: img,
              width: 150.0,
              height: 100.0,
              repeat: ImageRepeat.repeatX ,
            )
          ],
        ),
      ),
    );
  }
}
