import 'package:flutter/material.dart';
class RefreshPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ListPage();
  }
}

class ListPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ListPage();
  }
}

class _ListPage extends State<ListPage> {
//  GlobalKey<EasyRefreshState> _easyRefreshKey = new GlobalKey<
//      EasyRefreshState>();
  final ScrollController _scrollController = new ScrollController();

  //是否在加载
  bool isLoading = false;

  // 是否有更多数据
  bool isHasNoMore = false;

  // 当前页
  var currentPage = 0;

  // 一页的数据条数
  final int pageSize = 20;

  // 这个key用来在不是手动下拉，而是点击某个button或其它操作时，代码直接触发下拉刷新
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = new GlobalKey<
      RefreshIndicatorState>();
  List<String> data = [];
  List<String> one = List.generate(10, (i) => "数据$i");
  List<String> two = List.generate(10, (i) => "加载$i");

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _getMoreData();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build


    return Scaffold
    (
        body: Center(
//        child: EasyRefresh(
//          key: _easyRefreshKey,
//          onRefresh: () {
//            setState(() {
//              data.clear();
//              data.addAll(one);
//            });
//          },
//          loadMore: () {
//            setState(() {
//              data.addAll(two);
//            });
//          },
//          child: listview()
        )
    );
  }

  Widget listview() {
    return ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(data[index]),
          );
        });
  }

  void _getMoreData() async {
    if (!isLoading) {
      currentPage++;
      loadData(true);
    }
  }

  loadData(bool isloadMore) {
    if (data.length < pageSize) {
      isHasNoMore = true;
    } else {
      isHasNoMore = false;
    }
    if (isHasNoMore) {
      setState(() {
        isLoading = false;
        data.addAll(two);
      });
    } else {
      setState(() {
        data = data;
      });
    }
  }
}