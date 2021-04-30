import 'package:flutter/material.dart';

class CarFitlers extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: <Widget>[
          Icon(Icons.filter),
          Text("slider"),
        ],
      ),
    );
  }
}
