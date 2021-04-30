import 'dart:async';
import 'dart:convert';

import 'package:carpro_app/models/info.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../constants.dart';
import 'info_detail.dart';

class InfoData {
  static List<Info> infoItems = [];
  static bool isLoad = true;
}

class InfoPage extends StatefulWidget {
  static String routeName = "/infos";
  @override
  _InfoPageState createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  List fetchData;

  @override
  void initState() {
    _onLoading();
    super.initState();
  }

  _onLoading() async {
    if (InfoData.isLoad) {
      var response = await http.get("http://bombigo.xyz/api/infos");

      if (response.statusCode == 200) {
        try {
          var body = json.decode(response.body);
          InfoData.infoItems.clear();
          final newsItem = json.encode(body["data"]);
          fetchData = json.decode(newsItem);
          fetchData.forEach((data) {
            Info userPhotosModel = Info(
              id: data["id"],
              title: data["title"].toString(),
              subtitle: data["subtitle"].toString(),
              fileMode: data["fileMode"].toString(),
              filePath: data["filePath"].toString(),
              content: data["content"].toString(),
              createdAt: data["createdAt"].toString(),
              categories: data["categories"] ?? [],
            );
            InfoData.infoItems.add(userPhotosModel);
          });
          setState(() {
            InfoData.isLoad = false;
          });
        } catch (e) {
          print("error=" + e.toString());
        }
      } else {
        setState(() {
          InfoData.isLoad = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color(0xffd0d3d5),
      body: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * 0.05,
              bottom: MediaQuery.of(context).size.height * 0.02,
            ),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(
                    8.0,
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
                              height:
                                  MediaQuery.of(context).size.height * 0.045,
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
                              height:
                                  MediaQuery.of(context).size.height * 0.045,
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
                // Expanded(
                //   child: Padding(
                //     padding: EdgeInsets.only(
                //       left: MediaQuery.of(context).size.height * 0.05,
                //       right: MediaQuery.of(context).size.height * 0.015,
                //     ),
                //     child: ConstrainedBox(
                //       constraints: BoxConstraints(
                //         maxHeight: MediaQuery.of(context).size.height * 0.06,
                //         // maxWidth: MediaQuery.of(context).size.height * 0.3,
                //       ),
                //       child: TextFormField(
                //         textAlign: TextAlign.start,
                //         onChanged: (String text) {
                //           if (_debounce?.isActive ?? false) _debounce.cancel();
                //           _debounce =
                //               Timer(const Duration(milliseconds: 1000), () {
                //             _search();
                //           });
                //         },
                //         controller: _controller,
                //         decoration: InputDecoration(
                //           hintText: "Хайлтын түлхүүр үг",
                //           contentPadding: EdgeInsets.only(
                //               top: MediaQuery.of(context).size.height * 0.009),
                //           hintStyle: TextStyle(
                //             fontFamily: "Montserrat",
                //             fontSize:
                //                 MediaQuery.of(context).size.height * 0.016,
                //             color: Colors.grey[600],
                //           ),
                //           border: InputBorder.none,
                //           // icon: IconButton(
                //           //   icon: Icon(
                //           //     Icons.search,
                //           //     color: Colors.grey[600],
                //           //   ),
                //           //   onPressed: () {
                //           //     print("clicked");
                //           //   },
                //           // ),
                //           prefixIcon: IconButton(
                //             icon: Icon(
                //               Icons.search,
                //               color: Colors.grey[600],
                //               size: MediaQuery.of(context).size.height * 0.04,
                //             ),
                //             onPressed: () {
                //               print("clicked");
                //             },
                //           ),
                //         ),
                //       ),
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
          if (InfoData.isLoad)
            Center(
              child: Container(
                height: height - height * 0.25,
                width: double.infinity,
                child: Center(
                  child: Container(
                    height: 15.0,
                    width: 15.0,
                    child: Center(
                      child: CircularProgressIndicator(
                        strokeWidth: 1.8,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          Colors.white.withOpacity(0.9),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          if (!InfoData.isLoad) _listView(context),
        ],
      ),
    );
  }

  Widget _listView(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: InfoData.infoItems.length,
        itemBuilder: (BuildContext context, int index) {
          return Column(
            children: [
              if (InfoData.infoItems[index].fileMode == "image")
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NewsDetailScreen(
                          index: index,
                        ),
                      ),
                    );
                  },
                  child: Stack(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height * 0.01,
                            left: MediaQuery.of(context).size.height * 0.03,
                            right: MediaQuery.of(context).size.height * 0.03,
                            bottom: MediaQuery.of(context).size.height * 0.02),
                        child: Card(
                          color: Colors.transparent,
                          elevation: 0.0,
                          child: ConstrainedBox(
                            constraints: BoxConstraints(
                              maxHeight:
                                  MediaQuery.of(context).size.height * 0.26,
                              // maxWidth: MediaQuery.of(context).size.height * 0.3,
                            ),
                            child: Column(
                              // mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal:
                                          MediaQuery.of(context).size.height *
                                              0.01),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: Row(
                                          children: [
                                            Image.asset(
                                              "assets/images/clock.png",
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.012,
                                            ),
                                            Padding(
                                              padding:
                                                  EdgeInsets.only(left: 5.0),
                                              child: Text(
                                                InfoData
                                                    .infoItems[index].createdAt
                                                    .substring(0, 10)
                                                    .toString(),
                                                style: TextStyle(
                                                    fontFamily: "Montserrat",
                                                    fontSize:
                                                        MediaQuery.of(context)
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
                                            size: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.03,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                    top: MediaQuery.of(context).size.height *
                                        0.18,
                                    left: MediaQuery.of(context).size.height *
                                        0.01,
                                    right: MediaQuery.of(context).size.height *
                                        0.01,
                                    bottom: MediaQuery.of(context).size.height *
                                        0.005,
                                  ),
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Flexible(
                                          child: Text(
                                            InfoData.infoItems[index].title,
                                            style: TextStyle(
                                              fontFamily: "Montserrat",
                                              fontSize: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.016,
                                              fontWeight: FontWeight.bold,
                                              color: kTextGrey,
                                            ),
                                            maxLines: 1,
                                          ),
                                        ),
                                        // InkWell(
                                        //   child:
                                        //       //  Icon(
                                        //       //   Icons.bookmark_border,
                                        //       //   size: MediaQuery.of(context).size.height * 0.03,
                                        //       // ),
                                        //       Image.asset(
                                        //     "assets/images/bookmark.png",
                                        //     height: MediaQuery.of(context)
                                        //             .size
                                        //             .height *
                                        //         0.015,
                                        //   ),
                                        // ),
                                      ]),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                    left: MediaQuery.of(context).size.height *
                                        0.01,
                                    right: MediaQuery.of(context).size.height *
                                        0.01,
                                  ),
                                  child: Text(
                                    "Үргэлжлүүлэн унших",
                                    style: TextStyle(
                                      fontFamily: "Montserrat",
                                      fontSize:
                                          MediaQuery.of(context).size.height *
                                              0.01,
                                    ),
                                  ),
                                ),
                              ],
                            ),
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
                              top: MediaQuery.of(context).size.height * 0.045,
                              right: MediaQuery.of(context).size.height * 0.04,
                              left: MediaQuery.of(context).size.height * 0.04,
                            ),
                            height: MediaQuery.of(context).size.height * 0.16,
                            width: MediaQuery.of(context).size.width / 1,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(5),
                              child: Image(
                                image: NetworkImage(
                                    InfoData.infoItems[index].filePath),
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
          );
        },
      ),
    );
  }
}
