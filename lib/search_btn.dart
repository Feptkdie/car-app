import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

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
        left: MediaQuery.of(context).size.height * 0.02,
        right: MediaQuery.of(context).size.height * 0.015,
      ),
      child: Container(
        child: Neumorphic(
          style: NeumorphicStyle(
            //   border: NeumorphicBorder(
            // color: Color(0x33000000),
            // width: 0.8,),
            depth: -2,
            shadowLightColorEmboss: Colors.white,
            shadowDarkColorEmboss: Colors.grey,
            color: Color(0xffc1c4c7),
            boxShape: NeumorphicBoxShape.roundRect(
              BorderRadius.circular(20),
            ),
          ),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.06,
              // maxWidth: MediaQuery.of(context).size.height * 0.3,
            ),
            child: Container(
              // width: MediaQuery.of(context).size.height * 0.1,
              // height: MediaQuery.of(context).size.height * 0.06,
              child: TextFormField(
                onChanged: (String text) {
                  if (_debounce?.isActive ?? false) _debounce.cancel();
                  _debounce = Timer(const Duration(milliseconds: 1000), () {
                    _search();
                  });
                },
                controller: _controller,
                decoration: InputDecoration(
                  hintText: widget.searchText,
                  // hintTextDirection: TextDirection.ltr,
                  contentPadding: EdgeInsets.all(
                      MediaQuery.of(context).size.height * 0.009),
                  hintStyle: TextStyle(
                    fontFamily: "Montserrat",
                    fontSize: MediaQuery.of(context).size.height * 0.018,
                    color: Colors.grey[600],
                  ),
                  border: InputBorder.none,
                  prefixIcon: IconButton(
                    icon: Icon(
                      Icons.search,
                      color: Colors.grey[600],
                    ),
                    onPressed: () {
                      print("clicked");
                    },
                  ),
                  // prefixStyle:
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
