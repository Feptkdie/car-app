import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import '../constants.dart';

class SearchBtn extends StatefulWidget {
  final String searchText;
  SearchBtn({this.searchText});
  @override
  _SearchBtnState createState() => _SearchBtnState();
}

class _SearchBtnState extends State<SearchBtn> {
  TextEditingController _controller = TextEditingController();

  StreamController _streamController;

  Stream stream;

  Timer _debounce;

  _search() async {
    if (_controller.text == null || _controller.text.length == 0) {
      _streamController.add(null);
      return;
    }

    _streamController.add("waiting");
    // Response response = await get(_url + _controller.text.trim(), headers: {"Authorization": "Token " + _token});
    // _streamController.add(json.decode(response.body));
  }

  @override
  void initState() {
    _streamController = StreamController();
    stream = _streamController.stream;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: MediaQuery.of(context).size.height * 0.05,
        right: MediaQuery.of(context).size.height * 0.015,
      ),
      child: Neumorphic(
        style: NeumorphicStyle(
          //   border: NeumorphicBorder(
          // color: Color(0x33000000),
          // width: 0.8,),
          depth: -4,
          shadowLightColorEmboss: kLightColor,
          shadowDarkColorEmboss: kGreyColor,
          color: Color(0xffc1c4c7),
          boxShape: NeumorphicBoxShape.roundRect(
            BorderRadius.circular(20),
          ),
          intensity: 0.8,
        ),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.06,
            // maxWidth: MediaQuery.of(context).size.height * 0.3,
          ),
          child: TextFormField(
            textAlign: TextAlign.start,
            onChanged: (String text) {
              if (_debounce?.isActive ?? false) _debounce.cancel();
              _debounce = Timer(const Duration(milliseconds: 1000), () {
                _search();
              });
            },
            controller: _controller,
            decoration: InputDecoration(
              hintText: widget.searchText,
              contentPadding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.009),
              hintStyle: TextStyle(
                fontFamily: "Montserrat",
                fontSize: MediaQuery.of(context).size.height * 0.016,
                color: Colors.grey[600],
              ),
              border: InputBorder.none,
              // icon: IconButton(
              //   icon: Icon(
              //     Icons.search,
              //     color: Colors.grey[600],
              //   ),
              //   onPressed: () {
              //     print("clicked");
              //   },
              // ),
              prefixIcon: IconButton(
                icon: Icon(
                  Icons.search,
                  color: Colors.grey[600],
                  size: MediaQuery.of(context).size.height * 0.04,
                ),
                onPressed: () {
                  print("clicked");
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
