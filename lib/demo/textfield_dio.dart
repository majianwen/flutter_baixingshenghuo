import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class HomePage extends StatefulWidget {
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController typecontroller = TextEditingController();
  String showText = '这里显示后台返回的内容';

  @override
  Widget build(BuildContext context) {
    
    return Container(
       child: Scaffold(
         appBar: AppBar(
           title: Text('标题'),
         ),
         body: Container(
           child: Column(
             children: <Widget>[
              TextField(
                controller: typecontroller,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(10.0),
                  labelText: '人物类型',
                  helperText: '请选择你要类型'
                ),
                autofocus: false, //是否自动获得焦点，关闭不然会掉起键盘
              ),
              RaisedButton(
                child: Text('选择完毕'),
                onPressed: _btnOnPressed,
              ),
              Text(
                showText,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              )
             ],
           ),
         ),
       ),
    );
  }
  _btnOnPressed(){
    if(typecontroller.text.toString() ==''){
      showDialog(
        context: context,
        builder: (context)=>AlertDialog(
          title:Text('填写的内容不能为空')
        )
      );
    }else{
      print('开始查找数据');
      getHttp(typecontroller.text.toString()).then((val){
        setState((){
          print(val);
          showText = val['data']['name'];
        });
      });
    }
  }
  Future getHttp(String typetext)async{
    try {
      Response response;
      var data = {
        'name':typetext
      };
      response = await Dio().get(
        'https://www.easy-mock.com/mock/5c60131a4bed3a6342711498/baixing/dabaojian',
        queryParameters: data
      );
      return response.data;
    } catch (e) {
      return print(e);
    }
  }
}