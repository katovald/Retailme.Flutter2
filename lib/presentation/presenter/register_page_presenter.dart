import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:retailmi/domain/repositories/data_auth_repo.dart';
import 'package:retailmi/presentation/controller/register_page_controller.dart';

import '../../aplication/usecases/register_use_case.dart';
import '../../domain/repositories/auth_repo.dart';

class RegisterDevicePagePresenter extends Presenter{
  DataAuthRepo _authRepo;
  RegisterDeviceUseCase _registerUseCase;

  Function loginOnComplete;
  Function loginOnError;

  RegisterDevicePagePresenter(this._authRepo) {
    _registerUseCase = RegisterDeviceUseCase(_authRepo);
  }

  @override
  void dispose() {
    _registerUseCase.dispose();
  }

  void register({@required String id_sucursal}) {
    _registerUseCase.execute(_RegistereCaseObserver(this), RegisterDeviceParams(id_sucursal));
  }
}

class _RegistereCaseObserver implements Observer<void> {
  // The above presenter
  RegisterDevicePagePresenter _registerPresenter;

  _RegistereCaseObserver(this._registerPresenter);

  void onNext(ignore) {}

  /// Register is successfull, trigger event in [RegisterDevicePageController]
  void onComplete() {
    _registerPresenter.loginOnComplete();
  }

  /// Login was unsuccessful, trigger event in [LoginController]
  void onError(e) {
    // any cleaning or preparation goes here
    if (_registerPresenter.loginOnError != null) {
      _registerPresenter.loginOnError(e);
    }
  }
}