import 'package:realm/realm.dart';
import 'package:solo_api/common.dart';

part 'model.g.dart';

@RealmModel()
class _APIFolder {
  @PrimaryKey()
  late ObjectId id;
  late String name;
}

@RealmModel()
class _APIRoute {
  @PrimaryKey()
  late ObjectId id;

  late final _APIFolder? folder;

  @Indexed(RealmIndexType.fullText)
  late String name;
  late String? url;
  late String? headers;
  late String method = 'GET';
  late String? body;
}
