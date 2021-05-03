import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
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
    FlutterBarcodeScanner.scanBarcode("#ff6666", "Cancelar", true, ScanMode.DEFAULT).then((value) {
      //TODO: armar dinamicamente la ruta, para que al escanear cualquier producto ya tenga la informacion correcta
      if(value == '5011013935604'){
        Navigator.of(getContext()).pushNamed('/product', arguments: ProductsArguments('BAILEYS Churros 700 ml.', 'http://retailmi.elbyte.com.mx/media/baileys/products/churros_imgP.png', 'Botella de BAILEYS sabor a churros 700 ml 17% Alc. Vol.','http://retailmi.elbyte.com.mx/media/baileys/products/churros_bg.jpg', [], ['http://retailmi.elbyte.com.mx/media/baileys/products/churros_receta01.mp4', 'http://retailmi.elbyte.com.mx/media/baileys/products/churros_receta02.mp4'], [] , value));
      }else if(value == '86767210029'){
        Navigator.of(getContext()).pushNamed('/product', arguments: ProductsArguments('BAILEYS original 1.75 l.', 'http://retailmi.elbyte.com.mx/media/baileys/products/original_imgP.png', 'Botella de BAILEYS 1.75 L 17% Alc. Vol.','http://retailmi.elbyte.com.mx/media/baileys/products/original_bg.jpg', ['http://retailmi.elbyte.com.mx/media/baileys/products/original_receta01.mp4', 'http://retailmi.elbyte.com.mx/media/baileys/products/original_receta02.mp4'], [], [] , value));
      }else if(value == '5011013100118'){
        Navigator.of(getContext()).pushNamed('/product', arguments: ProductsArguments('BAILEYS original 1 l.', 'http://retailmi.elbyte.com.mx/media/baileys/products/original_imgP.png', 'Botella de BAILEYS 700 ml 17% Alc. Vol.','http://retailmi.elbyte.com.mx/media/baileys/products/original_bg.jpg', ['http://retailmi.elbyte.com.mx/media/baileys/products/original_receta01.mp4', 'http://retailmi.elbyte.com.mx/media/baileys/products/original_receta02.mp4'], [], [] , value));
      }else if(value == '5011013933785'){
        Navigator.of(getContext()).pushNamed('/product', arguments: ProductsArguments('BAILEYS original 700 ml.', 'http://retailmi.elbyte.com.mx/media/baileys/products/original_imgP.png', 'Botella de BAILEYS 700 ml 17% Alc. Vol.','http://retailmi.elbyte.com.mx/media/baileys/products/original_bg.jpg', ['http://retailmi.elbyte.com.mx/media/baileys/products/original_receta01.mp4', 'http://retailmi.elbyte.com.mx/media/baileys/products/original_receta02.mp4'], [], [] , value));
      }else {

      }
    });
  }
}