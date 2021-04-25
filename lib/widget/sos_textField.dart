import 'package:flutter/material.dart';

import '../constants.dart';

class SosTextField extends StatefulWidget {
  @override
  _SosTextFieldState createState() => _SosTextFieldState();
}

var _currencies = [
  "Food",
  "Transport",
  "Personal",
  "Shopping",
  "Medical",
  "Rent",
  "Movie",
  "Salary"
];
var _district = [
  "Сүхбаатар",
  "Чингэлтэй",
  "Баянзүрх",
  "Баянгол",
  "Хан-Уул",
  "Сонгоно-Хайрхан"
];
String _dropDownValue;
String _dropDownDistrictValue;

class _SosTextFieldState extends State<SosTextField> {
  TextEditingController _controller;

  @override
  Widget build(BuildContext ctx) {
    return Padding(
      padding: EdgeInsets.only(
        top: MediaQuery.of(ctx).size.height * 0.18,
        left: MediaQuery.of(ctx).size.height * 0.02,
        right: MediaQuery.of(ctx).size.height * 0.02,
        bottom: MediaQuery.of(ctx).size.height * 0.02,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
            ),
            padding: EdgeInsets.only(
              left: 10,
              right: 10,
            ),
            margin: EdgeInsets.only(
              bottom: 10,
            ),
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                hintText: 'Нэр',
                hintStyle: TextStyle(
                  color: kTextColor,
                  fontFamily: "Montserrat",
                  fontSize: MediaQuery.of(ctx).size.height * 0.02,
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              bottom: 10,
            ),
            width: double.infinity,
            padding: EdgeInsets.only(left: 10, right: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                iconSize: MediaQuery.of(ctx).size.height * 0.055,
                hint: _dropDownValue == null
                    ? Text(
                        'Төрөл',
                        style: TextStyle(
                            color: kTextColor,
                            fontFamily: "Montserrat",
                            fontSize: MediaQuery.of(ctx).size.height * 0.02),
                      )
                    : Text(
                        _dropDownValue,
                        style: TextStyle(
                            color: kTextColor,
                            fontFamily: "Montserrat",
                            fontSize: MediaQuery.of(ctx).size.height * 0.02,
                            fontWeight: FontWeight.bold),
                      ),
                items: _currencies.map((String value) {
                  return DropdownMenuItem(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(
                    () {
                      _dropDownValue = value;
                    },
                  );
                },
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              bottom: 10,
            ),
            padding: EdgeInsets.only(left: 10, right: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
            ),
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                hintText: 'Утасны дугаар',
                hintStyle: TextStyle(
                  color: kTextColor,
                  fontFamily: "Montserrat",
                  fontSize: MediaQuery.of(ctx).size.height * 0.02,
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              bottom: 10,
            ),
            width: double.infinity,
            padding: EdgeInsets.only(left: 10, right: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                iconSize: MediaQuery.of(ctx).size.height * 0.055,
                hint: _dropDownDistrictValue == null
                    ? Text(
                        'Дүүрэг',
                        style: TextStyle(
                          color: kTextColor,
                          fontFamily: "Montserrat",
                          fontSize: MediaQuery.of(ctx).size.height * 0.02,
                        ),
                      )
                    : Text(
                        _dropDownDistrictValue,
                        style: TextStyle(
                            color: kTextColor,
                            fontFamily: "Montserrat",
                            fontSize: MediaQuery.of(ctx).size.height * 0.02,
                            fontWeight: FontWeight.bold),
                      ),
                items: _district.map((String value) {
                  return DropdownMenuItem(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(
                    () {
                      _dropDownDistrictValue = value;
                    },
                  );
                },
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              bottom: 10,
            ),
            padding: EdgeInsets.only(left: 10, right: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
            ),
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                hintText: 'Хороо',
                hintStyle: TextStyle(
                  color: kTextColor,
                  fontFamily: "Montserrat",
                  fontSize: MediaQuery.of(ctx).size.height * 0.02,
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              bottom: 10,
            ),
            padding: EdgeInsets.only(left: 10, right: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
            ),
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                hintText: 'Байр, тоот',
                hintStyle: TextStyle(
                  color: kTextColor,
                  fontFamily: "Montserrat",
                  fontSize: MediaQuery.of(ctx).size.height * 0.02,
                ),
              ),
            ),
          ),
          Container(
            height: MediaQuery.of(ctx).size.height * 0.06,
            width: MediaQuery.of(ctx).size.height * 0.3,
            margin:
                EdgeInsets.only(top: MediaQuery.of(ctx).size.height * 0.025),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  kLightRed,
                  kRedColor,
                ],
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Center(
              child: Text(
                "Хадгалах",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: "Montserrat",
                    fontSize: MediaQuery.of(ctx).size.height * 0.02,
                    color: Colors.white),
              ),
            ),
          )
        ],
      ),
    );
  }
}
