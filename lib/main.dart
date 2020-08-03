import 'package:flutter/material.dart';
import 'package:flutter_demo/widget/base_widget/base_widget_page.dart';
import 'package:flutter_demo/widget/base_widget/clip_page.dart';
import 'package:flutter_demo/widget/base_widget/container_page.dart';
import 'package:flutter_demo/widget/base_widget/customscrollview_page.dart';
import 'package:flutter_demo/widget/base_widget/image.dart';
import 'package:flutter_demo/widget/base_widget/infinite_listview_page.dart';
import 'package:flutter_demo/widget/base_widget/row_column_page.dart';
import 'package:flutter_demo/widget/base_widget/scaffold_page.dart';
import 'package:flutter_demo/widget/base_widget/switch_checkbox_radio.dart';
import 'package:flutter_demo/widget/base_widget/text_and_button.dart';
import 'package:flutter_demo/widget/database/data_page.dart';
import 'package:flutter_demo/widget/gesture/dismissed_page.dart';
import 'package:flutter_demo/widget/gesture/gesture_page.dart';
import 'package:flutter_demo/widget/home_page.dart';
import 'package:flutter_demo/widget/lifecycle/lifecycle_page.dart';
import 'package:flutter_demo/widget/loading/loadImg_page.dart';
import 'package:flutter_demo/widget/localizations/localizations_demo.dart';
import 'package:flutter_demo/widget/network/network_page.dart';
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
      '/LoadImgPage': (_) => LoadImgPage(),
      '/NetworkPage': (_) => NetWorkPage(),
      '/BaseWidgetPage': (_) => BaseWidgetPage(),
      //基础控件
      '/TextAndButtonWidget': (_) => TextAndButtonWidget(),
      '/ImageWidget': (_) => ImageWidget(),
      '/SwitchAndCheckBoxAndRadioWidget': (_) => SwitchAndCheckBoxPage(),
      '/RowAndColumnPage': (_) => RowAndColumnPage(),
      '/ContainerPage': (_) => ContainerPage(),
      '/ScaffoldPage': (_) => ScaffoldPage(),
      '/ClipPage': (_) => ClipPage(),
      '/InfiniteListViewPage': (_) => InfiniteListViewPage(),
      '/CustomScrollViewPage': (_) => CustomScrollViewPage(),
    },
    initialRoute: '/HomePage',
  ));
}
