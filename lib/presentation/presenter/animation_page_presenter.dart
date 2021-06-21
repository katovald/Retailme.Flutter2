import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:retailmi/aplication/usecases/auth_status_usecase.dart';

class AnimationPagePresenter extends Presenter{
  Function authStatusOnNext;
  Function authStatusOnComplete;

  RegisterStatusUseCase _registerStatusUseCase;

  AnimationPagePresenter(authRepo) {
    _registerStatusUseCase = RegisterStatusUseCase(authRepo);
  }

  void getAuthStatus() => _registerStatusUseCase.execute(_AnimationObserver(this));

  @override
  void dispose() => _registerStatusUseCase.dispose();
}

class _AnimationObserver implements Observer<bool>{
  AnimationPagePresenter _presenter;

  _AnimationObserver(this._presenter);

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