import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';

import '../../domain/repositories/data_auth_repo.dart';
import '../controller/login_page_controller.dart';
import '../helpers/constants.dart';

class LoginPage extends View {
  LoginPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  LoginPageViewState createState() => LoginPageViewState();
}

class LoginPageViewState extends ViewState<LoginPage, LoginPageController> {
  static const String emailPrompt = 'Correo';
  static const String passwordPrompt = 'Password';
  static const String loginButtonText = 'Inicio';
  static const String forgotPassswordButtonText = '¿Olvidaste la contraseña?';
  static const String registerButtonText = 'Registro';

  final FocusNode _emailFocus;
  final FocusNode _passFocus;

  LoginPageViewState() : _emailFocus = FocusNode(), _passFocus = FocusNode(), super(LoginPageController(DataAuthRepo()));

  @override
  Widget get view {
    return Scaffold(
        key: globalKey,
        body: ProgressHUD(
            child: body,
            indicatorColor: UIConstants.progressBarColor,));
  }

  Stack get body => Stack(
    children: <Widget>[
      background,
      dataCard,
    ],
  );

  Widget get dataCard => ListView(
    physics: PageScrollPhysics(),
    children: <Widget>[
      Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height / 8,
                      bottom: 10.0),
                  child: Container(
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      color: Colors.redAccent,
                      image: DecorationImage(
                        image: AssetImage('assets/img/logo.jpeg'),
                        fit: BoxFit.fill,
                      )
                    ),
                  ),
                ),
                Text(
                  UIConstants.appName,
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 32.0,
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: emailField,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: passwordField,
                  ),
                  SizedBox(height: 40.0),
                  loginButton,
                ],
              ),
            ),
          ),
        ],
      ),
    ],
  );

  Widget get background => Positioned(
    top: 0.0,
    left: 0.0,
    right: 0.0,
    height: MediaQuery.of(context).size.height,
    child: Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Color.fromRGBO(18, 168, 237, 1.0),
              Color.fromRGBO(18, 56, 237, 1.0),
              Color.fromRGBO(56, 18, 237, 1.0),
              Color.fromRGBO(116, 18, 237, 1.0)
            ]
        ),
      ),
    ),
  );

  // Fields and Buttons

  /// Email input field
  Widget get emailField => Container(
    width: MediaQuery.of(context).size.width / 3,
      child: TextField(
        decoration: InputDecoration(
          icon: Icon(Icons.account_circle),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.white70,
            )
          ),
          labelText: "Supervisor",
        ),
      )
  );

  /// Password input field
  Widget get passwordField => Container(
      width: MediaQuery.of(context).size.width / 3,
      child: TextField(
        obscureText: true,
        decoration: InputDecoration(
          icon: Icon(Icons.lock),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.white70,
            )
          ),
          suffixIcon: Icon(Icons.remove_red_eye),
          labelText: "Contraseña"
        ),
      )
  );

  Widget get loginButton => ControlledWidgetBuilder<LoginPageController>(builder: (context, controller) {
    return GestureDetector(
      onTap: () {
        controller.login();
      },
      child: Container(
        width: 320.0,
        height: 50.0,
        alignment: FractionalOffset.center,
        decoration: BoxDecoration(
            color: Colors.black87,
            borderRadius: BorderRadius.circular(10.0)),
        child: Text(loginButtonText,
            style: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
                fontWeight: FontWeight.w300,
                letterSpacing: 0.4)
        ),
      ),
    );
  });
}