import 'dart:convert';
import 'dart:async';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:retailmi/domain/repositories/register_exceptions.dart';

class HttpHelper {
  static Future<Map<String, dynamic>> invokeHttp(dynamic url, RequestType type, {Map<String, String> headers, dynamic body, Encoding encoding}) async {
    http.Response response;
    Map<String, dynamic> responseBody;
    try{
      response = await _invoke(Uri.parse(url), type, headers: headers, body: body, encoding: encoding);
    }catch(e){
      rethrow;
    }
    responseBody = jsonDecode(response.body);
    return responseBody;
  }

  static Future<List<dynamic>> invokeHttp2(dynamic url, RequestType type, {Map<String,String> headers, dynamic body, Encoding encoding}) async {
    http.Response response;
    List<dynamic> responseBody;

    try{
      response = await _invoke(Uri.parse(url), type, headers: headers, body: body, encoding: encoding);
    }on APIExceptions {
      rethrow;
    }on SocketException {
      rethrow;
    }

    responseBody = jsonDecode(response.body);
    return responseBody;
  }

  static Future<http.Response> _invoke(dynamic url, RequestType type, {Map<String, String> headers, dynamic body, Encoding encoding}) async {
    http.Response response;

    try{
      switch (type){
        case RequestType.get:
          response = await http.get(url, headers: headers);
          break;
        case RequestType.post:
          response = await http.post(url, headers: headers, body: body, encoding: encoding);
          break;
        case RequestType.put:
          response = await http.put(url, headers: headers, body: body, encoding: encoding);
          break;
        case RequestType.delete:
          response = await http.delete(url, headers: headers, body: body, encoding: encoding);
          break;
      }

      if (response.statusCode != 200){
        Map<String, dynamic> body = jsonDecode(response.body);

        throw APIExceptions(body['message'], response.statusCode, body['statusText']);
      }

      return response;
    } on http.ClientException {
      rethrow;
    } on SocketException catch(e){
      throw Exception(e.osError.message);
    } catch (error) {
      rethrow;
    }
  }
}

enum RequestType {get, post, put, delete}