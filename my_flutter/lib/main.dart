import 'package:flutter/material.dart';
import 'package:my_flutter/movie/MoviePage.dart';
import 'package:my_flutter/head/HeadPage.dart';
import 'package:my_flutter/head/RefreshPage.dart';
import 'package:my_flutter/login/LoginPage.dart';
import 'package:my_flutter/find/FindPage.dart';
import 'package:my_flutter/mine/MinePage.dart';
import 'package:my_flutter/util/ThemeStateModel.dart';
import 'package:scoped_model/scoped_model.dart';
//void main() => runApp(MyApp());
void main() => runApp(MyApp());
Color themeclolor;
class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      home: WelComePage(),
    );
  }
}
class MainPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MainPage();
  }
}
class _MainPage extends State<MainPage> {
  // This widget is the root of your application.
  final List<Color> themeList = [
    Colors.black,
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
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ChangeTheme(3);
  }
  @override
  Widget build(BuildContext context) {
    return ScopedModel<ThemeStateModel>(
      model: ThemeStateModel(),
      child:ScopedModelDescendant<ThemeStateModel>(builder: (context,child,model) {
        return MaterialApp(
          theme: ThemeData(
            primaryColor: themeclolor=themeList[model.themeIndex != null ? model.themeIndex : 0]
          ),
          title: 'BottomNavigationBar',
          home: new Scaffold(
            appBar: AppBar(
              title: Text("BottomNavigationBar"),
            ),
            bottomNavigationBar: BottomNavigationWidght(),
//          bottomNavigationBar: BottomNavigationWidght(),
//          body: pages[_currentIndex],
//          body:pages[_currentIndex],
          ),
        );

      },
      )
    );
  }
  void ChangeTheme(int index){
    ThemeStateModel().changeTheme(index);
    }
}

class BottomNavigationWidght extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => BottomNavigationWidgetState();
}

class BottomNavigationWidgetState extends State<BottomNavigationWidght> {
  final _bottomNavigationColor = themeclolor;
  int _currentIndex = 0;
  List<Widget> pages=new List<Widget>();
  @override
  void initState()
  {
    pages..add(HeadPage())
      ..add(MoviePage())
      ..add(FindPage())
      ..add(MinePage());
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                color: _bottomNavigationColor,
              ),
              title: Text(
                '主页',
                style: TextStyle(color: _bottomNavigationColor),
              )
          ),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.email,
                color: _bottomNavigationColor,
              ),
              title: Text(
                '精选',
                style: TextStyle(color: _bottomNavigationColor),
              )
          ),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.pages,
                color: _bottomNavigationColor,
              ),
              title: Text(
                '发现',
                style: TextStyle(color: _bottomNavigationColor),
              )
          ),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.airplay,
                color: _bottomNavigationColor,
              ),
              title: Text(
                '我的',
                style: TextStyle(color: _bottomNavigationColor),
              )
          )
        ],
        currentIndex: _currentIndex,
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        fixedColor: themeclolor,
      ),
    );
  }
}
class WelComePage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _WelComePage();
  }
}
class _WelComePage extends State<WelComePage>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return
      Container(
        decoration: BoxDecoration(
            image: DecorationImage(image: NetworkImage('http://pic.5tu.cn/uploads/allimg/1704/pic_5tu_big_201704121416459557.jpg'),
                fit: BoxFit.cover)
        ),
      );
  }
  @override
  void initState() {
    super.initState();
    countDown();
  }
  // 倒计时
  void countDown() {
    var _duration = new Duration(seconds: 7);
    Future.delayed(_duration,goMainPage);
  }
  void goMainPage(){
    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=> LoginPage()), (route)=>route==null);
  }
}

