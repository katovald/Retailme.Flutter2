import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:ic_nominas/domain/repositories/data_auth_repo.dart';
import 'package:ic_nominas/presentation/controller/home_page_controller.dart';

class HomePage extends View{
  HomePage();

  @override
  HomePageState createState() => HomePageState();

}

class HomePageState extends ViewState<HomePage, HomePageController>{
  HomePageState() : super(HomePageController(DataAuthRepo()));

  @override
  // TODO: implement view
  Widget get view => Scaffold(
    key: globalKey,
    body: body,
  );

  Stack get body => Stack(
    children: <Widget>[
      background,
      camera
    ],
  );

  Widget get background => Container(
    width: MediaQuery.of(context).size.width,
    height: MediaQuery.of(context).size.height,
    decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/img/branch_bg.jpeg'),
            fit: BoxFit.fill
        )
    ),
  );

  Widget get camera => ControlledWidgetBuilder<HomePageController>(builder: (context, controller) {
    return Positioned(
      bottom: 50,
      left: MediaQuery.of(context).size.width / 2 - 160,
      child: GestureDetector(
        onTap: () {
          controller.startScan();
        },
        child: Container(
          width: 320.0,
          height: 50.0,
          alignment: FractionalOffset.center,
          decoration: BoxDecoration(
              color: Colors.black87,
              borderRadius: BorderRadius.circular(10.0)),
          child: Text("Escanear",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.w300,
                  letterSpacing: 0.4)
          ),
        ),
      ),
    );
  });
}