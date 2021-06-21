import 'package:flutter/material.dart';

abstract class AuthRepo {
  Future<void> getWebToken({@required String email, @required String password});

  Future<void> register({@required String sucursalId});

  Future<bool> isRegister();
}