import 'package:flutter/material.dart';

class PowerButton extends StatefulWidget {
  final double height;
  final double width;
  const PowerButton({
    Key key,
    this.height,
    this.width,
  }) : super(key: key);
  @override
  _PowerButtonState createState() => _PowerButtonState();
}

class _PowerButtonState extends State<PowerButton> {
  bool _isPowerOn = false;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Padding(
        padding: EdgeInsets.only(
          bottom: widget.height * 0.44,
        ),
        child: InkWell(
          onTap: () {
            setState(() {
              if (_isPowerOn)
                _isPowerOn = false;
              else
                _isPowerOn = true;
            });
          },
          child: AnimatedCrossFade(
            duration: Duration(milliseconds: 200),
            crossFadeState: _isPowerOn
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
            firstChild: Container(
              height: widget.height * 0.44,
              width: widget.height * 0.44,
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      child: Image.asset(
                        "assets/images/power_button2.png",
                        height: widget.height * 0.44,
                        width: widget.height * 0.44,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      child: Image.asset(
                        "assets/images/power_button1.png",
                        height: widget.height * 0.44,
                        width: widget.height * 0.44,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: EdgeInsets.only(
                        top: widget.height * 0.006,
                        left: widget.height * 0.014,
                      ),
                      child: Container(
                        child: Image.asset(
                          "assets/images/power_off.png",
                          height: widget.height * 0.44,
                          width: widget.height * 0.44,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            secondChild: Container(
              height: widget.height * 0.44,
              width: widget.height * 0.44,
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      child: Image.asset(
                        "assets/images/power_button2.png",
                        height: widget.height * 0.44,
                        width: widget.height * 0.44,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      child: Image.asset(
                        "assets/images/power_button1.png",
                        height: widget.height * 0.44,
                        width: widget.height * 0.44,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: EdgeInsets.only(
                        bottom: widget.height * 0.004,
                        right: widget.height * 0.008,
                      ),
                      child: Container(
                        child: Image.asset(
                          "assets/images/power_on.png",
                          height: widget.height * 0.46,
                          width: widget.height * 0.46,
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
    );
  }
}
