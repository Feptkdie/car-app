import 'dart:async';

import 'package:flutter/material.dart';

import '../../../constants.dart';

class MenuButtons extends StatefulWidget {
  final double height;
  final double width;

  const MenuButtons({
    Key key,
    this.height,
    this.width,
  }) : super(key: key);
  @override
  _MenuButtonsState createState() => _MenuButtonsState();
}

class _MenuButtonsState extends State<MenuButtons> {
  Timer _timer;
  bool _mapBtn = false,
      _infosBtn = false,
      _shopBtn = false,
      _profileBtn = false,
      _sosBtn = false;

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: InkWell(
            onTap: () {
              print("blocked");
            },
            child: Container(
              height: widget.height * 0.5,
              width: widget.width * 0.34,
            ),
          ),
        ),
        Align(
          alignment: Alignment.topRight,
          child: InkWell(
            onTap: () {
              print("blocked");
            },
            child: Container(
              height: widget.height * 0.5,
              width: widget.width * 0.34,
            ),
          ),
        ),
        Align(
          alignment: Alignment.topCenter,
          child: InkWell(
            onTap: () {
              print("blocked");
            },
            child: Container(
              height: widget.height * 0.16,
              width: widget.width,
            ),
          ),
        ),
        Align(
          alignment: Alignment.center,
          child: Padding(
            padding: EdgeInsets.only(bottom: widget.height * 0.1),
            child: Container(
              height: widget.height * 0.14,
              width: widget.width,
            ),
          ),
        ),
        Align(
          alignment: Alignment.topCenter,
          child: Container(
            child: AnimatedCrossFade(
              duration: Duration(milliseconds: 200),
              crossFadeState: _mapBtn
                  ? CrossFadeState.showSecond
                  : CrossFadeState.showFirst,
              firstChild: Padding(
                padding: EdgeInsets.only(
                  top: widget.height * 0.03,
                ),
                child: InkWell(
                  onTap: () {
                    setState(() {
                      if (_mapBtn)
                        _mapBtn = false;
                      else
                        _mapBtn = true;
                    });
                    _timer = new Timer(const Duration(milliseconds: 100), () {
                      setState(() {
                        _mapBtn = false;
                      });
                      Navigator.pushNamed(context, "/map");
                    });
                  },
                  child: Container(
                    width: widget.width * 0.3,
                    height: widget.height * 0.13,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: widget.width * 0.1,
                          height: widget.height * 0.07,
                          child: Image.asset("assets/images/home_map.png"),
                        ),
                        Text(
                          "Байршил",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: kTextGrey,
                            fontSize: 16.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              secondChild: Padding(
                padding: EdgeInsets.only(
                  top: widget.height * 0.03,
                ),
                child: Container(
                  width: widget.width * 0.3,
                  height: widget.height * 0.13,
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: widget.width * 0.1,
                              height: widget.height * 0.07,
                              child: Image.asset("assets/images/home_map.png"),
                            ),
                            Text(
                              "Байршил",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: kTextGrey,
                                fontSize: 14.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Opacity(
                          opacity: 0.5,
                          child: Container(
                            width: widget.width * 0.3,
                            height: widget.height * 0.14,
                            child: Image.asset(
                              "assets/images/button_click.png",
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.topCenter,
          child: AnimatedCrossFade(
            duration: Duration(milliseconds: 200),
            crossFadeState:
                _sosBtn ? CrossFadeState.showSecond : CrossFadeState.showFirst,
            firstChild: Padding(
              padding: EdgeInsets.only(
                top: widget.height * 0.16,
                right: MediaQuery.of(context).size.height * 0.34,
              ),
              child: InkWell(
                onTap: () {
                  setState(() {
                    if (_sosBtn)
                      _sosBtn = false;
                    else
                      _sosBtn = true;
                  });
                  _timer = new Timer(const Duration(milliseconds: 100), () {
                    setState(() {
                      _sosBtn = false;
                    });
                    Navigator.pushNamed(context, "/sos_fav");
                  });
                },
                child: Container(
                  width: widget.width * 0.22,
                  height: widget.height * 0.13,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: widget.width * 0.1,
                        height: widget.height * 0.07,
                        child: Image.asset("assets/images/home_sos.png"),
                      ),
                      Text(
                        "SOS",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: kTextGrey,
                          fontSize: 16.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            secondChild: Padding(
              padding: EdgeInsets.only(
                top: widget.height * 0.16,
                right: MediaQuery.of(context).size.height * 0.34,
              ),
              child: Container(
                width: widget.width * 0.22,
                height: widget.height * 0.13,
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: widget.width * 0.1,
                            height: widget.height * 0.07,
                            child: Image.asset("assets/images/home_sos.png"),
                          ),
                          Text(
                            "SOS",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: kTextGrey,
                              fontSize: 14.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Opacity(
                        opacity: 0.5,
                        child: Container(
                          width: widget.width * 0.22,
                          height: widget.height * 0.1,
                          child: Image.asset(
                            "assets/images/button_click.png",
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.topCenter,
          child: Padding(
            padding: EdgeInsets.only(
              top: widget.height * 0.16,
              left: MediaQuery.of(context).size.height * 0.35,
            ),
            child: AnimatedCrossFade(
              duration: Duration(milliseconds: 200),
              crossFadeState: _infosBtn
                  ? CrossFadeState.showSecond
                  : CrossFadeState.showFirst,
              firstChild: InkWell(
                onTap: () {
                  setState(() {
                    if (_infosBtn)
                      _infosBtn = false;
                    else
                      _infosBtn = true;
                  });
                  _timer = new Timer(const Duration(milliseconds: 100), () {
                    setState(() {
                      _infosBtn = false;
                    });
                    Navigator.pushNamed(context, "/infos");
                  });
                },
                child: Container(
                  width: widget.width * 0.22,
                  height: widget.height * 0.13,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: widget.width * 0.1,
                        height: widget.height * 0.07,
                        child: Image.asset("assets/images/home_info.png"),
                      ),
                      Text(
                        "Мэдээ",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: kTextGrey,
                          fontSize: 16.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              secondChild: Container(
                width: widget.width * 0.22,
                height: widget.height * 0.13,
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: widget.width * 0.1,
                            height: widget.height * 0.07,
                            child: Image.asset("assets/images/home_info.png"),
                          ),
                          Text(
                            "Мэдээ",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: kTextGrey,
                              fontSize: 14.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Opacity(
                        opacity: 0.5,
                        child: Container(
                          width: widget.width * 0.22,
                          height: widget.height * 0.1,
                          child: Image.asset(
                            "assets/images/button_click.png",
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.topCenter,
          child: Padding(
            padding: EdgeInsets.only(
              top: widget.height * 0.35,
              right: MediaQuery.of(context).size.height * 0.24,
            ),
            child: AnimatedCrossFade(
              duration: Duration(milliseconds: 200),
              crossFadeState: _shopBtn
                  ? CrossFadeState.showSecond
                  : CrossFadeState.showFirst,
              firstChild: InkWell(
                onTap: () {
                  setState(() {
                    if (_shopBtn)
                      _shopBtn = false;
                    else
                      _shopBtn = true;
                  });
                  _timer = new Timer(const Duration(milliseconds: 100), () {
                    setState(() {
                      _shopBtn = false;
                    });
                    Navigator.pushNamed(context, "/cars");
                  });
                },
                child: Container(
                  width: widget.width * 0.22,
                  height: widget.height * 0.13,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: widget.width * 0.1,
                          height: widget.height * 0.07,
                          child: Image.asset("assets/images/home_shop.png"),
                        ),
                        Text(
                          "Худалдаа",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: kTextGrey,
                            fontSize: 16.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              secondChild: Container(
                width: widget.width * 0.22,
                height: widget.height * 0.13,
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: widget.width * 0.1,
                            height: widget.height * 0.07,
                            child: Image.asset("assets/images/home_shop.png"),
                          ),
                          Text(
                            "Худалдаа",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: kTextGrey,
                              fontSize: 14.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Opacity(
                        opacity: 0.5,
                        child: Container(
                          width: widget.width * 0.22,
                          height: widget.height * 0.1,
                          child: Image.asset(
                            "assets/images/button_click.png",
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.topCenter,
          child: Padding(
            padding: EdgeInsets.only(
              top: widget.height * 0.353,
              left: MediaQuery.of(context).size.height * 0.24,
            ),
            child: AnimatedCrossFade(
              duration: Duration(milliseconds: 200),
              crossFadeState: _profileBtn
                  ? CrossFadeState.showSecond
                  : CrossFadeState.showFirst,
              firstChild: InkWell(
                onTap: () {
                  setState(() {
                    if (_profileBtn)
                      _profileBtn = false;
                    else
                      _profileBtn = true;
                  });
                  _timer = new Timer(const Duration(milliseconds: 100), () {
                    setState(() {
                      _profileBtn = false;
                    });
                    Navigator.pushNamed(context, "/profile");
                  });
                },
                child: Container(
                  width: widget.width * 0.22,
                  height: widget.height * 0.13,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: widget.width * 0.1,
                        height: widget.height * 0.065,
                        child: Image.asset("assets/images/home_profile.png"),
                      ),
                      Text(
                        "Бүртгэл",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: kTextGrey,
                          fontSize: 16.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              secondChild: Container(
                width: widget.width * 0.22,
                height: widget.height * 0.13,
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: widget.width * 0.1,
                            height: widget.height * 0.065,
                            child:
                                Image.asset("assets/images/home_profile.png"),
                          ),
                          Text(
                            "Бүртгэл",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: kTextGrey,
                              fontSize: 14.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Opacity(
                        opacity: 0.5,
                        child: Container(
                          width: widget.width * 0.22,
                          height: widget.height * 0.1,
                          child: Image.asset(
                            "assets/images/button_click.png",
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
