import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

import '../helpers/constants.dart';
import '../presenter/login_page_presenter.dart';

class LoginPageController extends Controller{
  TextEditingController emailTextController;
  TextEditingController passwordTextController;
  bool isLoading;
  LoginPagePresenter _loginPresenter;

  LoginPageController(authRepo) : _loginPresenter = LoginPagePresenter(authRepo) {
    emailTextController = TextEditingController();
    passwordTextController = TextEditingController();
    initListeners();
  }

  @override
  void initListeners() {
    _loginPresenter.loginOnComplete = this._loginOnComplete;
    _loginPresenter.loginOnError = this._loginOnError;
  }

  void _loginOnComplete() {
    dismissLoading();
    Navigator.of(getContext()).pushReplacementNamed('home');
  }

  void _loginOnError(e) {
    dismissLoading();
    showGenericSnackbar(getContext(), e.message, isError: true);
  }

  void login() async {
    //isLoading = true;
    //refreshUI();
    //_loginPresenter.login(email: emailTextController.text, pass: passwordTextController.text);
    isLoading = false;
    Navigator.of(getContext()).pushReplacementNamed('/home');
  }

  void dismissLoading(){
    isLoading = false;
    refreshUI();
  }

  void register() {
    Navigator.of(getContext()).pushNamed('/register');
  }

  void forgotPassword() {
    Navigator.of(getContext()).pushNamed('/forgotPw');
  }
}