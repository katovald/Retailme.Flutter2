import 'dart:async';

import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:retailmi/domain/repositories/data_auth_repo.dart';

class RegisterStatusUseCase extends UseCase<bool, void>{
  DataAuthRepo _authRepo;

  RegisterStatusUseCase(this._authRepo);

  @override
  Future<Stream<bool>> buildUseCaseStream(void params) async {
    final StreamController<bool> controller = StreamController();
    try{
      bool isAuth = await _authRepo.isRegister();
      if(isAuth){
        _authRepo.getBranchInfo();
      }
      controller.add(isAuth);
      controller.close();
    }catch (e){
      print(e);
      controller.addError(e);
    }

    return controller.stream;
  }

}

/// The parameters required for the [LoginUseCase]
class RegisterUseCaseParams {
  String _idBranch;

  RegisterUseCaseParams(this._idBranch);
}