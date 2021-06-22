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

  void startScan(List<Product> products) async {
    var options =
        ScanOptions(useCamera: -1, android: AndroidOptions(useAutoFocus: true));
    BarcodeScanner.scan(options: options).then((value) {
      print("code product---------------------");
      print(value.rawContent);
      print("code product---------------------");
      products.forEach((product) {
        if (product.barcode == value.rawContent) {
          print("-----------code selected----------");
          print(product);
          print("-----------code selected----------");
          product.multimedias.forEach((multimedia) {
            if (multimedia.multimediaType == 1) {
              print("--------------------multimedia catched---------");
              print(multimedia);
              print("--------------------multimedia catched---------");
              Navigator.of(getContext()).pushNamed('/video',
                  arguments: new MediaArguments(
                      title: multimedia.title,
                      description: multimedia.description,
                      url: multimedia.url));
            }
          });
        }
      });
      /* getMedia().then((branchInfo) {
        branchInfo['products'].forEach((product) {
          if (product['barcode'] == value.rawContent) {
            print("-----------code selected----------");
            print(product);
            print("-----------code selected----------");
            product['multimedias'].forEach((multimedia) {
              if (multimedia['multimediaType'] == 2)
                print("--------------------multimedia catched---------");
              print(multimedia);
              print("--------------------multimedia catched---------");
              Navigator.of(getContext())
                  .pushNamed('/video', arguments:);
            });
          }
        });
      }); */
    });
  }

  Future<Map<String, dynamic>> getMedia() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return jsonDecode(prefs.getString(Constants.sucursalInfo));
  }

  void selectProduct(Product value) {
    MediaArguments videoArgs = MediaArguments();
    print("selecto product---------------------");
    value.multimedias.forEach((element) {
      if (element.multimediaType == 1) {
        videoArgs.title = element.title;
        videoArgs.description = element.description;
        videoArgs.url = element.url;
      }
    });
    Navigator.of(getContext()).pushNamed('/video', arguments: videoArgs);
  }
}
