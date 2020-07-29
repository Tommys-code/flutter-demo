import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class CommonWebView extends StatefulWidget {
  final String title;
  final String url;

  const CommonWebView(this.title, this.url);

  @override
  State<StatefulWidget> createState() => _CommonWebViewState();
}

class _CommonWebViewState extends State<CommonWebView> {
  // 插件提供的对象，该对象用于WebView的各种操作
  FlutterWebviewPlugin flutterWebViewPlugin = new FlutterWebviewPlugin();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: WebviewScaffold(
        url: widget.url,
        appBar: AppBar(
          title: Text(widget.title),
        ),
        withZoom: true,
        // 允许网页缩放
        withLocalStorage: true,
        // 允许LocalStorage
        withJavascript: true, // 允许执行js代码
      ),
      onWillPop: _goBack,
    );
  }

  Future<bool> _goBack() async {
//    if (flutterWebViewPlugin.canGoBack() != null) {
//      flutterWebViewPlugin.goBack();
//      return false;
//    }
    return !(await flutterWebViewPlugin.canGoBack());
  }
}
