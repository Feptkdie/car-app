import 'package:carpro_app/pages/car/widgets/car_item.dart';
import 'package:carpro_app/providers/car_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import './widgets/category_slide.dart';
import 'package:carpro_app/constants.dart';

class CarPage extends StatefulWidget {
  static String routeName = "/cars";

  @override
  _CarPageState createState() => _CarPageState();
}

class _CarPageState extends State<CarPage> {
  RangeValues _currentRangeValues = const RangeValues(0, 300);

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
          "Худалдаа",
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
              filters(),
              carItems(),
              SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget carItems() {
    return Consumer<CarProvider>(
      builder: (context, carProvider, child) {
        return Align(
          alignment: Alignment.topLeft,
          child: Wrap(
            children: List.generate(
              carProvider.getCars.length,
              (index) {
                return CarItem(
                  index: index,
                  car: carProvider.getCars[index],
                );
              },
            ),
          ),
        );
      },
    );
  }

  Widget filters() {
    return Container(
      margin: EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20.0),
      child: Row(
        children: <Widget>[
          GestureDetector(
            child: Image.asset(
              "assets/images/setting.png",
              width: 20.0,
            ),
          ),
          SizedBox(width: 20.0),
          Text("3 сая"),
          Expanded(
            child: SliderTheme(
              data: SliderTheme.of(context).copyWith(
                activeTrackColor: kColor1,
                inactiveTrackColor: kPrimaryColor,
                thumbColor: Colors.grey[100],
              ),
              child: RangeSlider(
                values: _currentRangeValues,
                min: 0,
                max: 300,
                divisions: 300,
                labels: RangeLabels(
                  _currentRangeValues.start.round().toString() + " сая",
                  _currentRangeValues.end.round().toString() + " сая",
                ),
                onChanged: (RangeValues values) {
                  setState(() {
                    _currentRangeValues = values;
                  });
                },
              ),
            ),
          ),
          Text("300 сая"),
        ],
      ),
    );
  }
}
