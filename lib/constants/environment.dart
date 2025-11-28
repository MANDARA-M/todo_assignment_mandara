import 'package:flutter/foundation.dart';

class Environment {
  static const _apiUrlDevelopment = 'http://mhindu-api.centralindia.cloudapp.azure.com';
  //static const _apiUrlDevelopment = 'http://4.187.179.156:5000';
  static const _apiUrlProduction = 'https://prodhinduapi.azurewebsites.net';

  static String get _apiUrl => kDebugMode ? _apiUrlDevelopment : _apiUrlDevelopment;

  static String get apiUrl => _apiUrl;
}
