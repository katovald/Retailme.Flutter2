import 'dart:async';

import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:retailmi/domain/repositories/data_auth_repo.dart';

import '../../domain/models/user_model.dart';
import '../../domain/repositories/auth_repo.dart';

class RegisterDeviceUseCase extends CompletableUseCase<RegisterDeviceParams>{
  DataAuthRepo _authRepo;

  RegisterDeviceUseCase(this._authRepo);

  @override
  Future<Stream<bool>> buildUseCaseStream(RegisterDeviceParams params) async {
    final StreamController<bool> controller = StreamController();
    try{
      await _authRepo.register(sucursalId: params._idSucursal);
      await _authRepo.getBranchInfo();
      controller.add(true);
      controller.close();
    }catch (e){
      controller.addError(e);
    }
    return controller.stream;
  }
  
}

class RegisterDeviceParams {
  String _idSucursal;

  RegisterDeviceParams(this._idSucursal);
}