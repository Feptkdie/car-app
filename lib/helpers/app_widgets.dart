import 'package:car/pages/auth/login_page.dart';
import 'package:flutter/material.dart';

class Button extends StatefulWidget {
  final double borderRadius;
  final double height;
  final double width;
  final double fontSize;
  final Color backgroundColor;
  final Color splashColor;
  final Color textColor;
  final String text;
  final bool textBold;
  final Function onTap;

  const Button(
      {Key key,
      this.borderRadius,
      this.height,
      this.width,
      this.fontSize,
      this.backgroundColor,
      this.splashColor,
      this.textColor,
      this.text,
      this.textBold,
      this.onTap})
      : super(key: key);
  @override
  _ButtonState createState() => _ButtonState();
}

class _ButtonState extends State<Button> {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(widget.borderRadius ?? 0.0),
      child: Container(
        height: widget.height ?? 40.0,
        width: widget.width ?? 100.0,
        color: widget.backgroundColor ?? Colors.white.withOpacity(0.9),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (loading == true)
              Container(
                width: 20.0,
                height: 20.0,
                child: Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 1.5,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Colors.white.withOpacity(0.9),
                    ),
                  ),
                ),
              ),
            if (loading == false)
              Container(
                height: widget.height ?? 40.0,
                width: widget.width ?? 100.0,
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    splashColor: widget.splashColor ?? Colors.grey,
                    onTap: widget.onTap,
                    child: Center(
                      child: Text(
                        widget.text ?? "empty",
                        style: TextStyle(
                          color: widget.textColor ?? Colors.black,
                          fontSize: widget.fontSize ?? 16.0,
                          fontWeight: widget.textBold
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
