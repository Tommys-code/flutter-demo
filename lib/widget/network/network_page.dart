import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/model/gank_model.dart';

import '../../constant.dart';

class NetWorkAppPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _NetWorkAppPageState();
}

class _NetWorkAppPageState extends State<NetWorkAppPage> {
  var httpClient = new HttpClient();
  String _result;
  String _decodeResult;

  var dio_url = 'https://news-at.zhihu.com/api/4/news/latest';
  var url = Constant.baseUrl + 'random/category/GanHuo/type/Android/count/1';

  _loadData() async {
    try {
      print(url);
      var request = await httpClient.getUrl(Uri.parse(url));
      var response = await request.close();
      if (response.statusCode == HttpStatus.ok) {
        _result = await response.transform(Utf8Decoder()).join();
        _decodeJson(_result, false);
      } else {
        _result = 'error code : ${response.statusCode}';
      }
    } catch (e) {
      _result = '网络异常';
    }

    if (!mounted) return;
    setState(() {});
  }

  //使用第三方库Dio的请求
  var dio = Dio();

  _loadDataByDio() async {
    try {
      Response response = await dio.request(url, options: Options(
        method: 'get',
        contentType: Headers.jsonContentType,
        responseType: ResponseType.plain,
        receiveDataWhenStatusError: false,
      ));
      if (response.statusCode == HttpStatus.ok) {
        _result = response.data.toString();
        _decodeJson(_result, false);
      } else {
        _result = 'error code : ${response.statusCode}';
      }
    } catch (exception) {
      print('exc:$exception');
      _result = '网络异常';
    }

    setState(() {});
  }

  _decodeJson(var body, bool isDio) {
    var json;
    if (isDio) {
      //如果是Dio则不需要jsonDecode
      json = body;
    } else {
      json = jsonDecode(body);
    }
    List flModels = json['data'];
    List<GankModel> list = flModels.map((model) {
      return new GankModel.fromJson(model);
    }).toList();
    for (GankModel model in list) {
      _decodeResult =
          '作者：${model.author}\n描述：${model.desc}\n地址：${model.url}\n时间：${model.publishedAt}';
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('网络请求 学习'),
        centerTitle: true,
      ),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 10, top: 10, right: 10),
            child: RaisedButton(
              textColor: Colors.black,
              child: Text('不使用第三方库加载数据'),
              onPressed: _loadData,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 10, top: 10, right: 10),
            child: RaisedButton(
              textColor: Colors.black,
              child: Text('使用第三方库dio加载数据'),
              onPressed: _loadDataByDio,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 10, top: 10, right: 10),
            child: Text('原始数据：\n$_result'),
          ),
          Padding(
            padding: EdgeInsets.only(left: 10, top: 10, right: 10),
            child: Text('解析后的数据：\n$_decodeResult'),
          )
        ],
      ),
    );
  }
}

class NetWorkPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: NetWorkAppPage());
  }
}
