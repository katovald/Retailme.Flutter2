import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:flutter/material.dart';
import 'package:ic_nominas/presentation/helpers/constants.dart';

class InfoViewController extends Controller {
  @override
  void initListeners() {
    // TODO: implement initListeners
  }

  void presentVideo(String media)
  {
    Navigator.of(getContext()).pushNamed('/video', arguments: MediaArguments('', media, ''));
  }
}