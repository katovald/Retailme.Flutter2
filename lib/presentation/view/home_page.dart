import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:ic_nominas/presentation/controller/home_page_controller.dart';
import 'package:ic_nominas/presentation/helpers/constants.dart';

class HomePage extends View{
  final String title;

  HomePage({Key key, this.title}) : super(key: key);

  @override
  HomePageState createState() => HomePageState();

}

class HomePageState extends ViewState<HomePage, HomePageController>{
  HomePageState() : super(HomePageController());

  @override
  // TODO: implement view
  Widget get view => Scaffold(
    key: globalKey,
    body: SafeArea(child: body),
  );

  Stack get body => Stack(
    children: <Widget>[
      background,
      ListView(
        physics: PageScrollPhysics(),
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height / 30,
                          bottom: 10.0),
                      child: Image(
                        image: AssetImage(Resources.logo),
                        width: 100.0,
                      ),
                    ),
                    Text(
                      UIConstants.appName,
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 20.0,
                        fontWeight: FontWeight.w300,
                        letterSpacing: 2.0,
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height / 12),
                child: Container(
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ],
      ),
      Padding(
        padding: EdgeInsets.only(
            top: MediaQuery.of(context).size.height / 3),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 40.0),
              camera,
              SizedBox(height: 40.0),
              ongetCode
            ],
          ),
        ),
      ),
    ],
  );

  Container get background => Container(
    color: Color.fromRGBO(0, 0, 0, 0.8),
  );

  Widget get camera => ControlledWidgetBuilder<HomePageController>(builder: (context, controller) {
    return GestureDetector(
      onTap: () {
        FlutterBarcodeScanner.scanBarcode("#ff6666", "Cancelar", false, ScanMode.DEFAULT).then((value) =>
            print(value)
        );
      },
      child: Container(
        width: 320.0,
        height: 50.0,
        alignment: FractionalOffset.center,
        decoration: BoxDecoration(
            color: Color.fromRGBO(230, 38, 39, 1.0),
            borderRadius: BorderRadius.circular(20.0)),
        child: Text("Escanear",
            style: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
                fontWeight: FontWeight.w300,
                letterSpacing: 0.4)),
      ),
    );
  });

  Widget get ongetCode => ControlledWidgetBuilder<HomePageController>(builder: (context, controller) {
    return GestureDetector(
      onTap: () {
        controller.onGetCode();
      },
      child: Container(
        width: 320.0,
        height: 50.0,
        alignment: FractionalOffset.center,
        decoration: BoxDecoration(
            color: Color.fromRGBO(230, 38, 39, 1.0),
            borderRadius: BorderRadius.circular(20.0)),
        child: Text("Siguiente",
            style: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
                fontWeight: FontWeight.w300,
                letterSpacing: 0.4)),
      ),
    );
  });
}