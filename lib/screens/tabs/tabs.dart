import 'package:flutter/material.dart';
import 'package:flutter_zhihu/screens/chat/chat.dart';
import 'package:flutter_zhihu/screens/discovery/discovery.dart';
import 'package:flutter_zhihu/screens/home/home_page.dart';
import 'package:flutter_zhihu/screens/more/more.dart';
import 'package:flutter_zhihu/screens/notification/notification.dart';
import 'package:flutter_zhihu/screens/tabs/eachtab.dart';


class TabModel{
  String title;
  IconData icon;
  TabModel(this.title,this.icon);
}

class Tabs extends StatefulWidget{

  @override
  _TabsState createState() {
    // TODO: implement createState
    return _TabsState();
  }
}

class _TabsState extends State<Tabs> with SingleTickerProviderStateMixin{

  TabController _tabController;
  int _selectedIndex = 0;
  List<TabModel> _titles = [
    TabModel('首页',Icons.home),
    TabModel('发现',Icons.disc_full),
    TabModel('聊天',Icons.chat),
    TabModel('通知',Icons.notifications),
    TabModel('更多',Icons.more)
  ];


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _tabController = TabController(length: _titles.length, vsync: this, initialIndex: 0);

    _tabController.addListener((){
      setState(() {
        _selectedIndex = _tabController.index;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: TabBarView(
//          physics: NeverScrollableScrollPhysics(),
          controller: _tabController,
          children: <Widget>[
            HomePage(),
            DiscoveryPage(),
            ChatPage(),
            NotificationPage(),
            MorePage()
          ]
      ),

      bottomNavigationBar: Container(
        height: 67 + MediaQuery.of(context).padding.bottom,
        child: Column(
          children: <Widget>[
            Divider(height: 1,),
            Expanded(
              child: Center(
                child: TabBar(
                  isScrollable: false,
                  controller: _tabController,
                  indicatorColor: Colors.transparent,
                  labelColor: Color(0xff7357ff),
                  labelPadding: EdgeInsets.all(0),
                  unselectedLabelColor: Color(0xff9b9b9b),
                  tabs: List.generate(_titles.length, (index){
                    print(_titles[index].title);
                    return _buildTabItem(_titles[index].title, Icon(_titles[index].icon));
                  }),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }


  Widget _buildTabItem(String text, Widget icon, [String badgeNo]){
    return EachTab(
      height: 60,
      padding: EdgeInsets.all(0),
      icon: icon,
      text: text,
      badgeNo: badgeNo == null ? null : badgeNo,
      badgeColor: badgeNo == null ? null : Color(0xffff0000),
      iconPadding: EdgeInsets.all(0),
      textStyle: TextStyle(fontSize: 10),
    );
  }
}