import 'package:carpro_app/models/setting.dart';
import 'package:carpro_app/providers/setting_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import '../../../constants.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:provider/provider.dart';

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
  void _launchURL(_url) async => await canLaunch('tel:$_url')
      ? await launch('tel:$_url')
      : throw 'Could not launch $_url';

  bool _isPowerOn = false;
  String phone;
  String about;

  @override
  void initState() {
    super.initState();

    List<Setting> settings = context.read<SettingProvider>().getSettings;

    if (settings.length > 0) {
      phone = settings[0].phone;
      about = settings[0].about;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Padding(
        padding: EdgeInsets.only(
          bottom: widget.height * 0.44,
          right: widget.height * 0.014,
        ),
        child: InkWell(
          onTap: () {
            _showSheet();

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
              height: widget.height * 0.43,
              width: widget.height * 0.43,
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      child: Image.asset(
                        "assets/images/power_button2.png",
                        height: widget.height * 0.4,
                        width: widget.height * 0.4,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: EdgeInsets.only(
                        left: widget.height * 0.05,
                      ),
                      child: Container(
                        child: Image.asset(
                          "assets/images/power_button1.png",
                          height: widget.height * 0.4,
                          width: widget.height * 0.4,
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: EdgeInsets.only(
                        right: widget.height * 0.008,
                      ),
                      child: Container(
                        child: Image.asset(
                          "assets/images/power_off.png",
                          height: widget.height * 0.43,
                          width: widget.height * 0.43,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            secondChild: Container(
              height: widget.height * 0.42,
              width: widget.height * 0.42,
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      child: Image.asset(
                        "assets/images/power_button2.png",
                        height: widget.height * 0.4,
                        width: widget.height * 0.4,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: EdgeInsets.only(
                        left: widget.height * 0.05,
                      ),
                      child: Container(
                        child: Image.asset(
                          "assets/images/power_button1.png",
                          height: widget.height * 0.4,
                          width: widget.height * 0.4,
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: EdgeInsets.only(
                        right: widget.height * 0.008,
                        bottom: widget.height * 0.006,
                      ),
                      child: Container(
                        child: Image.asset(
                          "assets/images/power_on.png",
                          height: widget.height * 0.42,
                          width: widget.height * 0.42,
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

  void _showSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) {
        return DraggableScrollableSheet(
          initialChildSize: 0.6,
          expand: false,
          builder: (_, controller) {
            return SingleChildScrollView(
              controller: controller,
              child: Container(
                padding: EdgeInsets.all(10.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      height: 8.0,
                    ),
                    Image.asset(
                      "assets/images/logo_one.png",
                      width: 32,
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    Text(
                      "CarPro",
                      style: TextStyle(
                        color: kTextDark,
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "ТАНИЛЦУУЛГА",
                            style: TextStyle(
                              color: kTextGrey,
                              fontSize: 12.0,
                            ),
                          ),
                          SizedBox(height: 10.0),
                          if (about != null) HtmlWidget(about),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    if (phone != null)
                      Text(
                        "$phone",
                        style: TextStyle(),
                      ),
                    if (phone != null)
                      SizedBox(
                        height: 8.0,
                      ),
                    if (phone != null)
                      FlatButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        color: kPrimaryColor.withOpacity(1),
                        padding: EdgeInsets.only(left: 5, right: 5),
                        onPressed: () {
                          _launchURL("$phone");
                        },
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              "Залгах".toUpperCase(),
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    SizedBox(
                      height: 18.0,
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    ).then((value) {
      setState(() {
        if (_isPowerOn)
          _isPowerOn = false;
        else
          _isPowerOn = true;
      });
    });
  }
}
