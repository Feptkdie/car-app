import 'package:carpro/constants.dart';
import 'package:flutter/material.dart';

import 'pages/home/home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CarPro',
      theme: ThemeData(
        primaryColor: kPrimaryColor,
      ),
      home: HomePage(),
    );
  }
}
