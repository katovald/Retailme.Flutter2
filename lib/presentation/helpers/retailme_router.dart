import 'package:flutter/material.dart';
import 'package:ic_nominas/presentation/view/data_form_view.dart';
import 'package:ic_nominas/presentation/view/info_page.dart';
import 'package:ic_nominas/presentation/view/media_video_page.dart';

import '../view/home_page.dart';
import '../view/login_page.dart';
import 'pages.dart';

class RetRouter {
  final RouteObserver<PageRoute> routeObserver;

  RetRouter() : routeObserver = RouteObserver<PageRoute>();

  Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name){
      case Pages.home:
        return _buildRoute(settings, HomePage());
      case Pages.login:
        return _buildRoute(settings, LoginPage());
      case Pages.productInfo:
        return _buildRoute(settings, InfoView(args: settings.arguments));
      case Pages.video:
        return _buildRoute(settings, MediaVideoView(args: settings.arguments,));
      case Pages.dataform:
        return _buildRoute(settings, DataFormPage());
    }
  }

  MaterialPageRoute _buildRoute(RouteSettings settings, Widget builder){
    return new MaterialPageRoute(builder: (ctx) => builder, settings: settings);
  }
}