import 'package:cached_network_image/cached_network_image.dart';
import 'package:carpro_app/models/sos.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../constants.dart';

class SosItem extends StatelessWidget {
  final int index;
  final String categoryName;
  final Sos item;

  const SosItem({
    Key key,
    this.index,
    this.categoryName,
    this.item,
  }) : super(key: key);

  void _launchURL(_url) async => await canLaunch('tel:$_url')
      ? await launch('tel:$_url')
      : throw 'Could not launch $_url';

  @override
  Widget build(BuildContext context) {
    print("item: ${item.image}");

    return Container(
      width: double.infinity,
      height: 160.0,
      child: Card(
        margin: EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        elevation: 6.0,
        shadowColor: Colors.grey.withOpacity(0.5),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              width: 80.0,
              height: double.infinity,
              margin: EdgeInsets.all(8.0),
              child: ClipRRect(
                borderRadius: BorderRadius.all(
                  Radius.circular(10.0),
                ),
                child: Image.network(
                  item.image,
                  // fit: BoxFit.cover,
                ),
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      item.title,
                      style: TextStyle(
                        fontSize: 14.0,
                        fontFamily: "Montserrat",
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                    ),
                    SizedBox(height: 3.0),
                    Text(
                      this.categoryName,
                      style: TextStyle(
                        fontSize: 9.0,
                        fontFamily: "MontserratLight",
                      ),
                    ),
                    SizedBox(height: 5.0),
                    Text(
                      "+976 ${item.phone}",
                      style: TextStyle(
                        fontSize: 13.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Montserrat",
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      children: <Widget>[
                        Image.asset(
                          "assets/images/pin.png",
                          width: 12.0,
                        ),
                        SizedBox(
                          width: 5.0,
                        ),
                        Flexible(
                          child: Text(
                            item.address,
                            style: TextStyle(fontSize: 10.0),
                            maxLines: 2,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 5.0),
                    Row(
                      children: <Widget>[
                        Image.asset(
                          "assets/images/clock.png",
                          width: 12.0,
                        ),
                        SizedBox(
                          width: 5.0,
                        ),
                        Text(
                          "24",
                          style: TextStyle(
                            fontSize: 11.0,
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          " цаг нээлттэй",
                          style: TextStyle(fontSize: 10.0),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Container(
              // width: 100.0,
              // color: Colors.yellow,
              height: double.infinity,
              padding: EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  InkWell(
                    customBorder: CircleBorder(),
                    child: Padding(
                      padding: EdgeInsets.all(5.0),
                      child: Icon(
                        Icons.star,
                        color: kColor1,
                      ),
                    ),
                    onTap: () {
                      Flushbar(
                        margin: EdgeInsets.all(8),
                        borderRadius: 8,
                        message: "Saved item!",
                        duration: Duration(seconds: 4),
                        icon: Icon(
                          Icons.info_outline,
                          size: 28.0,
                          color: Colors.blue[300],
                        ),
                      )..show(context);
                    },
                  ),
                  Spacer(),
                  InkWell(
                    customBorder: CircleBorder(),
                    child: Padding(
                      padding: EdgeInsets.all(5.0),
                      child: Icon(
                        Icons.phone,
                        color: Color(0xFF1ce21b),
                        size: 20.0,
                      ),
                    ),
                    onTap: () {
                      _launchURL(item.phone);
                      print("onTapped!");
                    },
                  ),
                  // Container(
                  //   height: 30.0,
                  //   width: 80.0,
                  //   child: RaisedButton(
                  //     padding:
                  //         EdgeInsets.symmetric(horizontal: 5.0, vertical: 0.0),
                  //     color: Color(0xFF1ce21b),
                  //     onPressed: () {
                  //       print("onPressed!");
                  //     },
                  //     child: Row(
                  //       crossAxisAlignment: CrossAxisAlignment.center,
                  //       mainAxisAlignment: MainAxisAlignment.center,
                  //       children: <Widget>[
                  //         Icon(
                  //           Icons.phone,
                  //           color: Colors.white,
                  //           size: 15.0,
                  //         ),
                  //         SizedBox(width: 5.0),
                  //         Text(
                  //           "Залгах",
                  //           style: TextStyle(
                  //             color: Colors.white,
                  //             fontSize: 13.0,
                  //           ),
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
