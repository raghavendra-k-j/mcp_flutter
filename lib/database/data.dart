import 'dart:convert';
import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

part 'data.g.dart';

@DriftDatabase(tables: [Persons])
class MyDatabase extends _$MyDatabase {
  MyDatabase() : super(_openConnection(),);

  @override
  int get schemaVersion => 2;
}


LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase.createInBackground(file, logStatements: true);
  });
}

@DataClassName('Person')
class Persons extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get motherName => text()();
  IntColumn get motherAge => integer().nullable()();
  TextColumn get mothersMobile => text().nullable()();
  TextColumn get fatherName => text().nullable()();
  TextColumn get fatherMobile => text().nullable()();
  TextColumn get address => text().nullable()();
  TextColumn get mctsOrRchId => text().nullable()();
  TextColumn get mchId => text().nullable()();

  TextColumn get lmp => text().nullable()();
  TextColumn get edd => text().nullable()();

  TextColumn get healthIssues => text().map(const StringListConverter()).withDefault(const Constant('[]'))();
  RealColumn get hemoglobin => real().nullable()();

  TextColumn get bankName => text().nullable()();
  TextColumn get branchName => text().nullable()();
  TextColumn get accountNumber => text().nullable()();
  TextColumn get ifscCode => text().nullable()();
}

class StringListConverter extends TypeConverter<List<String>, String> {
  const StringListConverter();

  @override
  List<String> fromSql(String? fromDb) {
    if (fromDb == null || fromDb.isEmpty) return [];
    return (jsonDecode(fromDb) as List).cast<String>();
  }

  @override
  String toSql(List<String>? value) {
    if (value == null || value.isEmpty) return '[]';
    return jsonEncode(value);
  }
}