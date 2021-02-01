import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/widget/easyrefresh/base_list_page.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

/// 空视图示例
class EmptyPage extends StatefulWidget {
  @override
  EmptyPageState createState() {
    EasyRefresh.defaultHeader = ClassicalHeader(
      enableInfiniteRefresh: false,
      enableHapticFeedback: false,
      refreshText: '拉动刷新',
      refreshReadyText: '释放刷新',
      refreshingText: '正在刷新...',
      refreshedText: '刷新完成',
      refreshFailedText: '刷新失败',
      noMoreText: '没有更多数据',
      infoText: '更新于 %T',
    );
    EasyRefresh.defaultFooter = ClassicalFooter(
      enableInfiniteLoad: true,
      enableHapticFeedback: false,
      loadText: '拉动加载',
      loadReadyText: '释放加载',
      loadingText: '正在加载...',
      loadedText: '加载完成',
      loadFailedText: '加载失败',
      noMoreText: '没有更多数据',
      infoText: '更新于 %T',
    );
    return EmptyPageState();
  }
}

class EmptyPageState extends BaseListPageState<EmptyPage> {



}