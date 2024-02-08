import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

enum RequestType {
  get,
  post;

  @override
  toString() {
    return switch (this) {
      get => 'GET',
      post => 'POST',
    };
  }

  Future<http.Response> request({required String path}) {
    return switch (this) {
      RequestType.get => http.get(Uri.parse(path)),
      RequestType.post => http.post(Uri.parse(path)),
    };
  }

  static RequestType method(String method) {
    switch (method) {
      case 'GET':
        return RequestType.get;
      case 'POST':
        return RequestType.post;
      default:
    }
    return RequestType.get;
  }

  Widget icon({double? size}) {
    return Text(
      toString(),
      style: TextStyle(
        color: color,
        fontSize: size,
      ),
      maxLines: 1,
    );
  }

  Color get color {
    return switch (this) {
      RequestType.get => Colors.green,
      RequestType.post => const Color(0xFFA57C29),
    };
  }
}
