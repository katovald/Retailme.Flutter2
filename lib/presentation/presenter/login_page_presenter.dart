import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

import '../../aplication/usecases/login_use_case.dart';
import '../../domain/repositories/auth_repo.dart';

class LoginPagePresenter extends Presenter{
  AuthRepo _authRepo;
  LoginUseCase _loginUseCase;

  Function loginOnComplete;
  Function loginOnError;

  LoginPagePresenter(this._authRepo) {
    _loginUseCase = LoginUseCase(_authRepo);
  }

  @override
  void dispose() {
    _loginUseCase.dispose();
  }

  void login({@required String email, @required String pass}) {
    _loginUseCase.execute(_LoginUserCaseObserver(this), LoginUseCaseParams(email, pass));
  }
}

class _LoginUserCaseObserver implements Observer<void> {
  // The above presenter
  LoginPagePresenter _loginPresenter;

  _LoginUserCaseObserver(this._loginPresenter);

  /// implement if the `Observable` emits a value
  void onNext(ignore) {}

  /// Login is successfull, trigger event in [LoginController]
  void onComplete() {
    // any cleaning or preparation goes here
    _loginPresenter.loginOnComplete();

  }

  /// Login was unsuccessful, trigger event in [LoginController]
  void onError(e) {
    // any cleaning or preparation goes here
    if (_loginPresenter.loginOnError != null) {
      _loginPresenter.loginOnError(e);
    }
  }
}