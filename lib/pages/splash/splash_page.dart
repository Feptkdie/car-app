import 'dart:convert';

import 'package:carpro_app/models/car.dart';
import 'package:carpro_app/models/company.dart';
import 'package:carpro_app/models/company_category.dart';
import 'package:carpro_app/models/sos.dart';
import 'package:carpro_app/providers/company_category_provider.dart';
import 'package:provider/provider.dart';
import 'package:carpro_app/models/sos_category.dart';
import 'package:carpro_app/providers/sos_category_provider.dart';
import 'package:carpro_app/providers/car_provider.dart';
import 'package:http/http.dart' as http;
import 'package:carpro_app/constants.dart';
import 'package:carpro_app/helpers/app_url.dart';
import 'package:flutter/material.dart';

Future<Map<String, dynamic>> fetchData() async {
  final response = await http.get(
    AppUrl.baseURL + "/get-data",
    headers: {
      "Content-Type": "application/json",
      "Accept": "application/json",
    },
  );

  if (response.statusCode == 200) {
    return json.decode(utf8.decode(response.bodyBytes));
  } else {
    return Future.error(response.body);
  }
}

class SplashPage extends StatefulWidget {
  static String routeName = "/";

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with TickerProviderStateMixin {
  AnimationController animationController;

  void setCarProvider(List<dynamic> list) {
    List<Car> cars = [];

    list.forEach((data) {
      var carItem = {
        "id": data["id"],
        "name": data["name"],
        "images": data["images"],
        "group": data["group"],
        "mark": data["mark"],
        "model": data["model"],
        "type": data["type"],
        "importYear": data["importYear"],
        "importMonth": data["importMonth"],
        "madeInYear": data["madeInYear"],
        "engineCapacity": data["engineCapacity"],
        "drivderHand": data["drivderHand"],
        "runningKm": data["runningKm"],
        "hutlugch": data["hutlugch"],
        "hrop": data["hrop"],
        "fuel": data["fuel"],
        "description": data["description"],
        "price": data["price"],
        "phone": data["phone"],
        "seller": data["seller"],
      };

      Car car = Car.fromJson(carItem);
      cars.add(car);
    });

    context.read<CarProvider>().setCars(cars);
  }

  void setSosCategoryProvider(List<dynamic> list) {
    List<SosCategory> sosCategories = [];

    list.forEach((data) {
      List<Sos> soss = [];
      data["notes"].forEach((note) {
        var sosItem = {
          "id": note["id"],
          "categoryId": note["category_id"],
          "title": note["title"],
          "image": note["image"],
          "address": note["address"],
          "phone": note["phone"],
          "coordX": note["coord_x"],
          "coordY": note["coord_y"],
        };

        Sos sos = Sos.fromJson(sosItem);
        soss.add(sos);
      });

      var categoryItem = {
        "id": data["id"],
        "name": data["name"],
        "image": data["image"],
        "soss": soss,
      };

      SosCategory sosCategory = SosCategory.fromJson(categoryItem);
      sosCategories.add(sosCategory);
    });

    context.read<SosCategoryProvider>().setSosCategories(sosCategories);
  }

  void setCompanyCategoryProvider(List<dynamic> list) {
    List<CompanyCategory> companyCategories = [];

    list.forEach((data) {
      List<Company> companies = [];
      data["companies"].forEach((item) {
        var companyItem = {
          "id": item["id"],
          "name": item["name"],
          "logo": item["logo"],
          "address": item["address"],
          "coordX": item["coordX"],
          "coordY": item["coordY"],
        };

        Company company = Company.fromJson(companyItem);
        companies.add(company);
      });

      var categoryItem = {
        "id": data["id"],
        "name": data["name"],
        "companies": companies,
      };

      CompanyCategory companyCategory = CompanyCategory.fromJson(categoryItem);
      companyCategories.add(companyCategory);
    });

    context
        .read<CompanyCategoryProvider>()
        .setCompanyCategories(companyCategories);
  }

  @override
  void initState() {
    super.initState();
    animationController =
        AnimationController(duration: new Duration(seconds: 2), vsync: this);
    animationController.repeat();

    fetchData().then((data) {
      setCarProvider(data["cars"]);
      setSosCategoryProvider(data["sos_categories"]);
      setCompanyCategoryProvider(data["company_categories"]);

      Navigator.pushReplacementNamed(context, "/home");
    }).catchError((error, stackTrace) {
      print("error: $error");
      Navigator.pushReplacementNamed(context, "/home");
    });
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackColor2,
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    "assets/images/logo_one.png",
                    width: 32,
                  ),
                  SizedBox(
                    width: 8.0,
                  ),
                  Text(
                    "CarPro",
                    style: TextStyle(
                      color: kTextDark,
                      fontWeight: FontWeight.w800,
                      fontSize: 32.0,
                      fontFamily: "Montserrat",
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30),
              SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2.5,
                  valueColor: animationController.drive(
                    ColorTween(
                      begin: kColor1,
                      end: kColor3,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
