import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GlobalKeyFromPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _GlobalKeyFromPageState();
}

class _GlobalKeyFromPageState extends State<GlobalKeyFromPage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(title: Text('GlobalKey'), centerTitle: true),
      body: ListView(
        children: <Widget>[FormOnePage(scaffoldKey)],
      ),
    );
  }
}

class FormOnePage extends StatefulWidget {
  final GlobalKey<ScaffoldState> _key;

  FormOnePage(this._key);

  @override
  State<StatefulWidget> createState() => _FormOnePageState();
}

class _FormOnePageState extends State<FormOnePage> {
  final formKey = GlobalKey<FormState>();
  String _phoneNum;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Form(
        key: formKey,
        child: Column(
          children: <Widget>[
            TextFormField(
              autocorrect: false,
              decoration: new InputDecoration(
                hintText: '请输入手机号',
              ),
              maxLines: 1,
              maxLength: 11,
              //键盘展示为号码
              keyboardType: TextInputType.phone,
              validator: (str) {
                return str.isEmpty ? "手机号不能为空" : null;
              },
              onSaved: (str) {
                _phoneNum = str;
                print(_phoneNum);
              },
            ),
            RaisedButton(
              child: Text("提交"),
              onPressed: onPressed,
            ),
          ],
        ),
      ),
    );
  }

  void onPressed() {
    var form = formKey.currentState;
    if (form.validate()) {
      form.save();
      var snackBar = SnackBar(content: Text('phone: $_phoneNum'));
      widget._key.currentState.showSnackBar(snackBar);
    }
  }
}
