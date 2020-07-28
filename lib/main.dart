import 'package:flutter/material.dart';
import 'package:flutter_demo/widget/database/data_page.dart';
import 'package:flutter_demo/widget/gesture/dismissed_page.dart';
import 'package:flutter_demo/widget/gesture/gesture_page.dart';
import 'package:flutter_demo/widget/home_page.dart';
import 'package:flutter_demo/widget/lifecycle/lifecycle_page.dart';
import 'package:flutter_demo/widget/localizations/localizations_demo.dart';
import 'package:flutter_demo/widget/route/route_page.dart';
import 'package:flutter_demo/widget/route/route_page_with_value_one.dart';
import 'package:flutter_demo/widget/route/route_page_with_value_two.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  runApp(new MaterialApp(
    localizationsDelegates: [
      // 准备在这里添加我们自己创建的代理
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      DemoLocalizations.delegate,
    ],
    supportedLocales: [
      const Locale('zh', 'CH'), //中文
      const Locale('en', 'US'), //English
      // 可以继续添加我们想要支持的语言类型
    ],
    routes: <String, WidgetBuilder>{
      '/HomePage': (_) => new HomePage(),
      '/LifecyclePage': (_) => LifecyclePage(),
      '/RoutePage': (_) => RoutePage(),
      '/RoutePageWithValue1': (_) => RoutePageWithValue1(),
      '/RoutePageWithValue2': (_) => RoutePageWithValue2(),
      '/DataPage': (_) => DataPage(),
      '/GesturePage': (_) => GesturePage(),
      '/DismissedPage': (_) => DismissedPage(),
    },
    home: new HomePage(),
    initialRoute: '/HomePage',
  ));
}
