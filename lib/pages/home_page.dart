import 'package:flutter/material.dart';
import '../service/services_methods.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'dart:convert';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>  with AutomaticKeepAliveClientMixin{
  @override
  bool get wantKeepAlive =>true;
  
  String homePageContent = '正在获取数据';
  @override
  void initState() {
    getHomPageContent().then((val) {
      print('aaaaaaaaaaaaa');
      setState(() {
        homePageContent = val.toString();
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('百姓生活+'),
      ),
      body: FutureBuilder(
        future: getHomPageContent(),
        builder: (context, snapshot) {
          print(snapshot);
          if (snapshot.hasData) {
            var data = json.decode(snapshot.data.toString());
            List<Map> swiper = (data['data']['slides'] as List).cast(); //解析数据
            List<Map> navigatorList =
                (data['data']['category'] as List).cast(); //解析数据
            String adPicture =
                data['data']['advertesPicture']['PICTURE_ADDRESS']; //解析数据
            String leaderImage = data['data']['shopInfo']['leaderImage']; //解析数据
            String leaderPhone = data['data']['shopInfo']['leaderPhone']; //解析数据
            List<Map> recommendList =
                (data['data']['recommend'] as List).cast(); //解析数据
            String floor1Title = data['data']['floor1Pic']['PICTURE_ADDRESS']; //解析数据
            String floor2Title = data['data']['floor2Pic']['PICTURE_ADDRESS']; //解析数据
            String floor3Title = data['data']['floor3Pic']['PICTURE_ADDRESS']; //解析数据
            List<Map> floor1List =
                (data['data']['floor1'] as List).cast(); //解析数据
            List<Map> floor2List =
                (data['data']['floor2'] as List).cast(); //解析数据
            List<Map> floor3List =
                (data['data']['floor3'] as List).cast(); //解析数据

            print(navigatorList[0]);
            return SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  SwiperDiy(swiperDataList: swiper),
                  TopNavigator(navigatorlist: navigatorList),
                  ADBanner(adPicture: adPicture),
                  LeaderPhone(
                    leaderImage: leaderImage,
                    leaderPhone: leaderPhone,
                  ),
                  RecommendList(recommendList: recommendList,),
                  FloorTitle(floorTitleImage:floor1Title),
                  FloorContent(floorGoodsList:floor1List),
                  FloorTitle(floorTitleImage:floor2Title),
                  FloorContent(floorGoodsList:floor2List),
                  FloorTitle(floorTitleImage:floor3Title),
                  FloorContent(floorGoodsList:floor3List),
                ],
              ),
            );
          } else {
            return Center(
              child: Text('加载中..........'),
            );
          }
        },
      ),
    );
  }
}

//轮播图组件
class SwiperDiy extends StatelessWidget {
  final List swiperDataList;

  SwiperDiy({Key key, this.swiperDataList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: ScreenUtil().setHeight(333),
        width: ScreenUtil().setWidth(750),
        child: Swiper(
          itemBuilder: (BuildContext context, int index) {
            return Image.network(
              "${swiperDataList[index]['image']}",
              fit: BoxFit.cover,
            );
          },
          itemCount: 3,
          pagination: SwiperPagination(),
          autoplay: true,
        ));
  }
}

//页面顶部导航
class TopNavigator extends StatelessWidget {
  final List navigatorlist;

  TopNavigator({Key key, this.navigatorlist}) : super(key: key);
  Widget _grideviewItemUI(BuildContext context, item) {
    return InkWell(
      onTap: () {
        print('点击了gridview');
      },
      child: Column(
        children: <Widget>[
          Image.network(item['image'], width: ScreenUtil().setWidth(95)),
          Text(item['mallCategoryName'])
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (this.navigatorlist.length > 10) {
      this.navigatorlist.removeRange(10, this.navigatorlist.length);
    }
    ;
    return Container(
      height: ScreenUtil().setHeight(320),
      padding: EdgeInsets.all(3.0),
      child: GridView.count(
        crossAxisCount: 5,
        padding: EdgeInsets.all(5.0),
        children: navigatorlist.map((item) {
          return _grideviewItemUI(context, item);
        }).toList(),
      ),
    );
  }
}

//banner
class ADBanner extends StatelessWidget {
  final String adPicture;

  ADBanner({Key key, this.adPicture}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Image.network(adPicture),
    );
  }
}

//店长热线
class LeaderPhone extends StatelessWidget {
  final String leaderImage;
  final String leaderPhone;

  LeaderPhone({Key key, this.leaderImage, this.leaderPhone}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        onTap: _launchURL,
        child: Image.network(leaderImage),
      ),
    );
  }

  //拨打电话
  _launchURL() async {
    String url = 'tel:' + leaderPhone;
    // String url = 'https://github.com/majianwen/flutter_baixingshenghuo';
    // String url = 'sms:13146518683';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'url不能进行访问';
    }
  }
}

//商品推荐
class RecommendList extends StatelessWidget {
  final List recommendList;

  RecommendList({Key key, this.recommendList}) : super(key: key);
  //商品头
  Widget _titleWidget(){
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.fromLTRB(10.0, 2.0, 0, 5.0),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(width: 0.5,color: Colors.black12)
        )
      ),
      child: Text(
        '商品推荐',
        style:TextStyle(color:Colors.pink)
      ),
    );
  }
  //商品主体
  Widget _item(index){
    return InkWell(
      onTap: (){},
      child: Container(
        height: ScreenUtil().setHeight(345),
        width: ScreenUtil().setWidth(250),
        padding: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            left: BorderSide(width: 0.5,color: Colors.black12)
          )
        ),
        child: Column(
          children: <Widget>[
            Image.network(recommendList[index]['image']),
            Text('￥${recommendList[index]['mallPrice']}'),
            Text('￥${recommendList[index]['price']}',style: TextStyle(decoration: TextDecoration.lineThrough,color: Colors.grey),),
          ],
        ),
      ),
    );
  }
  
  //商品列表
  Widget _recommendList(){
    return  Container(
      height: ScreenUtil().setHeight(345),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: recommendList.length,
        itemBuilder: (BuildContext context, index){
          return _item(index);
        },
      ),
    );
  }
 
  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil().setHeight(410),
      margin: EdgeInsets.only(top: 10.0),
      child: Column(
        children: <Widget>[
          _titleWidget(),
          _recommendList()  
        ],
      ),
    );
  }
}

//楼层头部
class FloorTitle extends StatelessWidget {
  final String floorTitleImage;
  FloorTitle({Key key, this.floorTitleImage}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      child: Image.network(floorTitleImage),
    );
  }
}
//楼层列表
class FloorContent extends StatelessWidget {
  final List floorGoodsList;

  FloorContent({Key key, this.floorGoodsList}) : super(key: key);
  //楼层列表组件
  Widget _goodsItems(Map goods){
    return  Container(
      width: ScreenUtil().setWidth(375),
      child: InkWell(
        onTap: (){print('点击了图片');},
        child: Image.network(goods['image']),
      ),
    );
  }
  //第一层
  Widget _firstFloor(){
  print(floorGoodsList);
    return Row(
      children: <Widget>[
        _goodsItems(floorGoodsList[0]),
        Column(children: <Widget>[
          _goodsItems(floorGoodsList[1]),
          _goodsItems(floorGoodsList[2]),
        ],)
      ],
    );
  }
  //其他楼层
  Widget _otherFloor(){
    return Row(
      children: <Widget>[
        _goodsItems(floorGoodsList[3]),
        _goodsItems(floorGoodsList[4]),
      ],
    );
  }
  @override
  Widget build(BuildContext context) {
    
    return Container(
      child: Column(
        children: <Widget>[
          _firstFloor(),
          _otherFloor(),
        ],
      ),
    );
  }
}