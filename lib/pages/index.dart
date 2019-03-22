import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'home_page.dart';
import 'category_page.dart';
import 'cart_page.dart';
import 'member_page.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class IndexPage extends StatefulWidget {
  final Widget child;
  IndexPage({Key key, this.child}) : super(key: key);
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  //底部标签栏的数组
  final List<BottomNavigationBarItem> bottomTabs = [
    BottomNavigationBarItem(
      icon: Icon(CupertinoIcons.home),
      title: Text('首页'),
       backgroundColor: Colors.pink,
    ),
    BottomNavigationBarItem(
      icon: Icon(CupertinoIcons.search),
      title: Text('分类'),
       backgroundColor: Colors.pink,
    ),
    BottomNavigationBarItem(
      icon: Icon(CupertinoIcons.shopping_cart),
      title: Text('购物车'),
       backgroundColor: Colors.pink,
    ),
    BottomNavigationBarItem(
      icon: Icon(CupertinoIcons.profile_circled,),
      title: Text('会员中心',),
      backgroundColor: Colors.pink,
    ),
  ];
  final List<Widget> bottomBodies = [
    HomePage(),
    CategoryPage(),
    CartPage(),
    MemberPage()
  ];
  int currentIndex = 0;
  var currentPage;

  //初始化
  @override
  void initState() {
    currentPage = bottomBodies[currentIndex];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 750,height: 1334)..init(context);
    return Container(
      child: Scaffold(
        backgroundColor: Color.fromRGBO(244, 245, 245, 1.0),
        body: IndexedStack(
          index: currentIndex,
          children: bottomBodies,
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.shifting,
          currentIndex: currentIndex,
          items: bottomTabs,
          onTap: (index) {
            setState(() {
              currentIndex = index;
              currentPage = bottomBodies[currentIndex];
            });
          },
        ),
      ),
    );
  }
}
