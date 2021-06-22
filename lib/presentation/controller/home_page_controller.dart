import 'dart:convert';

import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:retailmi/domain/helpers/constants.dart';
import 'package:retailmi/domain/models/product_model.dart';
import 'package:retailmi/presentation/helpers/constants.dart';
import 'package:retailmi/presentation/presenter/home_page_presenter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePageController extends Controller {
  bool isLoading;

  HomePagePresenter _presenter;

  HomePageController() : _presenter = HomePagePresenter();

  @override
  void initListeners() {}

  void onGetCode(String code) {
    Navigator.of(getContext()).pushNamed('/product');
  }

  void getAuthStatus() async {
    isLoading = true;
  }

  void startScan() async {
    var options =
        ScanOptions(useCamera: 1, android: AndroidOptions(useAutoFocus: true));
    BarcodeScanner.scan(options: options).then((value) {
      print(value.rawContent);
      getMedia().then((branchInfo) {
        print(value);
        branchInfo['products'].map((product) {
          if (product['barcode'] == value.rawContent) {
              product['multimedias'].map((multimedia) {
                  if(multimedia['multimediaType'] == 1)
                  Navigator.of(getContext()).pushNamed('/video',
                  arguments: MediaArguments('', 'video/${product['url']}', ''));
            });
          }
        });
      });
    });
  }

  Future<Map<String, dynamic>> getMedia() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return jsonDecode(prefs.getString(Constants.sucursalInfo));
  }

  void selectProduct(Product value) {
    MediaArguments videoArgs;

    value.multimedias.forEach((element) {
      if(element.multimediaType == 1){
        videoArgs.title = element.title;
        videoArgs.description = element.description;
        videoArgs.url = element.url;
      }
    });
    Navigator.of(getContext()).pushNamed('/video',
        arguments: videoArgs);
  }
}
