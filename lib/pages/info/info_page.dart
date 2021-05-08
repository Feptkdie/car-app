import 'package:cached_network_image/cached_network_image.dart';
import 'package:carpro_app/models/info.dart';
import 'package:carpro_app/providers/info_provider.dart';
import 'package:carpro_app/widgets/custom_app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class InfoPage extends StatefulWidget {
  static String routeName = "/infos";
  @override
  _InfoPageState createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        height: 56.0,
        title: "Мэдээ",
      ),
      backgroundColor: Color(0xffd0d3d5),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(height: 20.0),
              _listInfo(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _listInfo(BuildContext context) {
    var infos = context.read<InfoProvider>().getInfos;

    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: infos.length,
      itemBuilder: (BuildContext context, int index) {
        return _infoItem(infos[index], index);
      },
    );
  }

  Widget _infoItem(Info info, int index) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, "/info_detail",
              arguments: {"index": index});
        },
        child: Stack(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  if (info.fileMode == "image")
                    CachedNetworkImage(
                      imageUrl: info.filePath,
                      height: 180.0,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      placeholder: (context, url) =>
                          CircularProgressIndicator(strokeWidth: 1.5),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
                  if (info.fileMode == "video")
                    CachedNetworkImage(
                      imageUrl: "http://i3.ytimg.com/vi/${info.filePath}/0.jpg",
                      height: 150.0,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => SizedBox(
                        width: 30.0,
                        height: 30.0,
                        child: CircularProgressIndicator(strokeWidth: 1.5),
                      ),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: 10.0,
                      bottom: 10.0,
                    ),
                    child: Text(
                      info.title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13.0,
                      ),
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      Image.asset(
                        "assets/images/clock.png",
                        width: 12.0,
                      ),
                      SizedBox(width: 10.0),
                      Text(
                        info.createdAt.substring(0, 10),
                        style: TextStyle(fontSize: 11.0),
                      ),
                    ],
                  ),
                  Divider(),
                ],
              ),
            ),
            if (info.fileMode == "video")
              Positioned(
                top: 10.0,
                right: 30.0,
                child: Image.asset("assets/images/youtube.png", width: 30.0),
              ),
          ],
        ),
      ),
    );
  }
}
