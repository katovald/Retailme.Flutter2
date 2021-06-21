import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

class HomePagePresenter extends Presenter{
  Function getInteractions;
  Function initMultimedia;

  HomePagePresenter();

  @override
  void dispose() {

  }
}