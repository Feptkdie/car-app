import 'package:carpro/news_detail_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:carpro/news_appBar.dart';
import 'news_appBar.dart';

class NewsScreen extends StatefulWidget {
  @override
  _NewsScreenState createState() => _NewsScreenState();
}

DateTime now = DateTime.now();

class _NewsScreenState extends State<NewsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize:
              Size.fromHeight(MediaQuery.of(context).size.height * 0.1),
          child: NewsAppBar()),
      backgroundColor: Color(0xffd0d3d5),
      body: Column(
        children: <Widget>[
          _listView(context),
        ],
      ),
    );
  }

  Widget _listView(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        controller: ScrollController(),
        scrollDirection: Axis.vertical,
        itemBuilder: (BuildContext ctx, int index) {
          return Stack(
            children: [
              Container(
                margin: EdgeInsets.only(
                    left: MediaQuery.of(context).size.height * 0.03,
                    right: MediaQuery.of(context).size.height * 0.03,
                    bottom: MediaQuery.of(context).size.height * 0.02),
                height: MediaQuery.of(context).size.height * 0.3,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.grey[200],
                      Colors.grey[400],
                    ],
                  ),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black45,
                        blurRadius: 5,
                        offset: Offset(0, 3)),
                  ],
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  // top: MediaQuery.of(context).size.height * 0.03,
                  right: MediaQuery.of(context).size.height * 0.04,
                  left: MediaQuery.of(context).size.height * 0.04,
                ),
                child: Align(
                  alignment: Alignment.center,
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxHeight: MediaQuery.of(context).size.height * 0.25,
                      maxWidth: MediaQuery.of(context).size.height * 0.5,
                    ),
                    child: Container(
                      margin: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.05),
                      height: MediaQuery.of(context).size.height * 0.17,
                      width: MediaQuery.of(context).size.width / 1,
                      // decoration: BoxDecoration(
                      //   color: Colors.white,
                      //   borderRadius: BorderRadius.circular(10),
                      // ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: Image(
                          image: AssetImage(
                            "assets/car_bg.jpeg",
                          ),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Column(
                children: [
                  ListTile(
                    contentPadding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.height * 0.03,
                      // bottom: MediaQuery.of(context).size.height *
                      //     0.01
                    ),
                    dense: true,
                    enabled: false,
                    title: Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 8.0),
                          child: Icon(
                            Icons.timelapse,
                            size: MediaQuery.of(context).size.height * 0.02,
                            color: Colors.grey,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 8.0),
                          child: Text(
                            DateFormat('m').format(now) + "мин",
                            style: TextStyle(
                                fontFamily: "Montserrat",
                                fontSize:
                                    MediaQuery.of(context).size.height * 0.016),
                          ),
                        ),
                      ],
                    ),
                    trailing: InkWell(
                      child: Padding(
                        padding: EdgeInsets.only(
                          right: MediaQuery.of(context).size.height * 0.04,
                        ),
                        child: Icon(Icons.more_horiz),
                      ),
                    ),
                  ),
                  ListTile(
                    contentPadding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.13,
                      left: MediaQuery.of(context).size.height * 0.04,
                      right: MediaQuery.of(context).size.height * 0.04,
                    ),
                    title: Text(
                      "Авто лизингийн хүү  0,1% боллоо",
                      style: TextStyle(
                        fontFamily: "Montserrat",
                        fontSize: MediaQuery.of(context).size.height * 0.018,
                      ),
                    ),
                    subtitle: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => NewsDetailScreen(),
                          ),
                        );
                      },
                      child: Text(
                        "Үргэлжлүүлэн унших",
                        style: TextStyle(
                          fontFamily: "Montserrat",
                          fontSize: MediaQuery.of(context).size.height * 0.014,
                        ),
                      ),
                    ),
                    trailing: Icon(
                      Icons.bookmark_border,
                      size: MediaQuery.of(context).size.height * 0.03,
                    ),
                  ),
                ],
              )
            ],
          );
        },
      ),
    );
  }
}
