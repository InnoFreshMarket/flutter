import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fermer/core/utils/server_settings.dart';
import 'package:fermer/core/utils/token_api.dart';
import 'auth_manager.dart';
import 'package:dio/dio.dart';

class ServerApi {
  final _baseUrl = ServerSettings.baseUrl;
  final _dio = Dio();

  Future<Response> post(String? relativeUrl, String? accessToken,
      Map<dynamic, dynamic> data) async {
    TokenApi.refreshTokens();

    var fullUrl = "$_baseUrl$relativeUrl";
    var response = await _dio.request(fullUrl,
        options: Options(
          method: "POST",
          headers: {"Authorization": "Bearer $accessToken"}
        ),
        data: data);
    return response;
  }

  Future<Response> get(String? relativeUrl, String? accessToken) async {
    await TokenApi.refreshTokens();
    var response;
    var fullUrl = "$_baseUrl$relativeUrl";
    try {
      response = await _dio.get(fullUrl,
          options: Options(
              method: "GET",
              headers: {"Authorization": "Bearer $accessToken"}));
    } on DioError catch (e) {
      print(e.message);
    }
    return response;
  }

  Future<dynamic> getSelfInfo() async {
    var access = await TokenApi.getAccessToken();
    var refresh = await TokenApi.getRefreshToken();

    var response = await get("/users/me/", access);
    return response.data;
  }

  Future<dynamic> getId() async {
    var access = await TokenApi.getAccessToken();
    var refresh = await TokenApi.getRefreshToken();

    var response;
    try {
      response = await get("/users/getId/", access);
      print(response);
    } catch (e) {
      print(e.toString());
    }
    return response;
  }
}
