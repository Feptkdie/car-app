import 'package:carpro_app/providers/sos_category_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import './widgets/category_slide.dart';
import './widgets/sos_item.dart';
import 'package:carpro_app/constants.dart';

class SosPage extends StatefulWidget {
  static String routeName = "/sos";

  @override
  _SosPageState createState() => _SosPageState();
}

class _SosPageState extends State<SosPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackColor2,
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
            child: Theme.of(context).platform == TargetPlatform.iOS
                ? Padding(
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
                      ),
                      child: CupertinoButton(
                        color: Colors.transparent,
                        child: Icon(
                          Icons.arrow_back_ios,
                          color: Colors.white,
                        ),
                        onPressed: () {},
                      ),
                    ),
                  )
                : Padding(
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
          "SOS",
          style: TextStyle(
            color: kTextGrey,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              // getTitle(),
              CategorySlide(),
              sosItems(),
              SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget getTitle() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Text(
        "Миний хадгалсан",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 13,
          color: Colors.black87,
        ),
      ),
    );
  }

  Widget sosItems() {
    return Consumer<SosCategoryProvider>(
      builder: (context, sosCategoryProvider, child) {
        if (sosCategoryProvider.getFilterCategorySos != null) {
          print(
              "find: ${sosCategoryProvider.getFilterCategorySos.soss.length}");
          return Wrap(
            children: List.generate(
              sosCategoryProvider.getFilterCategorySos.soss.length,
              (index) {
                return SosItem(
                  index: index,
                  categoryName: sosCategoryProvider.getFilterCategorySos.name,
                  item: sosCategoryProvider.getFilterCategorySos.soss[index],
                );
              },
            ),
          );
        } else {
          return SizedBox();
        }
      },
    );
  }
}
