import 'package:flutter/material.dart';

abstract class AuthRepo {
  Future<void> getWebToken();

  Future<void> register({@required String sucursalId});

  Future<bool> isRegister();
}