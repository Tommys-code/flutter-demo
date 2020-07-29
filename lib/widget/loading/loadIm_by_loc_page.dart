import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoadImgByLocAppPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LoadImgByLocAppPageState();
}

class _LoadImgByLocAppPageState extends State<LoadImgByLocAppPage>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    print('_LoadImgByLocAppPageState');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: Column(
        key: new PageStorageKey(_LoadImgByLocAppPageState),
        children: <Widget>[
          Image.asset('images/ic_assignment_ind_36pt.png'),
          Divider(),
          Image(
            image: new AssetImage('images/ic_assignment_ind_36pt.png'),
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class LoadImgByLocPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: LoadImgByLocAppPage());
  }
}
