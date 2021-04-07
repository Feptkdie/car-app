import 'package:carpro/search_btn.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NewsAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).size.height * 0.05,
        bottom: MediaQuery.of(context).size.height * 0.02,
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.of(context).pop(context);
            },
            child: Theme.of(context).platform == TargetPlatform.iOS
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
          Expanded(
            child: SearchBtn(
              searchText: "Хайлтын түлхүүр үг",
            ),
          )
        ],
      ),
    );
  }
}
