import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './routes.dart';

// Providers
import './providers/auth_provider.dart';
import './providers/car_provider.dart';
import './providers/company_category_provider.dart';
import './providers/info_provider.dart';
import './providers/sos_category_provider.dart';

import 'constants.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => CarProvider()),
        ChangeNotifierProvider(create: (_) => CompanyCategoryProvider()),
        ChangeNotifierProvider(create: (_) => InfoProvider()),
        ChangeNotifierProvider(create: (_) => SosCategoryProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: "/",
      routes: routes,
      theme: ThemeData(
        primaryColor: kPrimaryColor,
        fontFamily: "Montserrat",
        backgroundColor: kBackColor1,
      ),
    );
  }
}
