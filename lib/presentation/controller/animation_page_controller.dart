import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

import '../presenter/animation_page_presenter.dart';

class AnimationPageController extends Controller{
  bool isLoading;
  AnimationPagePresenter _presenter;
  AnimationPageController(authRepo) : _presenter = AnimationPagePresenter(authRepo) {
    getAuthStatus();
  }

  @override
  void initListeners() {
    _presenter.authStatusOnNext = authStatusOnN;
    _presenter.authStatusOnComplete = () => isLoading = false;
  }

  void authStatusOnN(bool isAuth){
    String page = isAuth ? '/home' : '/login';
    Navigator.of(getContext()).pushReplacementNamed(page);
  }

  void initAnimation(AnimationController controller, Animation animation) {
    animation.addStatusListener((status) {
      if(isLoading){
        controller.stop(canceled: true);
      } else if (status == AnimationStatus.completed){
        controller.reverse();
      } else if (status == AnimationStatus.dismissed){
        controller.forward();
      }
    });
    controller.forward();
  }

  void getAuthStatus() async {
    isLoading = true;
    Future.delayed(Duration(seconds: 3), _presenter.getAuthStatus);
  }
}