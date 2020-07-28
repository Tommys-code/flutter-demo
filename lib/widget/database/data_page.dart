import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_demo/widget/database/sql_manager.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

String username = '';
String pwd = '';

const String USERNAME = 'username';
const String PWD = 'pwd';

class DataAppPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _DataAppPageState();
}

class _DataAppPageState extends State<DataAppPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('数据存储 学习'),
        centerTitle: true,
      ),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 10.0, top: 10.0, right: 10.0),
            child: Text('对用户名和密码进行增删改查的操作'),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10.0),
            child: LoginWidget(),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: HandleSPDataWidget(),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: HandleSQLiteDataWidget(),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: HandleFileDataWidget(),
          )
        ],
      ),
    );
  }
}

class LoginWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TextField(
          onChanged: (str) {
            username = str;
            print(username);
          },
          decoration: new InputDecoration(
            labelText: '用户名',
            hintText: '请输入英文或数字',
          ),
          inputFormatters: [
            //只能输入字母或数字
            WhitelistingTextInputFormatter(RegExp("[a-zA-Z]|[0-9]")),
          ],
          maxLines: 1,
          onSubmitted: (text) {
            FocusScope.of(context).nextFocus();
          },
        ),
        TextField(
          onChanged: (str) {
            pwd = str;
            print(pwd);
          },
          decoration: new InputDecoration(
            labelText: '密码',
            hintText: '请输入长度大于6的密码',
          ),
          maxLines: 1,
          obscureText: true,
          //是否是密码
          keyboardType: TextInputType.text,
        )
      ],
    );
  }
}

class HandleSPDataWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _HandleSPDataWidgetState();
  }
}

class _HandleSPDataWidgetState extends State<HandleSPDataWidget> {
  var _result;

  _add() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setString(USERNAME, username);
    sp.setString(PWD, pwd);

    setState(() {
      _result = '_add 成功 请点击查验证结果';
    });
  }

  _delete() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.remove(USERNAME);
    sp.remove(PWD);
    //清空所有KEY
    //sp.clear();
    setState(() {
      _result = '_delete 成功, 请点击查验证结果';
    });
  }

  _update() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setString(USERNAME, "test");
    sp.setString(PWD, "888888");
    setState(() {
      _result = '_update 成功, 用户名修改为test，密码修改为888888, 请点击查验证结果';
    });
  }

  _query() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    var username = sp.getString(USERNAME);
    var pwd = sp.getString(PWD);
    setState(() {
      _result = '_query 成功: username: $username pwd: $pwd';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
          child: new Text('shared_preferences用法'),
        ),
        Row(
          children: <Widget>[
            RaisedButton(
              textColor: Colors.black,
              child: new Text('增'),
              onPressed: _add,
            ),
            RaisedButton(
              textColor: Colors.black,
              child: new Text('删'),
              onPressed: _delete,
            ),
            RaisedButton(
              textColor: Colors.black,
              child: new Text('改'),
              onPressed: _update,
            ),
            RaisedButton(
              textColor: Colors.black,
              child: new Text('查'),
              onPressed: _query,
            )
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
          child: new Text('结果：$_result'),
        ),
      ],
    );
  }
}

class HandleSQLiteDataWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _HandleSQLiteDataWidgetState();
  }
}

class _HandleSQLiteDataWidgetState extends State<HandleSQLiteDataWidget> {
  var _result;

  static const tabName = "user";
  var createSql =
      "CREATE TABLE $tabName (id INTEGER PRIMARY KEY, username TEXT, pwd TEXT)";

  _create() async {
    if (await SqlManager.isTableExits(tabName)) {
      setState(() {
        _result = "user表已存在";
      });
      return;
    }
    var db = await SqlManager.getCurrentDatabase();
    await db.execute(createSql);
    await SqlManager.close();
    setState(() {
      _result = "user表创建成功";
    });
  }

  _add() async {
    var db = await SqlManager.getCurrentDatabase();

    /// 插入数据
    ///1.insert(表名,{"键":值},conflictAlgorithm(冲突算法:枚举类型)) 返回行数
    await db.insert('user', {"username": username, "pwd": pwd}).then(
        (value) => print(value));
    await SqlManager.close();
    setState(() {
      _result = "插入username=$username,pwd=$pwd数据成功";
    });
  }

  _delete() async {
    var db = await SqlManager.getCurrentDatabase();

    /// 删除数据
    /// 1.delete("表名",where(条件),whereArgs(条件参数))
    int count = await db.delete('user', where: "id=?", whereArgs: [1]);
    await SqlManager.close();
    setState(() {
      if (count == 1) {
        _result = "删除成功，请查看";
      } else {
        _result = "删除失败，请看log";
      }
    });
  }

  _update() async {
    var db = await SqlManager.getCurrentDatabase();

    /// 更新数据
    /// 1.update("表名",要修改的内容{'键':值},where(条件),whereArgs(条件参数),conflictAlgorithm(冲突算法：枚举类型))
    var count = await db.update('user', {'pwd': "ssssss"},
        where: 'id=?', whereArgs: [1]);
    await SqlManager.close();
    print(count);
    setState(() {
      _result = "更新数据成功，请查看";
    });
  }

  _queryNum() async {
    var db = await SqlManager.getCurrentDatabase();
    var count =
        Sqflite.firstIntValue(await db.rawQuery('SELECT COUNT(*) FROM user'));
    await SqlManager.close();
    setState(() {
      _result = "数据条数：$count";
    });
  }

  _query() async {
    var db = await SqlManager.getCurrentDatabase();

    /// 查询数据
    /// 1.query(表名,{distinct,columns(返回哪些字段),where(条件),
    /// whereArgs(条件参数),groupBy(分组),having(分组后的进行条件查询),
    ///  orderBy(排序),limit(一次读几条),offset(起始位置)}) 返回读取到的结果(列表)
    /// 若没有查询条件 则返回这个表的数据
    List<Map> list = await db.query(
      'user', //查询的表名
      distinct: true, // 不重复
    );
    await SqlManager.close();
    setState(() {
      _result = "数据详情：$list";
    });
  }

  _batch() async {
    /// 批处理SQL语句 往Batch中添加语句 但是这些语句并不会执行 需要调用commit方法 然后一次性执行
    var db = await SqlManager.getCurrentDatabase();
    Batch batch = db.batch();
    batch.insert("user", {"username": 'ls', "pwd": "ls"});
    batch.insert("user", {"username": 'ww', "pwd": "ww"});
    // noResult 是否不需要结果  continueOnError遇到异常是否继续执行
    batch
        .commit(noResult: true, continueOnError: true)
        .then((value) => print(value));
    setState(() {
      _result = "批量插入数据成功";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
          child: new Text('sqflite用法'),
        ),
        Row(
          children: <Widget>[
            RaisedButton(
                textColor: Colors.black,
                child: new Text('创建'),
                onPressed: _create),
            RaisedButton(
              textColor: Colors.black,
              child: new Text('增'),
              onPressed: _add,
            ),
            RaisedButton(
              textColor: Colors.black,
              child: new Text('删'),
              onPressed: _delete,
            ),
            RaisedButton(
              textColor: Colors.black,
              child: new Text('改'),
              onPressed: _update,
            )
          ],
        ),
        Row(
          children: <Widget>[
            RaisedButton(
              textColor: Colors.black,
              child: new Text('查条数'),
              onPressed: _queryNum,
            ),
            RaisedButton(
              textColor: Colors.black,
              child: new Text('查详情'),
              onPressed: _query,
            ),
            RaisedButton(
              textColor: Colors.black,
              child: new Text('批处理'),
              onPressed: _batch,
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
          child: new Text('结果：$_result'),
        )
      ],
    );
  }
}

class HandleFileDataWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HandleFileDataWidgetState();
}

class _HandleFileDataWidgetState extends State<HandleFileDataWidget> {
  var _result;
  var tempPath;
  var appDocPath;
  var sdCardPath;

  _add() async {
    File file = new File('$tempPath/user.txt');
    await file.writeAsString('用户名:$username密码:$pwd', mode: FileMode.append);
    setState(() {
      _result = '写入成功，请查询';
    });
  }

  _delete() async {
    File file = new File('$tempPath/user.txt');
    file.deleteSync(recursive: false);
    setState(() {
      _result = '删除成功，请查看';
    });
  }

  _update() async {
    File file = new File('$tempPath/user.txt');
    await file.writeAsString('用户名:Paul密码:654321');
    setState(() {
      _result = '修改成功，请查询';
    });
  }

  _query() async {
    try {
      File file = new File('$tempPath/user.txt');
      _result = file.readAsStringSync();
    } catch (e) {
      _result = 'exception: $e';
    }
    setState(() {});
  }

  void _requestTempDirectory() async {
    Directory tempDir = await getTemporaryDirectory();
    setState(() {
      tempPath = tempDir.path;
    });
  }

  void _requestAppDocumentsDirectory() async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    setState(() {
      appDocPath = appDocDir.path;
    });
  }

  void _requestExternalStorageDirectory() async {
    Directory sdCardDir = await getExternalStorageDirectory();
    setState(() {
      sdCardPath = sdCardDir.path;
    });
  }

  @override
  void initState() {
    super.initState();
    _requestTempDirectory();
    _requestAppDocumentsDirectory();
    _requestExternalStorageDirectory();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
          child: new Text('文件用法'),
        ),
        Row(
          children: <Widget>[
            RaisedButton(
              textColor: Colors.black,
              child: new Text('增'),
              onPressed: _add,
            ),
            RaisedButton(
                textColor: Colors.black,
                child: new Text('删'),
                onPressed: _delete),
            RaisedButton(
                textColor: Colors.black,
                child: new Text('改'),
                onPressed: _update),
            RaisedButton(
                textColor: Colors.black,
                child: new Text('查'),
                onPressed: _query),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
          child: new Text('结果：$_result'),
        ),
        Text('缓存文件路径:'),
        Padding(
          padding: const EdgeInsets.only(bottom: 10.0),
          child: new Text('$tempPath'),
        ),
        Text('应用文件路径:'),
        Padding(
          padding: const EdgeInsets.only(bottom: 10.0),
          child: new Text('$appDocPath'),
        ),
        Text('Android SD卡路径:'),
        Padding(
          padding: const EdgeInsets.only(bottom: 10.0),
          child: new Text('$sdCardPath'),
        ),
      ],
    );
  }
}

class DataPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DataAppPage(),
    );
  }
}
