import 'dart:convert';

import 'package:android_multiple_identifier/android_multiple_identifier.dart';
import 'package:flutter/cupertino.dart';
import 'package:retailmi/domain/helpers/constants.dart';
import 'package:retailmi/domain/helpers/http_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'auth_repo.dart';

class DataAuthRepo implements AuthRepo {
  DataAuthRepo();

  @override
  Future<void> getWebToken() async {
    try {
      Map<String, dynamic> body = await HttpHelper.invokeHttp(Constants.identity, RequestType.post, body: jsonEncode({"email":"jokgrimally@gmail.com","password":"L3ch4t32","returnSecureToken":true}));
      _saveToken(token: body['idToken']);
    }catch(e){
      rethrow;
    }
  }

  @override
  Future<bool> isRegister() async{
    try{
      SharedPreferences preferences = await SharedPreferences.getInstance();
      bool isAuth = preferences.getBool(Constants.isAuthenticatedKey) ?? false;
      int branchId = preferences.getInt(Constants.sucursalId) ?? 0;
      return isAuth && (branchId != 0);
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
    try{
      SharedPreferences preferences = await SharedPreferences.getInstance();
      String token = preferences.getString(Constants.tokenKey) ?? '';
      int branchId = preferences.getInt(Constants.sucursalId) ?? 0;
      Map<String, dynamic> body = await HttpHelper.invokeHttp(
          '${Constants.getBranchById}$branchId', RequestType.get, headers: {
        'Authorization': 'Bearer $token',
      });
      _saveBranchInfo(info: jsonEncode(body));
    }catch(e){

    }
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
        preferences.setInt(Constants.sucursalId, branch)
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