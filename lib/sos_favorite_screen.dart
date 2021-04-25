import 'package:carpro/constants.dart';
import 'package:carpro/model/sos_fav_item.dart';
import 'package:carpro/model/sos_item.dart';
import 'package:carpro/widget/sos_alert_profile.dart';
import 'package:carpro/widget/sos_cancel_btn.dart';
import 'package:carpro/widget/sos_edit_icon.dart';
import 'package:carpro/widget/sos_textField.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import 'widget/appBar_title.dart';
import 'widget/arrow_button.dart';
import 'widget/profile.dart';
import 'widget/search_btn.dart';

class FavoriteScreen extends StatefulWidget {
  @override
  _FavoriteScreenState createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext ctx) {
    Future<void> _showMyDialog() async {
      return showDialog<void>(
        context: ctx,
        builder: (BuildContext ctx) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            child: Container(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(ctx).size.height * 0.01),
              decoration: new BoxDecoration(
                gradient: new LinearGradient(
                  colors: [
                    kLightColor,
                    Colors.grey[400],
                  ],
                ),
                borderRadius: BorderRadius.circular(5),
              ),
              child: SingleChildScrollView(
                child: Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    SosAlertPro(),
                    SosEditIcon(),
                    SosCancelBtn(),
                    SosTextField(),
                  ],
                ),
              ),
            ),
          );
        },
      );
    }

    return Scaffold(
      backgroundColor: kPrimaryColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(MediaQuery.of(ctx).size.height * 0.1),
        child: Padding(
          padding: EdgeInsets.only(
            top: MediaQuery.of(ctx).size.height * 0.05,
            bottom: MediaQuery.of(ctx).size.height * 0.02,
          ),
          child: Row(
            children: [
              ArrowButton(),
              AppBarTitle(title: "SOS"),
              Expanded(
                child: SearchBtn(
                  searchText: "Хайлтын түлхүүр үг",
                ),
              ),
              Profile(),
            ],
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _textWidget(ctx),
          Container(
            height: MediaQuery.of(ctx).size.height * 0.06,
            width: MediaQuery.of(ctx).size.width,
            margin: EdgeInsets.only(
              bottom: MediaQuery.of(ctx).size.height * 0.04,
              left: MediaQuery.of(ctx).size.height * 0.01,
            ),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: cardItem.length,
              itemBuilder: (BuildContext ctx, int i) {
                return _favoriteList(ctx, i);
              },
            ),
          ),
          _cardList(ctx),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        onPressed: () {
          _showMyDialog();
        },
        child: Image.asset(
          "assets/add_button.png",
          height: MediaQuery.of(ctx).size.height * 0.05,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget _textWidget(BuildContext ctx) {
    return Padding(
      padding: EdgeInsets.only(
        top: MediaQuery.of(ctx).size.height * 0.02,
        left: MediaQuery.of(ctx).size.height * 0.025,
        bottom: MediaQuery.of(ctx).size.height * 0.03,
      ),
      child: Text(
        "Миний хадгалсан",
        style: TextStyle(
          fontSize: MediaQuery.of(ctx).size.height * 0.016,
          fontFamily: "Montserrat",
          color: kTextColor,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _favoriteList(BuildContext ctx, int i) {
    return Padding(
      padding: EdgeInsets.only(
        left: MediaQuery.of(ctx).size.height * .01,
        top: MediaQuery.of(ctx).size.height * .008,
        bottom: MediaQuery.of(ctx).size.height * .008,
        right: MediaQuery.of(ctx).size.height * 0.01,
      ),
      child: Container(
        width: MediaQuery.of(ctx).size.height * 0.13,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.0),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                blurRadius: 3.0,
                spreadRadius: 1.0,
                color: Colors.grey.withOpacity(1),
                offset: Offset(0.5, 0.5),
              ),
            ]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(ctx).size.height * 0.012,
              ),
              child: Image.asset(
                cardItem[i].image,
                height: MediaQuery.of(ctx).size.height * 0.028,
                width: MediaQuery.of(ctx).size.height * 0.028,
              ),
            ),
            Flexible(
              child: Padding(
                padding: EdgeInsets.only(
                  right: MediaQuery.of(ctx).size.height * 0.01,
                ),
                child: Text(
                  cardItem[i].title,
                  style: TextStyle(
                    fontFamily: "Montserrat",
                    fontSize: MediaQuery.of(ctx).size.height * 0.011,
                    color: kTextColor,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _logoImage(BuildContext ctx) {
    return Container(
      height: MediaQuery.of(ctx).size.height * .12,
      width: MediaQuery.of(ctx).size.height * .09,
      margin: EdgeInsets.only(
        // top: MediaQuery.of(ctx).size.height * 0.005,
        left: MediaQuery.of(ctx).size.height * 0.01,
        right: MediaQuery.of(ctx).size.height * 0.02,
        // MediaQuery.of(ctx).size.height * 0.002,
      ),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Center(
        child: Text(
          "Logo",
          style: TextStyle(
            color: kTextColor,
            fontWeight: FontWeight.bold,
            // fontFamily: "Montserrat-Bold",
          ),
        ),
      ),
    );
  }

  Widget _cardList(BuildContext ctx) {
    return Expanded(
      child: ListView.builder(
        itemCount: favItem.length,
        itemBuilder: (BuildContext ctx, int i) {
          return
              // favItem.length > i
              // ?
              Padding(
            padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(ctx).size.height * 0.03,
              vertical: MediaQuery.of(ctx).size.height * 0.005,
            ),
            child: Card(
              elevation: 3.0,
              clipBehavior: Clip.antiAlias,
              child: Container(
                height: MediaQuery.of(ctx).size.height * 0.13,
                child: Row(
                  children: [
                    _logoImage(ctx),
                    Expanded(
                      flex: 2,
                      child: Container(
                        padding: EdgeInsets.only(
                            top: MediaQuery.of(ctx).size.height * 0.01),
                        child: Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  favItem[i].title,
                                  style: TextStyle(
                                    fontFamily: "Montserrat",
                                    fontWeight: FontWeight.bold,
                                    color: kTextColor,
                                    fontSize:
                                        MediaQuery.of(ctx).size.height * 0.018,
                                  ),
                                ),
                                Text(
                                  favItem[i].description,
                                  style: TextStyle(
                                    fontFamily: "Montserrat",
                                    fontSize:
                                        MediaQuery.of(ctx).size.height * 0.011,
                                    color: kTextColor,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 4.0),
                                  child: Text(
                                    "+ 976 88118811",
                                    style: TextStyle(
                                      fontFamily: "Montserrat",
                                      fontSize: MediaQuery.of(ctx).size.height *
                                          0.013,
                                      color: kTextColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 6.0),
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(right: 5.0),
                                        child: Image.asset(
                                          "assets/pin.png",
                                          height:
                                              MediaQuery.of(ctx).size.height *
                                                  0.015,
                                        ),
                                      ),
                                      Text(
                                        "Баянгол дүүрэг 5-р хороо, 7-р байр",
                                        style: TextStyle(
                                          color: kTextColor,
                                          fontFamily: "Montserrat",
                                          fontSize:
                                              MediaQuery.of(ctx).size.height *
                                                  0.012,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                    top: 6.0,
                                    bottom:
                                        MediaQuery.of(ctx).size.height * 0.01,
                                  ),
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(right: 5.0),
                                        child: Image.asset(
                                          "assets/clock.png",
                                          height:
                                              MediaQuery.of(ctx).size.height *
                                                  0.015,
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(right: 2.0),
                                        child: Text(
                                          "24",
                                          style: TextStyle(
                                            color: kLightRed,
                                            fontFamily: "Montserrat",
                                            fontSize:
                                                MediaQuery.of(ctx).size.height *
                                                    0.012,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      Text(
                                        "цаг нээлттэй",
                                        style: TextStyle(
                                          color: kTextColor,
                                          fontFamily: "Montserrat",
                                          fontSize:
                                              MediaQuery.of(ctx).size.height *
                                                  0.012,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          InkWell(
                            onTap: () => {
                              print("clicked"),
                            },
                            child: Padding(
                              padding: EdgeInsets.only(
                                  right: MediaQuery.of(ctx).size.height * 0.015,
                                  top: MediaQuery.of(ctx).size.height * 0.01),
                              child: Icon(
                                Icons.star_border_outlined,
                                color: Colors.grey,
                                size: MediaQuery.of(ctx).size.height * 0.025,
                              ),
                            ),
                          ),
                          Container(
                            height: MediaQuery.of(ctx).size.height * 0.03,
                            width: MediaQuery.of(ctx).size.height * 0.085,
                            margin: EdgeInsets.only(
                                right: MediaQuery.of(ctx).size.height * 0.015,
                                bottom: MediaQuery.of(ctx).size.height * 0.01),
                            decoration: BoxDecoration(
                                color: Colors.greenAccent[400],
                                borderRadius: BorderRadius.circular(4.0)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Icon(
                                  Icons.call,
                                  color: Colors.white,
                                  size: MediaQuery.of(ctx).size.height * 0.02,
                                ),
                                Text(
                                  "Залгах",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: "Monstserrat",
                                    fontSize:
                                        MediaQuery.of(ctx).size.height * 0.012,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
          // : Center(
          //     child: GestureDetector(
          //       child: Image.asset(
          //         "assets/add_button.png",
          //         height: MediaQuery.of(ctx).size.height * 0.05,
          //       ),
          //     ),
          //   );
        },
      ),
    );
  }
}
