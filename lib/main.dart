import 'package:carpro/sale_detail_screen.dart.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Color(0xffd0d3d5),
        fontFamily: "Montserrat",
      ),
      home: SaleDetailScreen(),
    );
  }
}
