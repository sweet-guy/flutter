import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_flutter/webview/WebView.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:carousel_slider/carousel_slider.dart';
class HeadPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MyHomeApp();
  }
}

class MyHomeApp extends StatefulWidget {
  final String title;

  MyHomeApp({Key key, this.title}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _MyHomeAppState();
  }
}

class _MyHomeAppState extends State<MyHomeApp> {
  List subjects = [];
  String title = '';
  RefreshController _refreshController=RefreshController();
  @override
  void initState() {
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    RefreshController controller=RefreshController();
    return Scaffold(
        drawer: Drawer(
            child: ListView(
              children: <Widget>[
                UserAccountsDrawerHeader(
                  accountName: Text('忧伤的枫叶丶'), accountEmail: Text("密码：123456"),
                  currentAccountPicture: CircleAvatar(
                    backgroundImage: AssetImage('images/fig.png'),
                  ),
                  decoration: BoxDecoration(
                      image: DecorationImage(fit: BoxFit.fill,
                          image: ExactAssetImage('images/timg.jpg'))
                  ),),
                MyListTile(0),
                MyListTile(1),
                MyListTile(2),
                MyListTile(0),
                MyListTile(1),
                MyListTile(2),
              ],
            )
        ),
//      appBar: AppBar(
//        title: Text(title),
//      ),
        appBar: AppBar(
          title: Text('My Flutter！'),
//          backgroundColor: Colors.blue,
        ),
        body: Column(
            children: <Widget>[
              getbanner(),
              Expanded(
                child: getBody(),
              )
            ],
          ),

//        SmartRefresher(child: getBody(), controller: null)
//        getBody()
//        SmartRefresher(
//            enablePullDown: true,
//            enablePullUp: true,
//            onRefresh: _onRefresh,
////            onOffsetChange: _onOffsetCallback,
//            child: getBody()
//        )
    );
  }
  loadData() async {
    String loadRUL = "https://api.douban.com/v2/movie/in_theaters";
    http.Response response = await http.get(loadRUL);
    var result = json.decode(response.body);
    setState(() {
      title = result['title'];
      print('title: $title');
      subjects = result['subjects'];
    });
      print(result);
  }
  refreshData()async{
    String loadRUL = "https://api.douban.com/v2/movie/in_theaters";
    http.Response response = await http.get(loadRUL);
    var result = json.decode(response.body);
    setState(() {
      title = result['title'];
      print('title: $title');
      subjects = result['subjects'];
    });
  }


  getItem(var subject, int postion) {
//    演员列表
    var avatars = List.generate(subject['casts'].length, (int index) =>
    new GestureDetector(onTap: () {
      print("点击第" + index.toString() + "个条目");
      Fluttertoast.showToast(msg: subject['title']);
    }, child: Container(
      margin: EdgeInsets.only(left: index.toDouble() == 0.0 ? 0.0 : 16.0),
      child: CircleAvatar(
          backgroundColor: Colors.white10,
          backgroundImage: NetworkImage(
              subject['casts'][index]['avatars']['small']
          )
      ),
    ),)
    );
    var row = Container(
      margin: EdgeInsets.all(4.0),
      child: Row(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(4.0),
            child: Image.network(
              subject['images']['large'],
              width: 100.0, height: 150.0,
              fit: BoxFit.fill,
            ),
          ),
          Expanded(
              child: Container(
                margin: EdgeInsets.only(left: 8.0),
                height: 150.0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
//                    电影名称
                    Text(
                      subject['title'],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                      ),
                      maxLines: 1,
                    ),
//                    豆瓣评分
                    Text(
                      '豆瓣评分：${subject['rating']['average']}',
                      style: TextStyle(
                          fontSize: 16.0
                      ),
                    ),
//                    类型
                    Text(
                        "类型：${subject['genres'].join("、")}"
                    ),
//                    导演
                    Text(
                        '导演：${subject['directors'][0]['name']}'
                    ),
//                    演员
                    Container(
                      margin: EdgeInsets.only(top: 8.0),
                      child: Row(
                        children: <Widget>[
                          Text('演员表：'),
                          Row(
                            children: avatars,
                          )
                        ],
                      ),
                    )
                  ],
                ),
              )
          )
        ],
      ),
    );
    return new GestureDetector(onTap: () {
//      print('点击');
      Fluttertoast.showToast(msg: subject['title']);
      Navigator.of(context).push(MaterialPageRoute(builder: (context) {
        return WebView(subject['alt'], subject['title']);
//      return WebView();
      }));
      print("点击第" + postion.toString() + "个条目");
    }, child: Card(
      child: row,
    ));
  }

  getBody() {
    if (subjects.length != 0) {
      return ListView.builder(
          itemCount: subjects.length,
          itemBuilder: (BuildContext context, int position) {
            return getItem(subjects[position], position);
          });
    } else {
      // 加载菊花
      return CupertinoActivityIndicator();
    }
  }
  getbanner()
  {
    return CarouselSlider(
      autoPlay: true,
      aspectRatio: 5.0,
      height:260.0,
      items: ['images/1.jpg',
      'images/2.jpg',
      'images/3.jpg',
      'images/4.jpg',
      'images/5.jpg',
      'images/6.jpg',
      ].map((i) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
                width: MediaQuery.of(context).size.width-100,
                margin: EdgeInsets.symmetric(horizontal: 1.0),
//                  decoration: BoxDecoration(
//                      color: Colors.amber
//                  ),
                child: Card(
                  borderOnForeground: true,
                  child: Image.asset('$i',
                    fit: BoxFit.none,),
                )
//                  Text('text $i', style: TextStyle(fontSize: 16.0),)
            );
          },
        );
      }).toList(),
    );
  }
  Widget MyListTile(int type) {
    final List<Color> themeList = [
      Colors.red,
      Colors.teal,
      Colors.pink,
      Colors.amber,
      Colors.orange,
      Colors.green,
      Colors.blue,
      Colors.lightBlue,
      Colors.purple,
      Colors.deepPurple,
      Colors.indigo,
      Colors.cyan,
      Colors.brown,
      Colors.grey,
      Colors.blueGrey
    ];
    switch (type) {
      case 0:
        return ListTile(
          onTap: (){
            showtoast();
          },
          title: Text("最新电影"),
          leading: Icon(
              Icons.tablet
          ),
        );
      case 1:
        return ListTile(
          onTap: (){
            showtoast();
          },
          title: Text("图片"),
          leading: Icon(
              Icons.map
          ),
        );
      case 2:
        return ListTile(
          onTap: (){
            showDialog(context: context,builder: (context){
              return AlertDialog(
                title: Text('切换主题    (15种)'),
                content:Container(
                  width: 350,
                  height: 500,
                  color: Colors.black,
                  child: ListView.builder(itemCount:themeList.length,itemBuilder: (context,index){
                  return ListViewitem(index,themeList[index]);
                }),
                ) ,
//                content:
                actions: <Widget>[
                  new FlatButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: new Text("确认"),
                  ),
                  new FlatButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: new Text("取消"),
                  ),
                ],
              );
            });
          },
          title: Text("主题"),
          leading: Icon(
              Icons.account_box
          ),
        );
    }
  }
  void showtoast(){
    Fluttertoast.showToast(msg: "尽请期待！！！");
  }
}
Widget ListViewitem(int index,Color itemcolor){
  return Card(
    child: GestureDetector(
      child:Container(
        width: 300,
        height: 50,
        color: itemcolor,
      ),
      onTap: (){
        Fluttertoast.showToast(msg: "点击了第"+index.toString());
      },
    )
  );
}
