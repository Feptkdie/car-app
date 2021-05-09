import 'package:carpro_app/pages/info/info_detail.dart';
import 'package:flutter/material.dart';
import 'pages/sos/sos_fav.dart';
import 'pages/splash/splash_page.dart';
import 'pages/home/home_page.dart';
import 'pages/auth/login_page.dart';
import 'pages/auth/register_page.dart';
import 'pages/sos/sos_page.dart';
import 'pages/map/map_page.dart';
import 'pages/car/car_page.dart';
import 'pages/car_detail/car_detail_page.dart';
import 'pages/info/info_page.dart';
import 'pages/profile/profile_page.dart';
import 'pages/profile/profile_edit.dart';
import 'pages/profile/profile_car_edit.dart';
import 'pages/profile/widgets/add_car.dart';
import 'pages/profile/widgets/add_part.dart';
import 'pages/profile/widgets/edit_part.dart';

final Map<String, WidgetBuilder> routes = {
  SplashPage.routeName: (context) => SplashPage(),
  HomePage.routeName: (context) => HomePage(),
  LoginPage.routeName: (context) => LoginPage(),
  RegisterPage.routeName: (context) => RegisterPage(),
  SosPage.routeName: (context) => SosPage(),
  MapPage.routeName: (context) => MapPage(),
  CarPage.routeName: (context) => CarPage(),
  CarDetailPage.routeName: (context) => CarDetailPage(),
  InfoPage.routeName: (context) => InfoPage(),
  ProfilePage.routeName: (context) => ProfilePage(),
  ProfileEdit.routeName: (context) => ProfileEdit(),
  ProfileCarEdit.routeName: (context) => ProfileCarEdit(),
  AddCar.routeName: (context) => AddCar(),
  AddPart.routeName: (context) => AddPart(),
  EditPart.routeName: (context) => EditPart(),
  InfoDetail.routeName: (context) => InfoDetail(),
  SosFav.routeName: (context) => SosFav(),
};
