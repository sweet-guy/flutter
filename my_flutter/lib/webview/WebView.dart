import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
class WebView extends StatelessWidget{
//  String  news_url="http://news.mtime.com/2019/04/12/1590842.html";
//  String title="";
  String news_url;
  String title;
  WebView(this.news_url,this.title);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      home: showWebView(news_url,title),
    );
  }
}
class showWebView extends StatefulWidget{
  String  news_url;
  String title;
  showWebView(this.news_url,this.title);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _showWebView(news_url,title);
  }
}
class _showWebView extends State<showWebView>{
  String  news_url;
  String title;
  _showWebView(this.news_url,this.title);
    @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return WebviewScaffold(url: news_url);
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}