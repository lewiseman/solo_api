import 'package:realm/realm.dart';

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
  late final String name;
}
