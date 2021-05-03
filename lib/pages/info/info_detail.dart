import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';

import '../../constants.dart';
import 'info_page.dart';

class NewsDetailScreen extends StatefulWidget {
  final int index;

  const NewsDetailScreen({Key key, this.index}) : super(key: key);
  @override
  _NewsDetailScreenState createState() => _NewsDetailScreenState();
}

class _NewsDetailScreenState extends State<NewsDetailScreen> {
  DateTime now = DateTime.now();

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color(0xffd0d3d5),
      appBar: AppBar(
        backgroundColor: kBackColor2,
        leading: Padding(
          padding: const EdgeInsets.all(
            6.0,
          ),
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).pop(context);
            },
            child: Theme.of(context).platform == TargetPlatform.iOS
                ? Padding(
                    padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.height * 0.01,
                    ),
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.045,
                      width: MediaQuery.of(context).size.height * 0.045,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          colors: [
                            Colors.red[500],
                            Colors.red[900],
                          ],
                        ),
                      ),
                      child: CupertinoButton(
                        color: Colors.transparent,
                        child: Icon(
                          Icons.arrow_back_ios,
                          color: Colors.white,
                        ),
                        onPressed: () {},
                      ),
                    ),
                  )
                : Padding(
                    padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.height * 0.01,
                    ),
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.045,
                      width: MediaQuery.of(context).size.height * 0.045,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          colors: [
                            Colors.red[500],
                            Colors.red[900],
                          ],
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black87,
                            blurRadius: 7,
                            offset: Offset(2, 2),
                          ),
                        ],
                      ),
                      child: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      ),
                    ),
                  ),
          ),
        ),
        title: Text(
          "Мэдээлэл",
          style: TextStyle(
            color: kTextGrey,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: _cardWidget(context, now),
        ),
      ),
    );
  }

  Widget _cardWidget(BuildContext context, DateTime now) {
    return LayoutBuilder(
        builder: (BuildContext ctx, BoxConstraints constraints) {
      return Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            SingleChildScrollView(
              child: Stack(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.height * 0.03,
                        right: MediaQuery.of(context).size.height * 0.03,
                        bottom: MediaQuery.of(context).size.height * 0.02),
                    child: Card(
                      color: Colors.transparent,
                      elevation: 0.0,
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal:
                                    MediaQuery.of(context).size.height * 0.01),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Row(
                                    children: [
                                      Image.asset(
                                        "assets/images/clock.png",
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.012,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(left: 5.0),
                                        child: Text(
                                          InfoData
                                              .infoItems[widget.index].createdAt
                                              .substring(0, 10),
                                          style: TextStyle(
                                              fontFamily: "Montserrat",
                                              fontSize: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.01),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  flex: -1,
                                  child: InkWell(
                                    child: Icon(
                                      Icons.more_horiz,
                                      size: MediaQuery.of(context).size.height *
                                          0.03,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height * 0.22,
                              left: MediaQuery.of(context).size.height * 0.01,
                              right: MediaQuery.of(context).size.height * 0.01,
                              bottom: MediaQuery.of(context).size.height * 0.02,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  child: Text(
                                    InfoData.infoItems[widget.index].title,
                                    style: TextStyle(
                                      fontFamily: "Montserrat",
                                      fontSize:
                                          MediaQuery.of(context).size.height *
                                              0.016,
                                      fontWeight: FontWeight.bold,
                                      color: kTextColor,
                                    ),
                                  ),
                                ),
                                // InkWell(
                                //   child: Image.asset(
                                //     "assets/images/bookmark.png",
                                //     height: MediaQuery.of(context).size.height *
                                //         0.015,
                                //   ),
                                // ),
                              ],
                            ),
                          ),
                          Container(
                            width: double.infinity,
                            alignment: Alignment.center,
                            child: HtmlWidget(
                              InfoData.infoItems[widget.index].content,
                            ),
                            // child: Html(
                            //   data: InfoData.infoItems[widget.index].content,
                            //   style: {
                            //     "body": Style(
                            //       fontFamily: "Montserrat",
                            //       fontSize: FontSize(11),
                            //       alignment: Alignment.topLeft,
                            //       wordSpacing: 1.5,
                            //     ),
                            //     "ul": Style(
                            //       margin: EdgeInsets.all(0),
                            //       padding: EdgeInsets.all(0),
                            //     ),
                            //     "li": Style(
                            //       margin: EdgeInsets.all(0),
                            //       padding: EdgeInsets.all(0),
                            //     )
                            //   },
                            // ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        maxHeight: MediaQuery.of(context).size.height,
                        maxWidth: MediaQuery.of(context).size.width,
                      ),
                      child: Container(
                        margin: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.04,
                          right: MediaQuery.of(context).size.height * 0.04,
                          left: MediaQuery.of(context).size.height * 0.04,
                        ),
                        height: MediaQuery.of(context).size.height * 0.2,
                        width: MediaQuery.of(context).size.width,
                        // decoration: BoxDecoration(
                        //   color: Colors.white,
                        //   borderRadius: BorderRadius.circular(10),
                        // ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: Image(
                            image: NetworkImage(
                              InfoData.infoItems[widget.index].filePath,
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }
}
