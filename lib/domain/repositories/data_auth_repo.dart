import 'package:shared_preferences/shared_preferences.dart';

import '../helpers/domain_constants.dart';
import '../models/user_model.dart';
import 'auth_repo.dart';

class DataAuthRepo implements AuthRepo {
  static DataAuthRepo _instance;

  factory DataAuthRepo() => _instance;

  @override
  Future<void> authenticate({String email, String password}) {
    // TODO: implement authenticate
    throw UnimplementedError();
  }

  @override
  Future<void> forgottenPass(String email) {
    // TODO: implement forgottenPass
    throw UnimplementedError();
  }

  @override
  Future<Sucursal> getCurrentLocation() {
    // TODO: implement getCurrentEmployee
    throw UnimplementedError();
  }

  @override
  Future<bool> isAuthenticated() async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      bool isAuthenticated = preferences.getBool(Constants.isAuthenticatedKey);
      return isAuthenticated ?? false;
    } catch (error) {
      return false;
    }
  }

  @override
  Future<void> logout() {
    // TODO: implement logout
    throw UnimplementedError();
  }

  @override
  Future<void> register({String firstName, String lastName, String email, String password}) {
    // TODO: implement register
    throw UnimplementedError();
  }
  
}