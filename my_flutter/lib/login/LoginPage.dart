import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_flutter/main.dart';
import 'package:dio/dio.dart';
import 'dart:convert' show json;
class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return LoginPageStateful();
  }
}

class LoginPageStateful extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _LoginPageStateful();
  }
}

class _LoginPageStateful extends State<LoginPageStateful> {
  bool _nameState,
      _pwdState = false;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final name_controller = TextEditingController();
    final pass_controller = TextEditingController();
    void _checkname() {
      if (name_controller.text.isNotEmpty) {
        _nameState = true;
      }
      else {
        _nameState = false;
      }
    }
    void _checkpwd() {
      if (pass_controller.text.isNotEmpty && pass_controller.text.isNotEmpty) {
        _pwdState = true;
      }
      else {
        _pwdState = false;
      }
    }
//    name_controller.addListener(() {
//      Fluttertoast.showToast(msg: '输入账号为：' + '${name_controller.text}');
//    });
//    pass_controller.addListener(() {
//      Fluttertoast.showToast(msg: '输入密码为：' + '${pass_controller.text}');
//    });
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              title: Text('快速登录'),
            ),
            body: Stack(
              children: <Widget>[
                ListView(
                  children: <Widget>[
                    Column(
                        children: <Widget>[
                          Padding(
                              padding: EdgeInsets.all(30.0),
                              child: Image.asset('images/logo.gif', width: 240,
                                height: 240,)
                          ),
                          Padding(
                            padding: new EdgeInsets.fromLTRB(
                                20.0, 0.0, 20.0, 15.0),
                            child: Stack(
                              alignment: Alignment(1.0, 1.0),
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Image.asset('images/name.png',
                                        width: 30,
                                        height: 30),
                                    Expanded(
                                      child: TextField(
                                        controller: name_controller,
                                        keyboardType: TextInputType.text,
                                        decoration: InputDecoration(
                                            hintText: '请输入账号',
                                            border: OutlineInputBorder(
                                                borderRadius: BorderRadius
                                                    .circular(10.0)
                                            )
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                IconButton(
                                    icon: Icon(
                                      Icons.clear, color: Colors.black45,),
                                    onPressed: () {
                                      name_controller.clear();
                                    }
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: new EdgeInsets.fromLTRB(
                                20.0, 0.0, 20.0, 15.0),
                            child: Stack(
                              alignment: Alignment(1.0, 1.0),
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Image.asset('images/pass.png',
                                        width: 30,
                                        height: 30),
                                    Expanded(
                                      child: TextField(
                                        obscureText: true,
                                        controller: pass_controller,
                                        keyboardType: TextInputType.text,
                                        decoration: InputDecoration(
                                            hintText: '请输入密码',
                                            border: OutlineInputBorder(
                                                borderRadius: BorderRadius
                                                    .circular(10.0)
                                            )
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                IconButton(
                                    alignment: Alignment.center,
                                    icon: Icon(
                                      Icons.clear, color: Colors.black45,),
                                    onPressed: () {
                                      pass_controller.clear();
                                    }
                                )
                              ],
                            ),
                          ),
                          Container(
                            width: 200,
                            height: 50,
                            child: RaisedButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(20))
                              ),
                              child: Text('登录',),
                              color: Colors.blue,
                              onPressed: () {
                                String name = name_controller.text;
                                String pass = pass_controller.text;
                                _checkname();
                                _checkpwd();
//                                Fluttertoast.showToast(msg: '登录成功！账号为'+name+'密码为'+pass);
                                if (_nameState == false) {
                                  Fluttertoast.showToast(msg: '账号为空');
                                }
                                else {
                                  if (_pwdState == false) {
                                    Fluttertoast.showToast(msg: '密码格式不正确');
                                  }
                                  else {
                                    String name = name_controller.text;
                                    String pass = pass_controller.text;
                                    gethttp(name, pass);
                                  }
                                }
                              },
                            ),
                          )
                        ]
                    ),
                  ],
                )
              ],
            )
        )
    );
  }

  void gethttp(String username, userpass) async {
    BaseOptions baseOptions = BaseOptions(
        method: "POST",
        baseUrl: "https://www.wanandroid.com/",
        queryParameters: {
          "username": username,
          "password": userpass
        }
    );
    Response response = await Dio(baseOptions).post('user/login',
    );
//    print();
    print("dio请求的数据：*-*-*-**"+response.data.toString());
    var logindata =Logindata.fromJson(response.data);
//    var jsonres= json.decode(response.data);
//    LoginData loginData= jsonres['data'];
//    print('dio请求的数据：'+loginData.toString());
//    Map<String,dynamic>  logindata=json.decode(response.data);
//    List data=[];
//    data=logindata['data'];
//    print('dio请求的数据：*-*-*-**, ${databean.data[1].title}!');
//    print('dio请求的数据：*-*-*-**'+databean.data[1].title);
//    print('dio请求的数据：*-*-*-**'+databean.errorMsg);
//    print('dio请求的数据：*-*-*-**'+databean.errorCode.toString());
    if (logindata.errorCode==0) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
              builder: (context) => MainPage()), (route) => route == null);
    }
    Fluttertoast.showToast(msg: logindata.errorMsg);
  }
}



class Logindata {

  Object data;
  int errorCode;
  String errorMsg;

  Logindata.fromParams({this.data, this.errorCode, this.errorMsg});

  factory Logindata(jsonStr) => jsonStr == null ? null : jsonStr is String ? new Logindata.fromJson(json.decode(jsonStr)) : new Logindata.fromJson(jsonStr);

  Logindata.fromJson(jsonRes) {
    data = jsonRes['data'];
    errorCode = jsonRes['errorCode'];
    errorMsg = jsonRes['errorMsg'];
  }

  @override
  String toString() {
    return '{"data": $data,"errorCode": $errorCode,"errorMsg": ${errorMsg != null?'${json.encode(errorMsg)}':'null'}}';
  }
}







