import 'package:dio/dio.dart';
import 'dart:io';
import 'dart:async';
import '../config/service_url.dart';


//获取首页数据
Future getHomPageContent() async{
  try {
    print('开始获取首页数据。。。。。。。。。。');
    
    Response response;
    Dio dio = new Dio();
    dio.options.contentType = ContentType.parse('application/x-www-form-urlencoded');
    var formData = {
      'lon':'115.02932',
      'lat':'35.76189'
    };
    response = await dio.post(servicePath['homePageContent'],data: formData);
    //判断是否请求成功
    if(response.statusCode == 200){
      return response.data;
    }else{
      throw Exception('获取后台数据异常');
    }
  } catch (e) {
    return print('ERROR==========>${e}');
  }
}