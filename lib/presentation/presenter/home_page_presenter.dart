import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:ic_nominas/aplication/usecases/auth_status_usecase.dart';
import 'package:ic_nominas/aplication/usecases/mech_use_case.dart';

class HomePagePresenter extends Presenter{
  Function getInteractions;
  Function initMultimedia;

  MechanicalUseCase _authStatusUseCase;

  HomePagePresenter(authRepo) {
    _authStatusUseCase = MechanicalUseCase();
  }

  void getStatus() => _authStatusUseCase.execute(_MechanicalObserver(this));

  @override
  void dispose() {
    _authStatusUseCase.dispose();
  }
}

class _MechanicalObserver implements Observer<bool>{
  HomePagePresenter _presenter;

  _MechanicalObserver(this._presenter);

  @override
  void onComplete() {

  }

  @override
  void onError(e) {

  }

  @override
  void onNext(isAuth) {

  }
}