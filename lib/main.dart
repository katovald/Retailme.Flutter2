import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'presentation/helpers/retailme_router.dart';
import 'presentation/view/animation_page.dart';

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
      title: 'Retailme',
      theme: ThemeData(
        hintColor: Color.fromRGBO(255, 255, 255, 0.8)
      ),
      home: AnimationPage(),
      debugShowCheckedModeBanner: false,
      onGenerateRoute: _router.getRoute,
      navigatorObservers: [_router.routeObserver],
    );
  }
}
