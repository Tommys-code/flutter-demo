import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/common/custom_dialog.dart';

class DialogPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('对话框'), centerTitle: true),
        body: Builder(
          builder: (BuildContext context) {
            return Column(
              children: <Widget>[
                RaisedButton(
                    child: Text('AlertDialog'),
                    onPressed: () async {
                      bool result = await _showAlertDialog(context);
                      if (result == null)
                        _showSnackBar(context, '取消删除');
                      else if (result) _showSnackBar(context, '确认删除');
                    }),
                RaisedButton(
                  child: Text('SimpleDialog'),
                  onPressed: () async {
                    String result = await _showSimpleDialog(context);
                    if (result != null) _showSnackBar(context, result);
                  },
                ),
                RaisedButton(
                  child: Text('Dialog'),
                  onPressed: () {
                    _showListDialog(context);
                  },
                ),
                RaisedButton(
                  child: Text('自定义Dialog'),
                  onPressed: () {
                    _showCustomMaterialDialog(context);
                  },
                ),
                RaisedButton(
                  child: Text('自定义动画遮罩Dialog'),
                  onPressed: () {
                    _showCustomDialog(context);
                  },
                ),
                RaisedButton(
                  child: Text('Dialog复选框'),
                  onPressed: () {
                    _showDeleteConfirmDialog2(context);
                  },
                ),
                RaisedButton(
                  child: Text('Dialog复选框1'),
                  onPressed: () {
                    _showDeleteConfirmDialog3(context);
                  },
                ),
                RaisedButton(
                  child: Text('Dialog复选框2'),
                  onPressed: () {
                    _showDeleteConfirmDialog4(context);
                  },
                ),
                RaisedButton(
                  child: Text('底部菜单列表'),
                  onPressed: () {
                    _showModalBottomSheet(context);
                  },
                ),
                RaisedButton(
                  child: Text('日历'),
                  onPressed: () {
                    _showDatePicker1(context);
                  },
                ),
                RaisedButton(
                  child: Text('IOS日历'),
                  onPressed: () {
                    _showDatePicker2(context);
                  },
                ),
              ],
            );
          },
        ));
  }

  void _showSnackBar(BuildContext context, String str) {
    final snackBar = SnackBar(content: new Text(str));
    Scaffold.of(context).showSnackBar(snackBar);
  }

  Future<bool> _showAlertDialog(BuildContext context) {
    return showDialog<bool>(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('标题'),
            content: Text("您确定要删除当前文件吗?"),
            actions: <Widget>[
              FlatButton(
                child: Text("取消"),
                onPressed: () => Navigator.of(context).pop(), //关闭对话框
              ),
              FlatButton(
                child: Text("删除"),
                onPressed: () {
                  // ... 执行删除操作
                  Navigator.of(context).pop(true); //关闭对话框
                },
              ),
            ],
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          );
        });
  }

  Future<String> _showSimpleDialog(BuildContext context) {
    return showDialog<String>(
        context: context,
        builder: (context) {
          return SimpleDialog(
            title: Text('请选择语言'),
            children: <Widget>[
              SimpleDialogOption(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  child: Text('中文简体'),
                ),
                onPressed: () {
                  Navigator.pop(context, '中文简体');
                },
              ),
              SimpleDialogOption(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  child: Text('English'),
                ),
                onPressed: () {
                  Navigator.pop(context, 'English');
                },
              )
            ],
          );
        });
  }

  void _showListDialog(BuildContext context) async {
    int index = await showDialog<int>(
        context: context,
        builder: (context) {
          return Dialog(
            child: Column(
              children: <Widget>[
                ListTile(title: Text('请选择')),
                Expanded(
                  child: ListView.builder(
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                          title: Text("$index"),
                          onTap: () => Navigator.of(context).pop(index),
                        );
                      },
                      itemCount: 30),
                )
              ],
            ),
          );
        });
    if (index != null) _showSnackBar(context, '$index');
  }

  void _showCustomMaterialDialog(BuildContext context) async {
    var result = await showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return UnconstrainedBox(
            child: Material(
              type: MaterialType.card,
              child: ConstrainedBox(
                constraints: BoxConstraints(minWidth: 280, maxWidth: 280),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: Text("标题",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text('我是内容' * 10, textAlign: TextAlign.center),
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: FlatButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text('取消'),
                          ),
                        ),
                        Expanded(
                          child: FlatButton(
                            onPressed: () {
                              Navigator.of(context).pop("确定");
                            },
                            child: Text('确定'),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        });
    if (result != null) _showSnackBar(context, result);
  }

  void _showCustomDialog(BuildContext context) async {
    bool result = await showCustomDialog<bool>(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("提示"),
            content: Text("您确定要删除当前文件吗?"),
            actions: <Widget>[
              FlatButton(
                child: Text("取消"),
                onPressed: () => Navigator.of(context).pop(),
              ),
              FlatButton(
                child: Text("删除"),
                onPressed: () {
                  // 执行删除操作
                  Navigator.of(context).pop(true);
                },
              ),
            ],
          );
        });
    if (result != null) _showSnackBar(context, '删除成功');
  }

  //对话框上所有可能会改变状态的组件需要单独封装在一个在内部管理状态的StatefulWidget中，这样不仅麻烦，而且复用性不大
  void _showDeleteConfirmDialog2(BuildContext context) async {
    bool _withTree = false; //记录复选框是否选中
    var result = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("提示"),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text("您确定要删除当前文件吗?"),
              Row(
                children: <Widget>[
                  Text("同时删除子目录？"),
                  DialogCheckbox(
                    value: _withTree, //默认不选中
                    onChanged: (bool value) {
                      //更新选中状态
                      _withTree = !_withTree;
                    },
                  ),
                ],
              ),
            ],
          ),
          actions: <Widget>[
            FlatButton(
              child: Text("取消"),
              onPressed: () => Navigator.of(context).pop(),
            ),
            FlatButton(
              child: Text("删除"),
              onPressed: () {
                // 将选中状态返回
                Navigator.of(context).pop(_withTree);
              },
            ),
          ],
        );
      },
    );
    if (result != null) _showSnackBar(context, '同时删除子目录: $result');
  }

  void _showDeleteConfirmDialog3(BuildContext context) async {
    bool _withTree = false; //记录复选框是否选中
    var result = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("提示"),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text("您确定要删除当前文件吗?"),
              Row(
                children: <Widget>[
                  Text("同时删除子目录？"),
                  StatefulBuilder(builder: (context, _setState) {
                    return Checkbox(
                      value: _withTree,
                      onChanged: (bool value) {
                        _setState(() {
                          _withTree = value;
                        });
                      },
                    );
                  }),
                ],
              ),
            ],
          ),
          actions: <Widget>[
            FlatButton(
              child: Text("取消"),
              onPressed: () => Navigator.of(context).pop(),
            ),
            FlatButton(
              child: Text("删除"),
              onPressed: () {
                // 将选中状态返回
                Navigator.of(context).pop(_withTree);
              },
            ),
          ],
        );
      },
    );
    if (result != null) _showSnackBar(context, '同时删除子目录: $result');
  }

  //会导致整个对话框UI组件全部rebuild,因此最好的做法是将context的“范围”缩小，也就是说只将Checkbox的Element标记为dirty
  // 通过Builder来获得构建Checkbox的`context`，这是一种常用的缩小`context`范围的方式
  void _showDeleteConfirmDialog4(BuildContext context) async {
    bool _withTree = false; //记录复选框是否选中
    var result = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("提示"),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text("您确定要删除当前文件吗?"),
              Row(
                children: <Widget>[
                  Text("同时删除子目录？"),
                  Checkbox(
                    value: _withTree,
                    onChanged: (value) {
                      // 此时context为对话框UI的根Element，我们
                      // 直接将对话框UI对应的Element标记为dirty
                      (context as Element).markNeedsBuild();
                      _withTree = !_withTree;
                    },
                  )
                ],
              ),
            ],
          ),
          actions: <Widget>[
            FlatButton(
              child: Text("取消"),
              onPressed: () => Navigator.of(context).pop(),
            ),
            FlatButton(
              child: Text("删除"),
              onPressed: () {
                // 将选中状态返回
                Navigator.of(context).pop(_withTree);
              },
            ),
          ],
        );
      },
    );
    if (result != null) _showSnackBar(context, '同时删除子目录: $result');
  }

  // 弹出底部菜单列表模态对话框
  void _showModalBottomSheet(BuildContext context) async {
    var result = await showModalBottomSheet<int>(
      context: context,
      builder: (BuildContext context) {
        return ListView.builder(
          itemCount: 30,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              title: Text("$index"),
              onTap: () => Navigator.of(context).pop(index),
            );
          },
        );
      },
    );
    if (result != null) _showSnackBar(context, '$result');
  }

  void _showDatePicker1(BuildContext context) async {
    var date = DateTime.now();
    var result = await showDatePicker(
      context: context,
      initialDate: date,
      firstDate: date,
      lastDate: date.add(
        //未来30天可选
        Duration(days: 30),
      ),
    );
    if (result != null) _showSnackBar(context, '$result');
  }

  void _showDatePicker2(BuildContext context) {
    var date = DateTime.now();
    showCupertinoModalPopup<DateTime>(
      context: context,
      builder: (ctx) {
        return SizedBox(
          height: 200,
          child: CupertinoDatePicker(
            backgroundColor: CupertinoColors.systemBackground.resolveFrom(context),
            mode: CupertinoDatePickerMode.dateAndTime,
            use24hFormat: true,
            minimumDate: date,
            maximumDate: date.add(
              Duration(days: 30),
            ),
            onDateTimeChanged: (date){
              print('$date');
            },
          ),
        );
      },
    );
  }
}

// 单独封装一个内部管理选中状态的复选框组件
class DialogCheckbox extends StatefulWidget {
  DialogCheckbox({
    Key key,
    this.value,
    @required this.onChanged,
  });

  final ValueChanged<bool> onChanged;
  final bool value;

  @override
  _DialogCheckboxState createState() => _DialogCheckboxState();
}

class _DialogCheckboxState extends State<DialogCheckbox> {
  bool value;

  @override
  void initState() {
    value = widget.value;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Checkbox(
      value: value,
      onChanged: (v) {
        //将选中状态通过事件的形式抛出
        widget.onChanged(v);
        setState(() {
          //更新自身选中状态
          value = v;
        });
      },
    );
  }
}
