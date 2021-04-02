import 'package:carpro/widget/search_btn.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
// import 'package:gradient_widgets/gradient_widgets.dart';

class NewsScreen extends StatefulWidget {
  @override
  _NewsScreenState createState() => _NewsScreenState();
}

DateTime now = DateTime.now();

class _NewsScreenState extends State<NewsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.grey,
      //   title: Text("Мэдээлэл"),
      // ),
      backgroundColor: Color(0xffd0d3d5),
      body: Column(
        children: <Widget>[
          Padding(
            padding:
                EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.05),
            child: Row(
              children: [
                Theme.of(context).platform == TargetPlatform.iOS
                    ? Padding(
                        padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.height * 0.01),
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.045,
                          width: MediaQuery.of(context).size.height * 0.045,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(colors: [
                              Colors.red[500],
                              Colors.red[900],
                            ]),
                          ),
                          child: CupertinoButton(
                              color: Colors.transparent,
                              // borderRadius: BorderRadius.circular(40),
                              child: Icon(
                                Icons.arrow_back_ios,
                                color: Colors.white,
                              ),
                              onPressed: () {}),
                        ),
                      )
                    : Padding(
                        padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.height * 0.01),
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.045,
                          width: MediaQuery.of(context).size.height * 0.045,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: LinearGradient(colors: [
                                Colors.red[500],
                                Colors.red[900],
                              ]),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black87,
                                  blurRadius: 7,
                                  offset: Offset(2, 2), // Shadow position
                                ),
                              ]),
                          child: Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                          ),
                        ),
                      ),
                Padding(
                  padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.height * 0.015),
                  child: Text(
                    "Мэдээ",
                    style: TextStyle(
                        fontFamily: "Montserrat",
                        fontSize: MediaQuery.of(context).size.height * 0.026,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[800]),
                  ),
                ),
                SearchBtn(
                  searchText: "Хайлтын түлхүүр үг",
                )
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(top: 8.0),
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
                              bottom:
                                  MediaQuery.of(context).size.height * 0.02),
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
                        Align(
                          alignment: Alignment.center,
                          child: ConstrainedBox(
                            constraints: BoxConstraints(
                              maxHeight:
                                  MediaQuery.of(context).size.height * 0.25,
                              maxWidth:
                                  MediaQuery.of(context).size.height * 0.5,
                            ),
                            child: Container(
                              margin: EdgeInsets.only(
                                  top: MediaQuery.of(context).size.height *
                                      0.05),
                              height: MediaQuery.of(context).size.height * 0.17,
                              width: MediaQuery.of(context).size.height * 0.4,
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
                        Column(
                          children: [
                            ListTile(
                              contentPadding: EdgeInsets.only(
                                left:
                                    MediaQuery.of(context).size.height * 0.032,
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
                                      size: MediaQuery.of(context).size.height *
                                          0.02,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 8.0),
                                    child: Text(
                                      DateFormat('m').format(now) + "мин",
                                      style: TextStyle(
                                          fontFamily: "Montserrat",
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.016),
                                    ),
                                  ),
                                ],
                              ),
                              trailing: InkWell(
                                child: Padding(
                                  padding: EdgeInsets.only(
                                    right: MediaQuery.of(context).size.height *
                                        0.05,
                                  ),
                                  child: Icon(Icons.more_horiz),
                                ),
                              ),
                            ),
                            ListTile(
                              contentPadding: EdgeInsets.only(
                                top: MediaQuery.of(context).size.height * 0.13,
                                left: MediaQuery.of(context).size.height * 0.05,
                                right:
                                    MediaQuery.of(context).size.height * 0.05,
                              ),
                              title: Text(
                                "Авто лизингийн хүү  0,1% боллоо",
                                style: TextStyle(
                                  fontFamily: "Montserrat",
                                  fontSize: MediaQuery.of(context).size.height *
                                      0.018,
                                ),
                              ),
                              subtitle: Text(
                                "Үргэлжлүүлэн унших",
                                style: TextStyle(
                                  fontFamily: "Montserrat",
                                  fontSize: MediaQuery.of(context).size.height *
                                      0.014,
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
                  }),
            ),
          )
        ],
      ),
    );
  }
}
