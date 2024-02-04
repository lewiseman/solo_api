import 'package:flutter/foundation.dart';
import 'package:solo_api/common.dart';

final realmProvider = Provider((ref) {
  final config = Configuration.local(
    [APIFolder.schema, APIRoute.schema],
    shouldDeleteIfMigrationNeeded: kDebugMode,
  );
  final realm = Realm(config);
  return realm;
});
