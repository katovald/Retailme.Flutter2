import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ic_nominas/presentation/view/home_page.dart';

import 'presentation/helpers/retailme_router.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  final RetRouter _router;

  MyApp() : _router = RetRouter();
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);

    return MaterialApp(
      title: 'Retailmi',
      theme: ThemeData(
        hintColor: Color.fromRGBO(255, 255, 255, 0.8),
        brightness: Brightness.dark,
        primaryColor: Color.fromRGBO(18, 168, 237, 1.0),
        accentColor: Colors.white70,
        scaffoldBackgroundColor:  Colors.white70,
        fontFamily: 'San Francisco',
      ),
      home: HomePage(),
      debugShowCheckedModeBanner: false,
      onGenerateRoute: _router.getRoute,
      navigatorObservers: [_router.routeObserver],
    );
  }
}
