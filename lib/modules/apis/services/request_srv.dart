import 'package:http/http.dart';
import 'package:solo_api/common.dart';

final apiRequestServiceProvider = StateNotifierProvider<ApiRequestNotifier,
    Map<String, AsyncValue<Response>>>(
  (ref) {
    return ApiRequestNotifier();
  },
);

class ApiRequestNotifier
    extends StateNotifier<Map<String, AsyncValue<Response>>> {
  ApiRequestNotifier() : super({});

  void sendRequest(APIRoute route) async {
    state = {...state, route.id.toString(): const AsyncLoading()};
    final response = await RequestType.get.request(
      path: 'https://jsonplaceholder.typicode.com/posts',
    );
    state = {...state, route.id.toString(): AsyncData(response)};
  }
}
