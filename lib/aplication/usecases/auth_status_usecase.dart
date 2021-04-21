import 'dart:async';

import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:ic_nominas/domain/repositories/auth_repo.dart';

class AuthStatusUseCase extends UseCase<bool, void>{
  AuthRepo _authRepo;

  AuthStatusUseCase(this._authRepo);

  @override
  Future<Stream<bool>> buildUseCaseStream(void params) async {
    final StreamController<bool> controller = StreamController();
    try{
      bool isAuth = await _authRepo.isAuthenticated();
      controller.add(isAuth);
      controller.close();
    }catch (e){
      print(e);
      controller.addError(e);
    }

    return controller.stream;
  }

}