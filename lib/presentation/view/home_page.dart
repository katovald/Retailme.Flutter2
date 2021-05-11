import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:retailmi/domain/repositories/data_auth_repo.dart';
import 'package:retailmi/presentation/controller/home_page_controller.dart';

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
      bottom: MediaQuery.of(context).size.height / 30,
      left: MediaQuery.of(context).size.width / 2 - MediaQuery.of(context).size.height / 8,
      child: GestureDetector(
        onTap: () {
          controller.startScan();
        },
        child: Container(
          width: MediaQuery.of(context).size.height/4,
          height: MediaQuery.of(context).size.height/4,
          alignment: FractionalOffset.center,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
            image: DecorationImage(
              image: AssetImage('assets/img/botonRosa.png'),
            )
          ),
        ),
      ),
    );
  });
}