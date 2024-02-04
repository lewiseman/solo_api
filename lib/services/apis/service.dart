import 'package:solo_api/common.dart';

final apiServiceProvider = StateNotifierProvider<ApiNotifier, List>((ref) {
  return ApiNotifier();
});

class ApiNotifier extends StateNotifier<List> {
  ApiNotifier() : super([]);
}
