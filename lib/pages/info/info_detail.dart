import 'package:cached_network_image/cached_network_image.dart';
import 'package:carpro_app/models/info.dart';
import 'package:carpro_app/providers/info_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_social_content_share/flutter_social_content_share.dart';
import 'package:provider/provider.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';

import '../../constants.dart';

class InfoDetail extends StatefulWidget {
  static String routeName = "/info_detail";

  @override
  _InfoDetailState createState() => _InfoDetailState();
}

class _InfoDetailState extends State<InfoDetail> {
  String _platformVersion = 'Unknown';
  DateTime now = DateTime.now();

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      platformVersion = await FlutterSocialContentShare.platformVersion;
    } catch (e) {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    final routes =
        ModalRoute.of(context).settings.arguments as Map<String, int>;
    var infos = context.read<InfoProvider>().getInfos;
    DateTime now = DateTime.now();
    return Scaffold(
      backgroundColor: Color(0xffd0d3d5),
      appBar: AppBar(
        backgroundColor: kBackColor2,
        leading: Padding(
          padding: const EdgeInsets.all(
            6.0,
          ),
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).pop(context);
            },
            child: Padding(
              padding: EdgeInsets.only(
                left: MediaQuery.of(context).size.height * 0.01,
              ),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.045,
                width: MediaQuery.of(context).size.height * 0.045,
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
                      offset: Offset(2, 2),
                    ),
                  ],
                ),
                child: Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        title: Text(
          "Мэдээ",
          style: TextStyle(
            color: kTextGrey,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: _cardWidget(context, now, infos[routes['index']]),
        ),
      ),
    );
  }

  Widget _cardWidget(BuildContext context, DateTime now, Info info) {
    return LayoutBuilder(
        builder: (BuildContext ctx, BoxConstraints constraints) {
      return Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            SingleChildScrollView(
              child: Stack(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.height * 0.03,
                        right: MediaQuery.of(context).size.height * 0.03,
                        bottom: MediaQuery.of(context).size.height * 0.02),
                    child: Card(
                      color: Colors.transparent,
                      elevation: 0.0,
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal:
                                    MediaQuery.of(context).size.height * 0.01),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Row(
                                    children: [
                                      Image.asset(
                                        "assets/images/clock.png",
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.012,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(left: 5.0),
                                        child: Text(
                                          info.createdAt.substring(0, 10),
                                          style: TextStyle(
                                              fontFamily: "Montserrat",
                                              fontSize: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.01),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  flex: -1,
                                  child: InkWell(
                                    onTap: () {
                                      shareOnFacebook();
                                    },
                                    child: Icon(
                                      Icons.more_horiz,
                                      size: MediaQuery.of(context).size.height *
                                          0.03,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height * 0.22,
                              left: MediaQuery.of(context).size.height * 0.01,
                              right: MediaQuery.of(context).size.height * 0.01,
                              bottom: MediaQuery.of(context).size.height * 0.02,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  child: Text(
                                    info.title,
                                    style: TextStyle(
                                      fontFamily: "Montserrat",
                                      fontSize:
                                          MediaQuery.of(context).size.height *
                                              0.016,
                                      fontWeight: FontWeight.bold,
                                      color: kTextColor,
                                    ),
                                  ),
                                ),
                                // InkWell(
                                //   child: Image.asset(
                                //     "assets/images/bookmark.png",
                                //     height: MediaQuery.of(context).size.height *
                                //         0.015,
                                //   ),
                                // ),
                              ],
                            ),
                          ),
                          Container(
                            width: double.infinity,
                            alignment: Alignment.center,
                            child: HtmlWidget(
                              info.content,
                            ),
                            // child: Html(
                            //   data: InfoData.infoItems[widget.index].content,
                            //   style: {
                            //     "body": Style(
                            //       fontFamily: "Montserrat",
                            //       fontSize: FontSize(11),
                            //       alignment: Alignment.topLeft,
                            //       wordSpacing: 1.5,
                            //     ),
                            //     "ul": Style(
                            //       margin: EdgeInsets.all(0),
                            //       padding: EdgeInsets.all(0),
                            //     ),
                            //     "li": Style(
                            //       margin: EdgeInsets.all(0),
                            //       padding: EdgeInsets.all(0),
                            //     )
                            //   },
                            // ),
                          )
                        ],
                      ),
                    ),
                  ),
                  if (info.fileMode == "image")
                    Align(
                      alignment: Alignment.topCenter,
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          maxHeight: MediaQuery.of(context).size.height,
                          maxWidth: MediaQuery.of(context).size.width,
                        ),
                        child: Container(
                          margin: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height * 0.04,
                            right: MediaQuery.of(context).size.height * 0.04,
                            left: MediaQuery.of(context).size.height * 0.04,
                          ),
                          height: MediaQuery.of(context).size.height * 0.2,
                          width: MediaQuery.of(context).size.width,
                          // decoration: BoxDecoration(
                          //   color: Colors.white,
                          //   borderRadius: BorderRadius.circular(10),
                          // ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: CachedNetworkImage(
                              imageUrl: info.filePath,
                              height: MediaQuery.of(context).size.height * 0.2,
                              width: MediaQuery.of(context).size.width,
                              fit: BoxFit.cover,
                              placeholder: (context, url) => Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.2,
                                width: MediaQuery.of(context).size.width,
                                color: Colors.white.withOpacity(0.8),
                                child: Center(
                                  child: CircularProgressIndicator(
                                    strokeWidth: 1.5,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      kPrimaryColor,
                                    ),
                                  ),
                                ),
                              ),
                              errorWidget: (context, url, error) =>
                                  Icon(Icons.error),
                            ),
                          ),
                        ),
                      ),
                    ),
                  if (info.fileMode == "video")
                    Align(
                      alignment: Alignment.topCenter,
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          maxHeight: MediaQuery.of(context).size.height,
                          maxWidth: MediaQuery.of(context).size.width,
                        ),
                        child: Container(
                          margin: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height * 0.04,
                            right: MediaQuery.of(context).size.height * 0.04,
                            left: MediaQuery.of(context).size.height * 0.04,
                          ),
                          height: MediaQuery.of(context).size.height * 0.2,
                          width: MediaQuery.of(context).size.width,
                          // decoration: BoxDecoration(
                          //   color: Colors.white,
                          //   borderRadius: BorderRadius.circular(10),
                          // ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: CachedNetworkImage(
                              imageUrl:
                                  "http://i3.ytimg.com/vi/${info.filePath}/0.jpg",
                              height: 150.0,
                              width: double.infinity,
                              fit: BoxFit.cover,
                              placeholder: (context, url) => SizedBox(
                                width: 30.0,
                                height: 30.0,
                                child:
                                    CircularProgressIndicator(strokeWidth: 1.5),
                              ),
                              errorWidget: (context, url, error) =>
                                  Icon(Icons.error),
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }

  shareOnFacebook() async {
    String result = await FlutterSocialContentShare.share(
        type: ShareType.facebookWithoutImage,
        url: "https://www.mindsymbol.com",
        quote: "captions");
    print(result);
  }
}
