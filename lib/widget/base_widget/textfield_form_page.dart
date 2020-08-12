import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TextFieldAndFormPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TextFieldAndFormPageState();
}

class _TextFieldAndFormPageState extends State<TextFieldAndFormPage> {
  ///controller:编辑框的控制器，通过它可以设置/获取编辑框的内容、选择编辑内容、监听编辑文本改变事件
  ///focusNode:用于控制TextField是否占有当前键盘的输入焦点
  ///InputDecoration：用于控制TextField的外观显示，如提示文本、背景颜色、边框等
  ///keyboardType：用于设置该输入框默认的键盘输入类型
  ///textInputAction：键盘动作按钮图标(即回车键位图标)
  ///style：正在编辑的文本样式。
  ///textAlign: 输入框内编辑文本在水平方向的对齐方式。
  ///autofocus: 是否自动获取焦点。
  ///obscureText：是否隐藏正在编辑的文本，如用于输入密码的场景等，文本内容会用“•”替换。
  ///maxLines：输入框的最大行数，默认为1；如果为null，则无行数限制。
  ///maxLength：输入框文本的最大长度，设置后输入框右下角会显示输入的文本计数
  ///maxLengthEnforced :决定当输入文本长度超过maxLength时是否阻止输入
  ///onChange：输入框内容改变时的回调函数
  ///onEditingComplete和onSubmitted：这两个回调都是在输入框输入完成时触发
  ///inputFormatters：用于指定输入格式；
  ///cursorWidth、cursorRadius和cursorColor：这三个属性是用于自定义输入框光标宽度、圆角和颜色的。

  TextEditingController _unameController = new TextEditingController();
  TextEditingController _pwdController = new TextEditingController();
  GlobalKey _formKey = new GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('TextField和Form'), centerTitle: true),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: TextField(
              keyboardType: TextInputType.phone,
              autofocus: true,
              maxLength: 11,
              decoration: InputDecoration(
                  labelText: "用户名",
                  hintText: "用户名或邮箱",
                  prefixIcon: Icon(Icons.person)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: TextField(
              obscureText: true,
              decoration: InputDecoration(
                  labelText: "密码",
                  hintText: "您的登录密码",
                  prefixIcon: Icon(Icons.lock)),
            ),
          ),
          UnconstrainedBox(
              child: RaisedButton(
            child: Text('移动焦点'),
            onPressed: () {
              FocusScope.of(context).nextFocus();
            },
          )),
          UnconstrainedBox(
              child: RaisedButton(
            child: Text('隐藏键盘'),
            onPressed: () {
              // 当所有编辑框都失去焦点时键盘就会收起
              FocusScope.of(context).requestFocus(FocusNode());
            },
          )),
          Align(
            alignment: Alignment.topLeft,
            child: Text('Form'),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
            child: Form(
              key: _formKey, //设置globalKey，用于后面获取FormState
              autovalidate: true,
              child: Column(
                children: <Widget>[
                  TextFormField(
                      controller: _unameController,
                      decoration: InputDecoration(
                          labelText: "用户名",
                          hintText: "用户名或邮箱",
                          icon: Icon(Icons.person)),
                      onSaved: (v){
                        print('用户名$v');
                      },
                      // 校验用户名
                      validator: (v) {
                        return v.trim().length > 0 ? null : "用户名不能为空";
                      }),
                  TextFormField(
                      controller: _pwdController,
                      decoration: InputDecoration(
                          labelText: "密码",
                          hintText: "您的登录密码",
                          icon: Icon(Icons.lock)),
                      obscureText: true,
                      onSaved: (v){
                        print('密码$v');
                      },
                      //校验密码
                      validator: (v) {
                        return v.trim().length > 5 ? null : "密码不能少于6位";
                      }),
                  Padding(
                    padding: const EdgeInsets.only(top: 28.0),
                    child: SizedBox(
                      width: double.infinity,
                      child: RaisedButton(
                        padding: EdgeInsets.all(15.0),
                        child: Text("登录"),
                        textColor: Colors.white,
                        color: Theme.of(context).primaryColor,
                        onPressed: () {
                          if((_formKey.currentState as FormState).validate()){
                            //验证通过提交数据
                            (_formKey.currentState as FormState).save();
                          }
                        },
                      ),
                    ),
                  ),
                  RaisedButton(
                    child: Text('清空'),
                    onPressed: () {
                      (_formKey.currentState as FormState).reset();
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
