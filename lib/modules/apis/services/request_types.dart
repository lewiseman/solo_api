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
}
