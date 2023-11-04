import 'dart:io';
import 'package:favorite_place_app/models/place.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspath;
import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqlite_api.dart';

Future<Database> getDatabase() async {
  final dbPath = await sql.getDatabasesPath();
  final db = await sql.openDatabase(
    path.join(dbPath, 'places.db'),
    onCreate: (db, version) {
      return db.execute('CREATE DATABASE user_places(id TEXT PRIMARY KEY,title TEXT,image TEXT)', []);
    },
    version: 1,
  );
  return db;
}

class ListPlacesNotifer extends StateNotifier<List<Place>> {
  ListPlacesNotifer() : super(const []);

  Future<void> loadPlaces() async {
    final db = await getDatabase();
    final data = await db.query('user_places');
    data.map((row) {
      Place(id: row['id'] as String, title: row['title'] as String, image: File(row['image'] as String));
    }).toList();
  }

  void addNewPlace(String title, File image) async {
    final appDir = await syspath.getApplicationDocumentsDirectory();
    final fileName = path.basename(image.path);

    final copiedImage = await image.copy('${appDir}/${fileName}');
    final newPlace = Place(title: title, image: copiedImage);

    final db = await getDatabase();

    db.insert('user_places', {
      'id': newPlace.id,
      'title': newPlace.title,
      'file': newPlace.image.path,
    });
    state = [newPlace, ...state];
  }
}

final listPlacesProvider = StateNotifierProvider<ListPlacesNotifer, List<Place>>((ref) => ListPlacesNotifer());
