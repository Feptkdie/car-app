import 'package:flutter/material.dart';

class SosEditIcon extends StatelessWidget {
  @override
  Widget build(BuildContext ctx) {
    return Positioned(
      top: MediaQuery.of(ctx).size.height * 0.05,
      right: MediaQuery.of(ctx).size.height * 0.17,
      // left: 20,
      child: InkWell(
        onTap: () {
          print("clicked");
        },
        child: Container(
          height: MediaQuery.of(ctx).size.height * 0.035,
          width: MediaQuery.of(ctx).size.height * 0.035,
          child: FloatingActionButton(
            backgroundColor: Colors.grey,
            onPressed: () {},
            child: Icon(
              Icons.edit,
              color: Colors.white,
              size: MediaQuery.of(ctx).size.height * 0.025,
            ),
          ),
        ),
      ),
    );
  }
}
