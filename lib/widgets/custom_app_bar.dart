import 'package:carpro_app/constants.dart';
import "package:flutter/material.dart";

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double height;
  final String title;

  const CustomAppBar({
    Key key,
    @required this.height,
    @required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double statusbarHeight = MediaQuery.of(context).padding.top;

    return Container(
      height: double.infinity,
      width: double.infinity,
      padding: new EdgeInsets.only(top: statusbarHeight),
      child: Row(
        children: [
          _backButton(context),
          _title(),
        ],
      ),
    );
  }

  Widget _title() {
    return Expanded(
      child: Container(
        margin: EdgeInsets.only(left: 10.0, right: 20.0),
        child: Text(
          title,
          style: TextStyle(
            color: kTextColor,
            fontWeight: FontWeight.bold,
            fontSize: 18.0,
          ),
          maxLines: 2,
        ),
      ),
    );
  }

  Widget _backButton(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 15.0, right: 15.0),
      height: 36.0,
      width: 36.0,
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
            offset: Offset(1, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.all(Radius.circular(36.0)),
          child: Align(
            alignment: Alignment.center,
            child: Theme.of(context).platform == TargetPlatform.iOS
                ? Padding(
                    padding: EdgeInsets.only(left: 8.0),
                    child: Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                      size: 24.0,
                    ),
                  )
                : Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
