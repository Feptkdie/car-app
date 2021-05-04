import 'package:flutter/material.dart';
import '../../../constants.dart';
import 'package:slide_popup_dialog/slide_popup_dialog.dart' as slideDialog;
import 'package:url_launcher/url_launcher.dart';

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
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "ХасЛизинг компани нь Лизингийн үйлчилгээг дагнан эрхлэх зорилгоор 2007 онд ТэнГэр Санхүүгийн Нэгдэл ХХК-ийн хөрөнгө оруулалтаар үүсгэн байгуулагдсан салбартаа тэргүүлэгч лизингийн мэргэшсэн компани юм.\nМөн бид үйлдвэрлэл үйлчилгээ, тээвэр, барилга угсралт, хөдөө аж ахуй, уул уурхайн тоног төхөөрөмжүүдийг борлуулдаг байгууллагуудтай хамтын ажиллагааны гэрээ байгуулан нягт хамтран ажилладаг.",
                            textAlign: TextAlign.justify,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "ХасЛизинг компани нь Лизингийн үйлчилгээг дагнан эрхлэх зорилгоор 2007 онд ТэнГэр Санхүүгийн Нэгдэл ХХК-ийн хөрөнгө оруулалтаар үүсгэн байгуулагдсан салбартаа тэргүүлэгч лизингийн мэргэшсэн компани юм.\nМөн бид үйлдвэрлэл үйлчилгээ, тээвэр, барилга угсралт, хөдөө аж ахуй, уул уурхайн тоног төхөөрөмжүүдийг борлуулдаг байгууллагуудтай хамтын ажиллагааны гэрээ байгуулан нягт хамтран ажилладаг.",
                            textAlign: TextAlign.justify,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "ХасЛизинг компани нь Лизингийн үйлчилгээг дагнан эрхлэх зорилгоор 2007 онд ТэнГэр Санхүүгийн Нэгдэл ХХК-ийн хөрөнгө оруулалтаар үүсгэн байгуулагдсан салбартаа тэргүүлэгч лизингийн мэргэшсэн компани юм.\nМөн бид үйлдвэрлэл үйлчилгээ, тээвэр, барилга угсралт, хөдөө аж ахуй, уул уурхайн тоног төхөөрөмжүүдийг борлуулдаг байгууллагуудтай хамтын ажиллагааны гэрээ байгуулан нягт хамтран ажилладаг.",
                            textAlign: TextAlign.justify,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  Text(
                    "+97699115372",
                    style: TextStyle(),
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  FlatButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    color: kPrimaryColor.withOpacity(1),
                    padding: EdgeInsets.only(left: 5, right: 5),
                    onPressed: () {
                      _launchURL("+97699113243");
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
