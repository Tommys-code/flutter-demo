import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/constant.dart';
import 'package:transparent_image/transparent_image.dart';

const int loadNormalImg = 0;
const int loadGifImg = 1;
const int loadImgWithCache = 2;
const int loadImgWithFade = 3;

class LoadImgByNetAppPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LoadImgByNetAppPageState();
}

class _LoadImgByNetAppPageState extends State<LoadImgByNetAppPage>
    with AutomaticKeepAliveClientMixin {
  int curLoadWay = loadNormalImg;
  String curImageUrl = Constant.normalImgUrl;

  _loadNormalImg() {
    curLoadWay = loadNormalImg;
    curImageUrl = Constant.normalImgUrl;
    setState(() {});
  }

  _loadGifImg() {
    curLoadWay = loadGifImg;
    curImageUrl = Constant.gifImgUrl;
    setState(() {});
  }

  _loadImgWithCache() {
    curLoadWay = loadImgWithCache;
    curImageUrl = Constant.normalImgUrl;
    setState(() {});
  }

  _loadImgWithFade() {
    curLoadWay = loadImgWithFade;
    curImageUrl = Constant.normalImgUrl;
    setState(() {});
  }

  @override
  void initState() {
    print('_LoadImgByNetAppPageState initState');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: ListView(
        key: new PageStorageKey(_LoadImgByNetAppPageState),
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 10.0, top: 10.0, right: 10.0),
            child:
                RaisedButton(child: Text('加载普通图片'), onPressed: _loadNormalImg),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10.0, top: 10.0, right: 10.0),
            child: RaisedButton(child: Text('加载gif图片'), onPressed: _loadGifImg),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10.0, top: 10.0, right: 10.0),
            child: RaisedButton(
                child: Text('加载缓存图片'), onPressed: _loadImgWithCache),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: RaisedButton(
                child: Text('淡入动画加载图片'), onPressed: _loadImgWithFade),
          ),
          ImageView(curImageUrl, curLoadWay)
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class ImageView extends StatelessWidget {
  final String imgUrl;
  final int loadWay;

  ImageView(this.imgUrl, this.loadWay);

  @override
  Widget build(BuildContext context) {
    Widget widget = new Icon(Icons.error);
    switch (loadWay) {
      case loadNormalImg:
      case loadGifImg:
        widget = new Image.network(imgUrl);
        break;
      case loadImgWithCache:
        widget = CachedNetworkImage(
          imageUrl: imgUrl,
          placeholder: (context, url) => Center(
            child: CircularProgressIndicator(),
          ),
          errorWidget: (context, url, error) => Icon(Icons.error),
        );
        break;
      case loadImgWithFade:
        widget = new FadeInImage.memoryNetwork(
            placeholder: kTransparentImage, image: imgUrl);
        break;
    }
    return widget;
  }
}

class LoadImgByNetPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: LoadImgByNetAppPage());
  }
}
