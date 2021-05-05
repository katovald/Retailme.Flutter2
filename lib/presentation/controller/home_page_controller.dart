import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:ic_nominas/presentation/helpers/constants.dart';
import 'package:ic_nominas/presentation/presenter/home_page_presenter.dart';

class HomePageController extends Controller{
  bool isLoading;

  HomePagePresenter _presenter;

  HomePageController(authRepo) : _presenter = HomePagePresenter(authRepo) {
    getAuthStatus();
  }

  @override
  void initListeners() {

  }

  void onGetCode(String code){
    Navigator.of(getContext()).pushNamed('/product');
  }

  void getAuthStatus() async {
    isLoading = true;
    Future.delayed(Duration(seconds: 3), _presenter.getStatus);
  }

  void startScan() async {
    var options = ScanOptions(
      useCamera: 1,
      android: AndroidOptions(useAutoFocus: true)
    );
    BarcodeScanner.scan(options: options).then((value) {
      print(value.rawContent);
      //TODO: armar dinamicamente la ruta, para que al escanear cualquier producto ya tenga la informacion correcta
      if(value.rawContent == '5011013935604'){
        Navigator.of(getContext()).pushNamed('/video', arguments: MediaArguments('', 'assets/video/churros_receta01.mp4', ''));
      }else if(value.rawContent == '86767210029'){
        Navigator.of(getContext()).pushNamed('/video', arguments: MediaArguments('', 'assets/video/original_video.mp4', ''));
      }else if(value.rawContent == '5011013100118'){
        Navigator.of(getContext()).pushNamed('/video', arguments: MediaArguments('', 'assets/video/original_video.mp4', ''));
      }else if(value.rawContent == '5011013933785'){
        Navigator.of(getContext()).pushNamed('/video', arguments: MediaArguments('', 'assets/video/original_video.mp4', ''));
      }else {

      }
    });
  }
}