import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:ic_nominas/presentation/presenter/home_page_presenter.dart';

class HomePageController extends Controller{
  bool isLoading;

  HomePagePresenter _presenter;

  HomePageController(authRepo) : _presenter = HomePagePresenter(authRepo) {
    getAuthStatus();
  }

  @override
  void initListeners() {
    _presenter.authStatusOnNext = authStatusOnNext;
    _presenter.authStatusOnComplete = () => isLoading = false;
  }

  void authStatusOnNext(bool isAuth){
    if (isAuth){

    }else{

    }
  }

  void onGetCode(String code){
    Navigator.of(getContext()).pushNamed('/product');
  }

  void getAuthStatus() async {
    isLoading = true;
    Future.delayed(Duration(seconds: 3), _presenter.getStatus);
  }
}