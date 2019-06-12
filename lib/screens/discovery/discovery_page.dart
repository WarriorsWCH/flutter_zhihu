
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_zhihu/blocs/discovery-bloc.dart';
import 'package:flutter_zhihu/screens/home/home_iitem.dart';
import 'package:flutter_easyrefresh/bezier_bounce_footer.dart';
import 'package:flutter_easyrefresh/bezier_circle_header.dart';

class DiscoveryPage extends StatefulWidget{
  @override
  _DiscoveryPageState createState() {
    return _DiscoveryPageState();
  }
}

class _DiscoveryPageState extends State<DiscoveryPage> with AutomaticKeepAliveClientMixin{

  DiscoveryBloc _bloc = DiscoveryBloc();
  
  int _page = 1;

  GlobalKey<EasyRefreshState> _easyRefreshKey = GlobalKey<EasyRefreshState>();
  GlobalKey<RefreshFooterState> _footerKey = GlobalKey<RefreshFooterState>();
  GlobalKey<RefreshHeaderState> _headerKey = GlobalKey<RefreshHeaderState>();

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    // _bloc.getQuestions(1, 10);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies(); 
    _bloc.getQuestions(1, 10);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color(0xFFFFFFFF),
        toolbarOpacity: 1.0,
        elevation: 0.5,//整个导航栏的不透明度
        brightness: Brightness.light,//状态栏上的字体为黑色
        title: Text('发现',style: TextStyle(
          color: Color.fromRGBO(74, 74, 74, 1.0),
          fontSize: 18.0,
          fontFamily: "PingFangSC-Regular")
        ),
      ),
      body: SafeArea(
        bottom: true,
        child: StreamBuilder(
          stream: _bloc.homeStream,
          builder: (context, snapshot){
          
            return EasyRefresh(
              key: _easyRefreshKey,
              refreshHeader: BezierCircleHeader(
                key: _headerKey,
                color: Theme.of(context).scaffoldBackgroundColor,
              ),
              refreshFooter: BezierBounceFooter(
                key: _footerKey,
                color: Theme.of(context).scaffoldBackgroundColor,
              ),
              onRefresh: () async {
                _bloc.getQuestions(1, 10);
              },
              loadMore: () {
                _page++;
                _bloc.getQuestions(_page, 10);     
              },
              child: ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  return HomeItem(_bloc.dataList[index],str: '发布',);
                },
                itemCount: _bloc.dataList.length,
            ));
          },
        ),
      ),
    );
  }
}