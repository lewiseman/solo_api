// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

// ignore_for_file: type=lint
class APIFolder extends _APIFolder
    with RealmEntity, RealmObjectBase, RealmObject {
  APIFolder(
    ObjectId id,
    String name,
  ) {
    RealmObjectBase.set(this, 'id', id);
    RealmObjectBase.set(this, 'name', name);
  }

  APIFolder._();

  @override
  ObjectId get id => RealmObjectBase.get<ObjectId>(this, 'id') as ObjectId;
  @override
  set id(ObjectId value) => RealmObjectBase.set(this, 'id', value);

  @override
  String get name => RealmObjectBase.get<String>(this, 'name') as String;
  @override
  set name(String value) => RealmObjectBase.set(this, 'name', value);

  @override
  Stream<RealmObjectChanges<APIFolder>> get changes =>
      RealmObjectBase.getChanges<APIFolder>(this);

  @override
  APIFolder freeze() => RealmObjectBase.freezeObject<APIFolder>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(APIFolder._);
    return const SchemaObject(ObjectType.realmObject, APIFolder, 'APIFolder', [
      SchemaProperty('id', RealmPropertyType.objectid, primaryKey: true),
      SchemaProperty('name', RealmPropertyType.string),
    ]);
  }
}

class APIRoute extends _APIRoute
    with RealmEntity, RealmObjectBase, RealmObject {
  APIRoute(
    ObjectId id,
    String name, {
    APIFolder? folder,
  }) {
    RealmObjectBase.set(this, 'id', id);
    RealmObjectBase.set(this, 'folder', folder);
    RealmObjectBase.set(this, 'name', name);
  }

  APIRoute._();

  @override
  ObjectId get id => RealmObjectBase.get<ObjectId>(this, 'id') as ObjectId;
  @override
  set id(ObjectId value) => RealmObjectBase.set(this, 'id', value);

  @override
  APIFolder? get folder =>
      RealmObjectBase.get<APIFolder>(this, 'folder') as APIFolder?;
  @override
  set folder(covariant APIFolder? value) => throw RealmUnsupportedSetError();

  @override
  String get name => RealmObjectBase.get<String>(this, 'name') as String;
  @override
  set name(String value) => throw RealmUnsupportedSetError();

  @override
  Stream<RealmObjectChanges<APIRoute>> get changes =>
      RealmObjectBase.getChanges<APIRoute>(this);

  @override
  APIRoute freeze() => RealmObjectBase.freezeObject<APIRoute>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(APIRoute._);
    return const SchemaObject(ObjectType.realmObject, APIRoute, 'APIRoute', [
      SchemaProperty('id', RealmPropertyType.objectid, primaryKey: true),
      SchemaProperty('folder', RealmPropertyType.object,
          optional: true, linkTarget: 'APIFolder'),
      SchemaProperty('name', RealmPropertyType.string,
          indexType: RealmIndexType.fullText),
    ]);
  }
}
