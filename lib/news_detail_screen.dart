import 'package:carpro/widget/appBar_title.dart';
import 'package:carpro/widget/arrow_button.dart';
import 'package:carpro/widget/news_cart.dart';
import 'package:carpro/widget/search_btn.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class NewsDetailScreen extends StatefulWidget {
  @override
  _NewsDetailScreenState createState() => _NewsDetailScreenState();
}

class _NewsDetailScreenState extends State<NewsDetailScreen> {
  DateTime now = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffd0d3d5),
      appBar: PreferredSize(
        preferredSize:
            Size.fromHeight(MediaQuery.of(context).size.height * 0.1),
        child: Padding(
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).size.height * 0.05,
            bottom: MediaQuery.of(context).size.height * 0.02,
          ),
          child: Row(
            children: [
              ArrowButton(),
              AppBarTitle(title: "Мэдээ"),
              Expanded(
                child: SearchBtn(
                  searchText: "Хайлтын түлхүүр үг",
                ),
              )
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: _cardWidget(context),
        ),
      ),
    );
  }

  Widget _cardWidget(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext ctx, BoxConstraints constraints) {
      return NewsCart();
    });
  }
}
