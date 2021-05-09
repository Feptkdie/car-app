import 'package:carpro_app/providers/sos_category_provider.dart';
import 'package:carpro_app/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../constants.dart';

class SosFav extends StatefulWidget {
  static String routeName = "/sos_fav";
  @override
  _SosFavState createState() => _SosFavState();
}

class _SosFavState extends State<SosFav> {
  void _launchURL(_url) async => await canLaunch('tel:$_url')
      ? await launch('tel:$_url')
      : throw 'Could not launch $_url';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackColor2,
      appBar: CustomAppBar(
        height: 56.0,
        title: "SOS",
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.02,
                right: MediaQuery.of(context).size.height * 0.03,
              ),
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, "/sos");
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "Бүгдийг харах",
                      style: TextStyle(
                        fontFamily: "Montserrat",
                        fontSize: MediaQuery.of(context).size.height * 0.018,
                        color: Color(0xFF556062),
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.right,
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: 8.0,
                      ),
                      child: Image(
                        image: AssetImage("assets/images/forward.png"),
                        height: MediaQuery.of(context).size.height * 0.017,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.08,
              ),
              child: Consumer<SosCategoryProvider>(
                builder: (context, sosCategoryProvider, child) {
                  if (sosCategoryProvider.getSosCategories != null) {
                    print(
                        "find: ${sosCategoryProvider.getSosCategories.length}");
                    return GridView.builder(
                      itemCount:
                          sosCategoryProvider.getSosCategories.length + 1,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio: MediaQuery.of(context).size.width /
                            (MediaQuery.of(context).size.height / 1.95),
                        crossAxisCount: 2,
                        crossAxisSpacing:
                            MediaQuery.of(context).size.height * 0.01,
                        mainAxisSpacing:
                            MediaQuery.of(context).size.height * 0.01,
                      ),
                      itemBuilder: (BuildContext ctx, int index) {
                        return Padding(
                          padding: EdgeInsets.only(
                            top: MediaQuery.of(ctx).size.height * 0.02,
                            right: MediaQuery.of(ctx).size.height * 0.03,
                            left: MediaQuery.of(ctx).size.height * 0.03,
                            bottom: MediaQuery.of(ctx).size.height * .01,
                          ),
                          child: Stack(
                            children: [
                              if (sosCategoryProvider.getSosCategories.length >
                                  index)
                                Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    splashColor: Colors.grey,
                                    onTap: () {
                                      _launchURL(sosCategoryProvider
                                          .getSosCategories[index].soss[0].phone
                                          .toString());
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        gradient: new LinearGradient(
                                          colors: [
                                            Colors.white.withOpacity(0.9),
                                            kBackColor2,
                                          ],
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                        ),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.5),
                                            spreadRadius: 5,
                                            blurRadius: 7,
                                            offset: Offset(0, 3),
                                          ),
                                        ],
                                        borderRadius: BorderRadius.circular(
                                          4.0,
                                        ),
                                      ),
                                      width: double.infinity,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Image(
                                            image: NetworkImage(
                                              sosCategoryProvider
                                                  .getSosCategories[index]
                                                  .image,
                                            ),
                                            height:
                                                MediaQuery.of(ctx).size.height *
                                                    0.08,
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                              top: MediaQuery.of(ctx)
                                                      .size
                                                      .height *
                                                  0.02,
                                              left: MediaQuery.of(ctx)
                                                      .size
                                                      .height *
                                                  0.01,
                                              right: MediaQuery.of(ctx)
                                                      .size
                                                      .height *
                                                  0.01,
                                            ),
                                            child: Text(
                                              sosCategoryProvider
                                                  .getSosCategories[index].name,
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: Color(0xFF556062),
                                                fontFamily: "Montserrat",
                                                fontSize: MediaQuery.of(ctx)
                                                        .size
                                                        .height *
                                                    0.018,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                              else
                                InkWell(
                                  onTap: () {
                                    Navigator.pushNamed(context, "/sos");
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      gradient: new LinearGradient(
                                        colors: [
                                          Colors.white.withOpacity(0.9),
                                          kBackColor2,
                                        ],
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          spreadRadius: 5,
                                          blurRadius: 7,
                                          offset: Offset(0, 3),
                                        ),
                                      ],
                                      borderRadius: BorderRadius.circular(
                                        4.0,
                                      ),
                                    ),
                                    child: Center(
                                      child: Image(
                                        image: AssetImage(
                                          "assets/images/add_button.png",
                                        ),
                                        height: MediaQuery.of(ctx).size.height *
                                            0.055,
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        );
                      },
                    );
                  } else {
                    return SizedBox();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
