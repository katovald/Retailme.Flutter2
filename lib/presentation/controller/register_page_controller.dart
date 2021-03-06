import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:retailmi/domain/repositories/data_auth_repo.dart';

import '../helpers/constants.dart';
import '../presenter/register_page_presenter.dart';

class RegisterDevicePageController extends Controller{
  TextEditingController branchIdTextController;
  bool isLoading;
  RegisterDevicePagePresenter _registerPresenter;
  DataAuthRepo _authRepo;

  RegisterDevicePageController(authRepo) : _registerPresenter = RegisterDevicePagePresenter(authRepo) {
    branchIdTextController = TextEditingController();
    initListeners();
    _authRepo = DataAuthRepo();
  }

  @override
  void initListeners() {
    _registerPresenter.loginOnComplete = this._loginOnComplete;
    _registerPresenter.loginOnError = this._loginOnError;
  }

  void _loginOnComplete() {
    dismissLoading();
    Navigator.of(getContext()).pushReplacementNamed('/home');
  }

  void _loginOnError(e) {
    dismissLoading();
    showGenericSnackbar(getContext(), e.message, isError: true);
  }

  void regist() async {
    isLoading = true;
    refreshUI();
    await _authRepo.register(sucursalId: branchIdTextController.text);
    await _authRepo.getBranchInfo();
    Navigator.of(getContext()).pushReplacementNamed('/home');
  }

  void dismissLoading(){
    isLoading = false;
    refreshUI();
  }
}