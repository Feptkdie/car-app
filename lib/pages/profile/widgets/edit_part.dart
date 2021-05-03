import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';

class EditPart extends StatefulWidget {
  static String routeName = "/edit_part";
  @override
  _EditPartState createState() => _EditPartState();
}

class _EditPartState extends State<EditPart> {
  final partNameTEC = new TextEditingController();
  final partStartAtTEC = new TextEditingController();
  final partFixAtTEC = new TextEditingController();
  final commentTEC = new TextEditingController();
  bool _isLoad = true;
  @override
  void initState() {
    partNameTEC.text = "Авто тосол";
    partStartAtTEC.text = "Sep 14, 2020";
    partFixAtTEC.text = "Feb 6, 2021";
    commentTEC.text = "85000 төгрөгөнд солисон";
    setState(() {
      _isLoad = false;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: kBackColor2,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: new LinearGradient(
                colors: [
                  kBackColor1,
                  kBackColor2,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                _top(height),
                if (_isLoad)
                  Container(
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
                if (!_isLoad) _info(height, width),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _info(double height, double width) => Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(
              top: height * 0.04,
              left: width * 0.06,
              right: width * 0.06,
              bottom: height * 0.02,
            ),
            child: Column(
              children: <Widget>[
                TextField(
                  decoration: InputDecoration(
                    isDense: true,
                    labelText: "Эд ангийн нэр",
                    labelStyle: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                  controller: partNameTEC,
                ),
                SizedBox(
                  height: height * 0.012,
                ),
                TextField(
                  decoration: InputDecoration(
                    isDense: true,
                    labelText: "Авсан он сар",
                    labelStyle: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                  controller: partStartAtTEC,
                ),
                SizedBox(
                  height: height * 0.012,
                ),
                TextField(
                  decoration: InputDecoration(
                    isDense: true,
                    labelText: "Солисон он сар",
                    labelStyle: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                  keyboardType: TextInputType.phone,
                  controller: partFixAtTEC,
                ),
                SizedBox(
                  height: height * 0.012,
                ),
                TextField(
                  decoration: InputDecoration(
                    isDense: true,
                    labelText: "Нэмэлт мэдээлэл",
                    labelStyle: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                  controller: commentTEC,
                ),
                SizedBox(
                  height: height * 0.04,
                ),
              ],
            ),
          ),
        ],
      );

  Widget _top(double height) => Container(
        width: double.infinity,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(
                right: height * 0.028,
                top: height * 0.006,
                bottom: height * 0.006,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(
                          8.0,
                        ),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop(context);
                          },
                          child: Theme.of(context).platform ==
                                  TargetPlatform.iOS
                              ? Padding(
                                  padding: EdgeInsets.only(
                                    left: MediaQuery.of(context).size.height *
                                        0.01,
                                  ),
                                  child: Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.045,
                                    width: MediaQuery.of(context).size.height *
                                        0.045,
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
                                    left: MediaQuery.of(context).size.height *
                                        0.01,
                                  ),
                                  child: Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.045,
                                    width: MediaQuery.of(context).size.height *
                                        0.045,
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
                      SizedBox(
                        width: 8.0,
                      ),
                      Text(
                        "Эд анги засах",
                        style: TextStyle(
                          color: kTextGrey,
                          fontWeight: FontWeight.bold,
                          fontSize: height * 0.028,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(height * 0.2),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black87,
                              blurRadius: 4,
                              offset: Offset(2, 2),
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(height * 0.2),
                          child: Material(
                            color: kTextGrey,
                            child: InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              splashColor: Colors.white,
                              child: Container(
                                height: height * 0.045,
                                width: height * 0.045,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                    height * 0.2,
                                  ),
                                  border: Border.all(
                                    width: 2,
                                    color: Colors.white.withOpacity(0.9),
                                  ),
                                ),
                                child: Center(
                                  child: Icon(
                                    Icons.done,
                                    color: Colors.white,
                                    size: height * 0.022,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      );
}
