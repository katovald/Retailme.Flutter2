import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:ic_nominas/aplication/usecases/auth_status_usecase.dart';

class HomePagePresenter extends Presenter{
  Function authStatusOnNext;
  Function authStatusOnComplete;

  AuthStatusUseCase _authStatusUseCase;

  HomePagePresenter(authRepo) {
    _authStatusUseCase = AuthStatusUseCase(authRepo);
  }

  void getStatus() => _authStatusUseCase.execute(_LogedObserver(this));

  @override
  void dispose() {
    _authStatusUseCase.dispose();
  }
}

class _LogedObserver implements Observer<bool>{
  HomePagePresenter _presenter;

  _LogedObserver(this._presenter);

  @override
  void onComplete() {
    assert (_presenter.authStatusOnComplete != null);
    _presenter.authStatusOnComplete();
  }

  @override
  void onError(e) {
    assert (_presenter.authStatusOnNext != null);
    _presenter.authStatusOnNext(false);
    onComplete();
  }

  @override
  void onNext(isAuth) {
    assert (_presenter.authStatusOnNext != null);
    _presenter.authStatusOnNext(isAuth);
  }
}