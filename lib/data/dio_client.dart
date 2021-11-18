import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ApiError {
  final int errorCode;
  final String errorDescription;

  ApiError({@required this.errorCode, @required this.errorDescription});

  factory ApiError.fromDioError(DioError error) {
    String description = '';

    switch (error.type) {
      case DioErrorType.CONNECT_TIMEOUT:
      case DioErrorType.SEND_TIMEOUT:
        description =
        "Connection timeout with API server failed due to internet connection, please try again";
        break;
      case DioErrorType.RECEIVE_TIMEOUT:
        description = "Receive timeout with API server, please try again";
        break;
      case DioErrorType.RESPONSE:
        description = extractDescriptionFromResponse(error.response);
        break;
      case DioErrorType.CANCEL:
        description = "API request canceled, please try again";
        break;
      case DioErrorType.DEFAULT:
        if(error.error.runtimeType == SocketException) {
          description = "Network error! Please connect to the internet and try again";
        } else {
          description = "Sorry, we are unable to complete your request at the moment. Please try again later";
        }
        break;
    }
    print("Error code ${error?.response?.statusCode}");
    print("Error description $description");
    return ApiError(
        errorCode: error?.response?.statusCode, errorDescription: description);
  }

  static String extractDescriptionFromResponse(Response response) {
    if(response.statusCode == 404) {
      return "Sorry, we are unable to reach this service at the moment, please try again later";
    } else {
      if (response?.data != null && response.data['message'] != null) {
        return response.data['message'] as String;
      } else {
        return "Your request cannot be completed at the moment. Please try again later";
      }
    }
  }

  // Navigate without context
  // locator<NavigationService>().navigateTo(TemporaryLoginScreen.route());
}