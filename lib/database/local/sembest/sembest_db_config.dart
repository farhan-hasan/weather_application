import 'dart:developer';

import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

class SembestDbConfig {
  late DatabaseClient db;

  init() async {
    log("sembast db initialized");
    db = await _openDatabase();
    log(db.toString());
  }

  Future<Database> _openDatabase() async {
    final appDirectory = await getApplicationDocumentsDirectory();
    final dbPath = "${appDirectory.path}/weather_app.db";
    final database = await databaseFactoryIo.openDatabase(dbPath);
    return database;
  }
}
