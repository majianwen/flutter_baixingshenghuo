import 'package:flutter/material.dart';
import './pages/index.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        child: MaterialApp(
          title:'百姓生活+',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primaryColor: Colors.pink,
          ),
          home: IndexPage(),
        ),
      ),
    );
  }
}