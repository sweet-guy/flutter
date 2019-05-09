import 'dart:io';

import 'package:flutter/material.dart';
import 'package:my_flutter/util/ThemeStateModel.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class MinePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MinePageState();
}

class MinePageState extends State<MinePage> {
  List data=[];
  String text_dbname="";
  TextEditingController namecontroller = TextEditingController();
  TextEditingController desccontroller = TextEditingController();
  TextEditingController dbnamecontroller = TextEditingController();
  TextEditingController imageurlcontroller=TextEditingController();
  String depath="";
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: Text("我的"),
        ),
        body: Column(
              children: <Widget>[
                TextField(
                  controller: dbnamecontroller,
                  decoration: InputDecoration(
                    hintText: '请输入创建数据库的名字'
                  ),
                ),
                TextField(
                  controller: namecontroller,
                  decoration: InputDecoration(
                      hintText: '请输入電影名字'
                  ),
                ),
                TextField(
                  controller: desccontroller,
                  decoration: InputDecoration(
                    hintText: '请输入電影描述'
                  ),
                ),
                TextField(
                  controller: imageurlcontroller,
                  decoration: InputDecoration(
                      hintText: '请输入電影背景圖'
                  ),
                ),
                RaisedButton(child: Text('创建数据库'), onPressed: () {
                  String data = dbnamecontroller.text;
                  _create(data);
                },),
                RaisedButton(child: Text('添加数据'), onPressed: () {
//                  _read("Data");
                String name=namecontroller.text;
                String desc=desccontroller.text;
                String url=imageurlcontroller.text;
                  _add(name,desc,url);
                }),
                RaisedButton(child: Text('查询数据'), onPressed: () {
//                  _remove("Data");
//                  _query();
//                  String dbname=_read("dbname") as String;
//                  print("sp保存的數據庫名字為："+dbname);
                  ChangeTheme(4);
                }),
                  Text("数据库"+text_dbname+"内容为："),
                  Expanded(
                    child:ListView.builder(itemCount:data.length,itemBuilder: (context,index){
                      DataBean databean=data[index];
                      return ListTile(
                        title: Text(databean.name),
                        subtitle: Text(databean.desc),
                        leading: Image.network(databean.ImageUrl),
                      );
                    }),
                  )
              ],
            )
    );
  }

  Future _save(String key, String value) async {
    SharedPreferences Preferences = await SharedPreferences.getInstance();
    Preferences.setString(key, value);
    print('存储数据为：$value');
//    Fluttertoast.showToast(msg: '存储数据为：$value');
  }
  changeTheme(int index) async {
    int themeIndex = index;
    ThemeStateModel().changeTheme(themeIndex);
  }
  _read(String key) async {
    SharedPreferences Preferences = await SharedPreferences.getInstance();
    String data = Preferences.get(key);
    print('读取数据为：$data');
//    Fluttertoast.showToast(msg: '读取数据为：$data');
    return data;
  }

  Future _remove(String key) async {
    SharedPreferences Preferences = await SharedPreferences.getInstance();
    Preferences.remove(key);
    Fluttertoast.showToast(msg: '删除成功！');
  }

  Future<String> createDB(String dbName) async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, dbName);

    if (await Directory(dirname(path)).exists()) {
      await deleteDatabase(path);
    }
    else {
      try {
        await Directory(dirname(path)).create(recursive: true);
      } catch (e) {
        print(e);
      }
    }
    return path;
  }
  _create(String dbName)async{
    depath=await createDB(dbName);
    _save("Data", depath);
    String sql='create TABLE '+dbName+'(id integer primary key,name text,desc text,ImageUrl text)';
    print("創建數據庫的sql語句："+sql);
    Database db=await openDatabase(depath);
    await db.execute(sql);
    await db.close();
    setState(() {
        String _result='创建数据库成功！！！';
        print(_result);
        text_dbname=dbName;
        _save("dbname",dbName);
        Fluttertoast.showToast(msg: _result);
    });
  }
  _add(String name,String desc,String imageurl)async{
      Database db=await openDatabase(depath);
      String dbname=dbnamecontroller.text;
      String sql= "INSERT INTO "+dbname+"(name, desc,ImageUrl) VALUES("+'"'+name+'","'+desc+'","'+imageurl+'"'")";
      print("添加的sql語句："+sql);
      await db.transaction((txn) async{
          int id=await txn.rawInsert(sql);
      });
      await db.close();
      setState(() {
        print("添加成功！");
        Fluttertoast.showToast(msg: "添加成功！！");
      });
  }
  _query()async{
    String dbname=dbnamecontroller.text;
    String sql="select * from "+dbname;
    Database db=await openDatabase(depath);
    List<Map> list=await db.rawQuery(sql);
    await db.close();
    data.clear();
    setState(() {
      print(list);
      list.forEach((item){
        data.add(DataBean(item['id'],item['name'],item['ImageUrl'],item['desc']));
      });
//      Fluttertoast.showToast(msg: list.toString());
    });
  }
  void ChangeTheme(int index){
    ThemeStateModel().changeTheme(index);
  }
}
class DataBean{
  int id;
  String name;
  String ImageUrl;
  String desc;
  DataBean(this.id,this.name,this.ImageUrl,this.desc);
}