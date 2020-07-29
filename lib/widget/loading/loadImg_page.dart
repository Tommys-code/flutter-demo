import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'loadIm_by_loc_page.dart';
import 'loadImg_by_net_page.dart';

class LoadImgAppPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LoadImgAppPageState();
}

const List<String> tabs = ['网络加载', '本地加载'];

class _LoadImgAppPageState extends State<LoadImgAppPage>
    with SingleTickerProviderStateMixin{
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(
      vsync: this,
      length: tabs.length,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: TabBar(
          controller: _tabController,
          isScrollable: true,
          tabs: (tabs.map((e) => Tab(text: e)).toList()),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          LoadImgByNetPage(),
          LoadImgByLocPage(),
        ],
      ),
    );
  }

}

class LoadImgPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: LoadImgAppPage());
  }
}
