import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

import '../../domain/repositories/data_auth_repo.dart';
import '../controller/animation_page_controller.dart';
import '../helpers/constants.dart';

class AnimationPage extends View {
  AnimationPage();
  @override
  AnimationPageView createState() => AnimationPageView();
}

class AnimationPageView extends ViewState<AnimationPage, AnimationPageController> with SingleTickerProviderStateMixin{
  AnimationController _animationController;
  Animation<double> _animation;

  AnimationPageView() : super(AnimationPageController(DataAuthRepo())) {
    _animationController = AnimationController(vsync: this, duration: Duration(seconds: 1));
    _animation = CurvedAnimation(parent: _animationController, curve: Curves.easeIn)..addListener(() {
      setState(() {

      });
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget get view => Scaffold(key: globalKey, body: body,);

  Stack get body => Stack(
    children: <Widget>[
      background,
      logo,
    ],
  );

  Positioned get background => Positioned(
    top: 0.0,
    left: 0.0,
    right: 0.0,
    height: MediaQuery.of(context).size.height,
    child: Container(
      color: Colors.white,
    ),
  );

  Positioned get logo => Positioned(
    top: MediaQuery.of(context).size.height / 2 - 50,
    left: 0.0,
    right: 0.0,
    child: Column(
      children: <Widget>[
        FadeTransition(
            opacity: _animation,
          child: Image(
            image: AssetImage(Resources.logo),
            width: 200,
          ),
        )
      ],
    ),
  );
}