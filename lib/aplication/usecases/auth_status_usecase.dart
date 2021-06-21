import 'dart:async';

import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:retailmi/domain/repositories/auth_repo.dart';

class RegisterStatusUseCase extends UseCase<bool, void>{
  AuthRepo _authRepo;

  RegisterStatusUseCase(this._authRepo);

  @override
  Future<Stream<bool>> buildUseCaseStream(void params) async {
    final StreamController<bool> controller = StreamController();
    try{
      bool isAuth = await _authRepo.isRegister();
      controller.add(isAuth);
      controller.close();
    }catch (e){
      print(e);
      controller.addError(e);
    }

    return controller.stream;
  }

}