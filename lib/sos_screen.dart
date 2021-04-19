import 'package:carpro/sos_favorite_screen.dart';
import 'package:carpro/widget/arrow_button.dart';
import 'package:carpro/widget/profile.dart';
import 'package:carpro/widget/sos_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import 'widget/appBar_title.dart';
import 'widget/search_btn.dart';

class SosScreen extends StatelessWidget {
  @override
  Widget build(BuildContext ctx) {
    return Scaffold(
      backgroundColor: Color(0xffD4D7DC),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(MediaQuery.of(ctx).size.height * 0.1),
        child: Padding(
          padding: EdgeInsets.only(
            top: MediaQuery.of(ctx).size.height * 0.05,
            bottom: MediaQuery.of(ctx).size.height * 0.02,
          ),
          child: Row(
            children: [
              ArrowButton(),
              AppBarTitle(title: "SOS"),
              Expanded(
                child: SearchBtn(
                  searchText: "Хайлтын түлхүүр үг",
                ),
              ),
              Profile(),
            ],
          ),
        ),
      ),
      body: Stack(
        children: [
          _myFavoriteText(ctx),
          SosCard(),
        ],
      ),
    );
  }

  Widget _myFavoriteText(BuildContext ctx) {
    return Padding(
      padding: EdgeInsets.only(
        top: MediaQuery.of(ctx).size.height * 0.02,
        right: MediaQuery.of(ctx).size.height * 0.03,
      ),
      child: InkWell(
        onTap: () {
          Navigator.of(ctx).push(
            MaterialPageRoute(
              builder: (ctx) => FavoriteScreen(),
            ),
          );
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              "Миний хадгалсан",
              style: TextStyle(
                fontFamily: "Montserrat",
                fontSize: MediaQuery.of(ctx).size.height * 0.018,
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
                image: AssetImage("assets/forward.png"),
                height: MediaQuery.of(ctx).size.height * 0.017,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
