// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

import 'package:flutter_asset_management/model/asset_model.dart';

class HomeScreenController extends ChangeNotifier {
  late Database database;
  List<AssetModel> assetList = [];

  String tableName = 'assets';
  HomeScreenController() {
    initDB();
  }

  initDB() async {
    database = await openDatabase(
      'assets2.db',
      version: 1,
      onCreate: (db, version) async {
        await db.execute(
            'CREATE TABLE $tableName (id INTEGER PRIMARY KEY, title Text, description TEXT, serialNumber TEXT,assetType TEXT, isAvailable INTEGER, otherInfo TEXT)');
      },
    );
    fetchData();
  }

  fetchData() async {
    var dataMap = await database.query(tableName);
    assetList = dataMap.map((e) => AssetModel.fromMap(e)).toList();
    notifyListeners();
  }

  addData(AssetModel asset) async {
    await database.insert(tableName, asset.toMap());
    fetchData();
  }

  updateData(AssetModel assetModel) async {
    await database.update(tableName, assetModel.toMap(),
        where: 'id = ${assetModel.id}');
    fetchData();
  }

  deleteData(AssetModel assetModel) async {
    await database.delete(
      tableName,
      where: 'id =${assetModel.id}',
    );
    fetchData();
  }
}
