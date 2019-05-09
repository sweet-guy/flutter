import 'package:flutter/material.dart';
//import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:dio/dio.dart';
import 'package:my_flutter/mine/MinePage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sql.dart';
import 'package:scoped_model/scoped_model.dart';
class FindPage extends StatefulWidget{
   @override
    State<StatefulWidget> createState()=>FindPageState();
}

class FindPageState extends State<FindPage>
{
  List<String> datas=List<String>.generate(20, (i)=>"数据$i");
  String databasename;
  String databasepath;
  List data=[];
  List<Tab> tabs=[];

  List<Tab> myTabs= <Tab>[
    // ignore: use_of_void_result
//        datas.forEach((item){
//        Tab(text: item);
//    })
    Tab(text: '明教'),
    Tab(text: '霸刀'),
    Tab(text: '天策'),
    Tab(text: '纯阳'),
    Tab(text: '少林'),
    Tab(text: '藏剑'),
    Tab(text: '七秀'),
    Tab(text: '七秀'),
    Tab(text: '七秀'),
    Tab(text: '七秀312312'),
    Tab(text: '七秀'),
    Tab(text: '七秀32131'),
    Tab(text: '七秀'),
    Tab(text: '五毒123123'),
  ];

//  GlobalKey<EasyRefreshState> _easyRefreshKey = new GlobalKey<EasyRefreshState>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
//    getdbData();
    setdata();
  }
  @override
    Widget build(BuildContext context) {
    // TODO: implement build
    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        appBar: AppBar(
//          backgroundColor: Colors.blue,
          title: Text("title"),
          bottom: TabBar(
              tabs: tabs,
              isScrollable: true,
              indicatorColor: Colors.yellow,
              labelColor: Colors.white),
        ),
        body: Center(
        child:ListView.builder(itemCount:datas.length,itemBuilder: (context,index){
          return ListTile(
            title: Text(datas[index]),
          );
        })
      )
      ),


//      body:
//        RaisedButton(onPressed: (){
//          gethttp();
//        })
//      EasyRefresh(
//          key: _easyRefreshKey,
//          child:ListView(
//          ),
//        onRefresh: ()async{
//
//        },
//        loadMore: ()async{
//
//        },
//      )



    );

  }
  List<Tab>  setdata(){
    datas.forEach((item){
      tabs.add(Tab(text: item));
    });
  }
  void gethttp() async{
    Map nameparas={'username':'忧伤的枫叶丶'};
    Map passparas={'password':'123456'};
    BaseOptions baseOptions=BaseOptions(
      method: "POST",
      baseUrl: "https://www.wanandroid.com/",
      queryParameters: {
        "username":"忧伤的枫叶丶",
        "password":"123456"
      }
    );
    Response response=await Dio(baseOptions).post('user/login',
    );
    print("使用dio请求接口*-*-"+response.data.toString());
  }
 getdbData() async{
   SharedPreferences Preferences = await SharedPreferences.getInstance();
   String dbpath = Preferences.get("Data");
   String dbname=Preferences.get("dbname");
   print('打印读取数据为：$data');
   databasename=dbname;
   databasepath=dbpath;
   Fluttertoast.showToast(msg: "数据库路径为："+databasepath);
   Fluttertoast.showToast(msg: "数据库名为："+databasename);
  }
  _query()async{
    String sql="select * from "+databasename;
    Database db=await openDatabase(databasepath);
    List<Map> list=await db.rawQuery(sql);
    await db.close();
    data.clear();
    setState(() {
      print(list);
      list.forEach((item){
        data.add(DataBean(item['id'],item['name'],item['ImageUrl'],item['desc']));
      });
      Fluttertoast.showToast(msg: list.toString());
    });
  }
}
class SecondPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('第二个页面'),
        ),
        body: Center(
          child: RaisedButton(onPressed:(){
            Navigator.pushNamed(context, '/router/Third');
          })
        ),
      ),
    );
  }
}


