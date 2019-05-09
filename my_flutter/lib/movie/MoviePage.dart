import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';
class MoviePage extends StatefulWidget{
  @override
  State<StatefulWidget> createState()=>MovieState();
}

class MovieState extends State<MoviePage>
{
  VideoPlayerController _controller;
  bool _isPlaying = false;
  String url = 'http://2449.vod.myqcloud.com/2449_43b6f696980311e59ed467f22794e792.f20.mp4';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = VideoPlayerController.network(this.url);
    _controller = VideoPlayerController.network(this.url)
    // 播放状态
      ..addListener(() {
        final bool isPlaying = _controller.value.isPlaying;
        if (isPlaying != _isPlaying) {
          setState(() { _isPlaying = isPlaying; });
        }
      })
    // 在初始化完成后必须更新界面
      ..initialize().then((_) {
        setState(() {});
      });
  }
    @override
    Widget build(BuildContext context) {
      final videoPlayerController = VideoPlayerController.network(this.url);
      final chewieController = ChewieController(
        videoPlayerController: videoPlayerController,
        aspectRatio: 3 / 2,
        autoPlay: true,
        looping: true,
      );
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("精选"),
      ),
      body:
//      Column(
//        children: <Widget>[
//          CarouselSlider(
//            autoPlay: true,
//            aspectRatio: 12.0,
//            height:525.0,
//            items: ['https://img3.doubanio.com/view/photo/s_ratio_poster/public/p2542973862.jpg',
//            'https://img1.doubanio.com/view/photo/s_ratio_poster/public/p2551995207.jpg',
//            'https://img3.doubanio.com/view/photo/s_ratio_poster/public/p2530599636.jpg',
//            'https://img3.doubanio.com/view/photo/s_ratio_poster/public/p2543631842.jpg',
//            'https://img1.doubanio.com/view/photo/s_ratio_poster/public/p2541662397.jpg',
//            'https://img3.doubanio.com/view/photo/s_ratio_poster/public/p2529384763.jpg',
//            'https://img3.doubanio.com/view/photo/s_ratio_poster/public/p2537158013.jpg'].map((i) {
//              return Builder(
//                builder: (BuildContext context) {
//                  return Container(
//                      width: MediaQuery.of(context).size.width-10,
//                      margin: EdgeInsets.symmetric(horizontal: 10.0),
////                  decoration: BoxDecoration(
////                      color: Colors.amber
////                  ),
//                      child: Card(
//                        borderOnForeground: true,
//                        child: Image.network('$i',
//                          fit: BoxFit.fill,),
//                      )
////                  Text('text $i', style: TextStyle(fontSize: 16.0),)
//                  );
//                },
//              );
//            }).toList(),
//          ),
          Chewie(
              controller:chewieController
          ),
//        ],
//      )
    );
  }
}