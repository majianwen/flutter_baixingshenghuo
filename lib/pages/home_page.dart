import 'package:flutter/material.dart';
import '../service/services_methods.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'dart:convert';

class HomePage extends StatefulWidget {
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String homePageContent = '正在获取数据';
  @override
  void initState() {
    getHomPageContent().then((val) {
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
          if (snapshot.hasData) {
            var data = json.decode(snapshot.data.toString());
            List<Map> swiper = (data['data']['slides'] as List).cast(); //解析数据
            return Column(
              children: <Widget>[SwiperDiy(swiperDataList: swiper)],
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

class SwiperDiy extends StatelessWidget {
  final List swiperDataList;

  SwiperDiy({Key key, this.swiperDataList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 160,
        child: Swiper(
          itemBuilder: (BuildContext context, int index) {
            return Image.network("${swiperDataList[index]['image']}",fit: BoxFit.cover,);
          },
          itemCount: 3,
          pagination: SwiperPagination(),
          autoplay: true,
        ));
  }
}
