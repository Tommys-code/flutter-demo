import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SwitchAndCheckBoxAppPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SwitchAndCheckBoxPage();
}

class _SwitchAndCheckBoxPage extends State<SwitchAndCheckBoxAppPage> {
  bool _switchSelected = true; //维护单选开关状态
  bool _checkboxSelected = true; //维护复选框状态

  int sex = 1;

  List<bool> _checkboxState = [false, false, false];
  List<String> _checkboxName = ['语文', '数学', '英语'];

  List<String> _radioName = ['红', '绿', '蓝'];
  String _newValue = '红';

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Switch(
                value: _switchSelected, //当前状态
                onChanged: (value) {
                  //重新构建页面
                  setState(() {
                    _switchSelected = value;
                  });
                },
              ),
              Text(_switchSelected ? '开' : '关')
            ],
          ),
          Row(
            children: <Widget>[
              Checkbox(
                value: _checkboxSelected,
                activeColor: Colors.blue, //选中时的颜色
                onChanged: (value) {
                  setState(() {
                    _checkboxSelected = value;
                  });
                },
              ),
              Text(_checkboxSelected ? '选中' : '未选中')
            ],
          ),
          Row(
            children: <Widget>[
              Text("男"),
              Radio(
                value: 1,
                groupValue: this.sex,
                onChanged: (value) {
                  setState(() {
                    this.sex = value;
                  });
                },
              ),
              SizedBox(width: 20),
              Text("女"),
              Radio(
                value: 2,
                groupValue: this.sex,
                onChanged: (value) {
                  setState(() {
                    this.sex = value;
                  });
                },
              )
            ],
          ),
          Text('CheckboxListTile'),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: _checkboxName.map((e) {
              return CheckboxListTile(
                secondary: Icon(Icons.build),
                title: Text(e),
                value: _checkboxState[_checkboxName.indexOf(e)],
                onChanged: (value){
                  setState(() {
                    _checkboxState[_checkboxName.indexOf(e)] = value;
                  });
                },
              );
            }).toList(),
          ),
          Text('RadioListTile'),
          Column(
            children: _radioName.map((e){
              return RadioListTile(
                secondary: Icon(Icons.error),
                title: Text(e),
                subtitle: Text('11'),
                value: e,
                groupValue: _newValue,
                onChanged: (value){
                  setState(() {
                    _newValue = value;
                  });
                },
              );
            }).toList(),
          )
        ],
      ),
    );
  }
}

class SwitchAndCheckBoxPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Switch-CheckBox-Radio'),
        centerTitle: true,
      ),
      body: SwitchAndCheckBoxAppPage(),
    );
  }
}
