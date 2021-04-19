// import 'package:carpro/sos_screen.dart';
// import 'package:carpro/news_screen.dart';
import 'package:carpro/sos_screen.dart';
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
      home: SosScreen(),
    );
  }
}
