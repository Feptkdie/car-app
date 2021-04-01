import 'package:flutter/material.dart';
import 'dart:async';
// import 'dart:convert';
// import 'package:http/http.dart';

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
    return Container(
      width: MediaQuery.of(context).size.height * 0.4,
      height: MediaQuery.of(context).size.height * 0.06,
      margin: EdgeInsets.only(
        left: MediaQuery.of(context).size.height * 0.02,
        right: MediaQuery.of(context).size.height * 0.02,
      ),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(20.0),
      ),
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
          contentPadding:
              EdgeInsets.all(MediaQuery.of(context).size.height * 0.009),
          hintStyle: TextStyle(
            fontFamily: "Montserrat",
            fontSize: MediaQuery.of(context).size.height * 0.022,
          ),
          border: InputBorder.none,
          // icon:
          // IconButton(
          //   icon: Icon(Icons.search),
          //   onPressed: () {
          //     print("clicked");
          //   },
          // ),
          prefixIcon: IconButton(
            icon: Icon(
              Icons.search,
              color: Colors.grey,
            ),
            onPressed: () {
              print("clicked");
            },
          ),
          // prefixStyle:
        ),
      ),
    );
  }
}
