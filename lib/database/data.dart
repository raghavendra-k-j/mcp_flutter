import 'dart:convert';
import 'dart:io';

import 'package:dart_phonetics/dart_phonetics.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

part 'data.g.dart';

@DriftDatabase(tables: [MCPCards])
class MyDatabase extends _$MyDatabase {
  MyDatabase() : super(_openConnection(),);

  @override
  int get schemaVersion => 3;
}


LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase.createInBackground(file, logStatements: true);
  });
}

@DataClassName('MCPCard')
class MCPCards extends Table {
  IntColumn get id => integer().autoIncrement()();
  DateTimeColumn get createdAt => dateTime()();

  TextColumn get motherName => text()();
  TextColumn get motherNamePhonetic => text().nullable()();
  IntColumn get motherAge => integer().nullable()();
  TextColumn get mothersMobile => text().nullable()();

  TextColumn get fatherName => text().nullable()();
  TextColumn get fatherMobile => text().nullable()();
  TextColumn get address => text().nullable()();
  TextColumn get mctsOrRchId => text().nullable()();

  DateTimeColumn get lmp => dateTime().nullable()();
  DateTimeColumn get edd => dateTime().nullable()();

  TextColumn get healthIssues => text().map(const StringListConverter()).withDefault(const Constant('[]'))();
  RealColumn get hemoglobin => real().nullable()();
  IntColumn get sBp => integer().nullable()();
  IntColumn get dBp => integer().nullable()();

  TextColumn get bankName => text().nullable()();
  TextColumn get branchName => text().nullable()();
  TextColumn get accountNumber => text().nullable()();
  TextColumn get ifscCode => text().nullable()();
}

class PhoneticHelper {

  static String? generatePhonetic(String s) {
    final nysiisModified = Nysiis.withOptions(maxLength: 0, enableModified: true);
    PhoneticEncoding? phoneticEncoding = nysiisModified.encode(s);
    if(phoneticEncoding != null) {
      return phoneticEncoding.primary;
    }
    else {
      return null;
    }
  }

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