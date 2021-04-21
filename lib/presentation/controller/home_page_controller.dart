import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

class HomePageController extends Controller{
  @override
  void initListeners() {
    // TODO: implement initListeners
  }

  void onGetCode(){
    Navigator.of(getContext()).pushNamed('/product');
  }
}