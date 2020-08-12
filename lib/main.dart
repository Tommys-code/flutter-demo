import 'package:flutter/material.dart';
import 'package:flutter_demo/widget/advanced_page.dart';
import 'package:flutter_demo/widget/animation/animation_page.dart';
import 'package:flutter_demo/widget/animation/animation_widget_page.dart';
import 'package:flutter_demo/widget/base_widget/base_widget_page.dart';
import 'package:flutter_demo/widget/base_widget/clip_page.dart';
import 'package:flutter_demo/widget/base_widget/color_theme_page.dart';
import 'package:flutter_demo/widget/base_widget/container_page.dart';
import 'package:flutter_demo/widget/base_widget/customscrollview_page.dart';
import 'package:flutter_demo/widget/base_widget/dialog_page.dart';
import 'package:flutter_demo/widget/base_widget/futurebuilder_streambuilder_page.dart';
import 'package:flutter_demo/widget/base_widget/image.dart';
import 'package:flutter_demo/widget/base_widget/infinite_listview_page.dart';
import 'package:flutter_demo/widget/base_widget/row_column_page.dart';
import 'package:flutter_demo/widget/base_widget/scaffold_page.dart';
import 'package:flutter_demo/widget/base_widget/switch_checkbox_radio.dart';
import 'package:flutter_demo/widget/base_widget/text_and_button.dart';
import 'package:flutter_demo/widget/base_widget/textfield_form_page.dart';
import 'package:flutter_demo/widget/common/hide_and_show_page.dart';
import 'package:flutter_demo/widget/custom_widget/custom_page.dart';
import 'package:flutter_demo/widget/database/data_page.dart';
import 'package:flutter_demo/widget/gesture/dismissed_page.dart';
import 'package:flutter_demo/widget/gesture/drag_page.dart';
import 'package:flutter_demo/widget/gesture/gesture_page.dart';
import 'package:flutter_demo/widget/home_page.dart';
import 'package:flutter_demo/widget/inherited/inherited_w_page.dart';
import 'package:flutter_demo/widget/key/globalkey_form_page.dart';
import 'package:flutter_demo/widget/lifecycle/lifecycle_page.dart';
import 'package:flutter_demo/widget/loading/loadImg_page.dart';
import 'package:flutter_demo/widget/localizations/localizations_demo.dart';
import 'package:flutter_demo/widget/native/channel_page.dart';
import 'package:flutter_demo/widget/network/network_page.dart';
import 'package:flutter_demo/widget/notification/notification_page.dart';
import 'package:flutter_demo/widget/route/route_page.dart';
import 'package:flutter_demo/widget/route/route_page_with_value_one.dart';
import 'package:flutter_demo/widget/route/route_page_with_value_two.dart';
import 'package:flutter_demo/widget/stream/stream_page.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  runApp(new MaterialApp(
    //打开网格调试
//    debugShowMaterialGrid: true,
    //打开性能检测
//    showPerformanceOverlay: true,
    localizationsDelegates: [
      // 准备在这里添加我们自己创建的代理
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
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
      '/AdvancedPage': (_) => AdvancedPage(),
      '/InheritedWidgetTestPage': (_) => InheritedWidgetTestContainer(),
      '/GlobalKeyFromPage': (_) => GlobalKeyFromPage(),
      '/NotificationPage': (_) => NotificationPage(),
      '/HideAndShowPage': (_) => HideAndShowPage(),
      '/StreamPage': (_) => StreamPage(),
      '/DragPage': (_) => DragPage(),
      '/AnimationPage': (_) => AnimationPage(),
      '/AnimationWidgetPage': (_) => AnimationWidgetPage(),
      '/ChannelPage': (_) => ChannelPage(),
      '/CustomPage': (_) => CustomPage(),

      //基础控件
      '/TextAndButtonWidget': (_) => TextAndButtonWidget(),
      '/TextFieldAndFormPage': (_) => TextFieldAndFormPage(),
      '/ImageWidget': (_) => ImageWidget(),
      '/SwitchAndCheckBoxAndRadioWidget': (_) => SwitchAndCheckBoxPage(),
      '/RowAndColumnPage': (_) => RowAndColumnPage(),
      '/ContainerPage': (_) => ContainerPage(),
      '/ScaffoldPage': (_) => ScaffoldPage(),
      '/ClipPage': (_) => ClipPage(),
      '/InfiniteListViewPage': (_) => InfiniteListViewPage(),
      '/CustomScrollViewPage': (_) => CustomScrollViewPage(),
      '/ColorAndThemePage': (_) => ColorAndThemePage(),
      '/AsyncPage': (_) => AsyncPage(),
      '/DialogPage': (_) => DialogPage(),
    },
    initialRoute: '/HomePage',
  ));
}
