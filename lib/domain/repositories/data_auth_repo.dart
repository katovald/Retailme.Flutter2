import 'dart:convert';

import 'package:android_multiple_identifier/android_multiple_identifier.dart';
import 'package:flutter/cupertino.dart';
import 'package:retailmi/domain/helpers/constants.dart';
import 'package:retailmi/domain/helpers/http_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'auth_repo.dart';

class DataAuthRepo implements AuthRepo {
  static DataAuthRepo _instance;

  factory DataAuthRepo() => _instance;

  @override
  Future<void> getWebToken({String email, String password}) async {
    try {
      Map<String, dynamic> body = await HttpHelper.invokeHttp(Constants.tokenKey, RequestType.post, body: {
        "email":"otrebor.shm@gmail.com",
        "password":"qwerty12",
        "returnSecureToken":true
      });

      _saveToken(token: body['idToken']);
    }catch(e){
      rethrow;
    }
  }

  @override
  Future<bool> isRegister() async{
    try{
      SharedPreferences preferences = await SharedPreferences.getInstance();
      bool isAuth = preferences.getBool(Constants.isAuthenticatedKey);
      return isAuth ?? false;
    }catch(e){
      return false;
    }
  }

  @override
  Future<void> register({@required String sucursalId}) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String token = preferences.getString(Constants.tokenKey) ?? '';
    String serial = await AndroidMultipleIdentifier.serialCode;
    Map<String, dynamic> body = await HttpHelper.invokeHttp('${Constants.registerDevice}${sucursalId}/deviceId/$serial', RequestType.put, headers: {
      'Authorization': 'Bearer $token',
    });
    _saveBranchId(branch: body['id']);
  }

  @override
  Future<void> getBranchInfo() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String token = preferences.getString(Constants.tokenKey) ?? '';
    int branchId = preferences.getInt(Constants.sucursalInfo) ?? 0;
    Map<String, dynamic> body = await HttpHelper.invokeHttp(
        '${Constants.getBranchById}$branchId', RequestType.post, headers: {
      'Authorization': 'Bearer $token',
    });
    _saveBranchInfo(info: jsonEncode(body));
  }

  // save token in shared preferences
  void _saveToken({@required String token}) async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      await Future.wait([
        preferences.setString(Constants.tokenKey, token)
      ]);
    } catch(e){
      print(e);
    }
  }

  // save token in shared preferences
  void _saveBranchId({@required int branch}) async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      await Future.wait([
        preferences.setBool(Constants.isAuthenticatedKey, true),
        preferences.setInt(Constants.sucursalInfo, branch)
      ]);
    } catch(e){
      print(e);
    }
  }

  // save info in shared preferences
  void _saveBranchInfo({@required String info}) async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      await Future.wait([
        preferences.setString(Constants.sucursalInfo, info)
      ]);
    } catch(e){
      print(e);
    }
  }
  
}