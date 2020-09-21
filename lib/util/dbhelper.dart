import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:movie_app/model/Movie.dart';

class DbHelper {
  static final DbHelper _dbHelper = DbHelper._internal();
  String tblMovie = "movie";
  String colId = "id";
  String colTitle = "title";
  String colDescription = "description";
  String colDirector = "director";
  String colProducer = "producer";
  String colReleaseDate = "release_date";

  DbHelper._internal();

  factory DbHelper(){
    return _dbHelper;
  }

  static Database _db;

  Future<Database> get db async{
    if(_db == null){
      _db = await initializeDb();
    }
    else{
      return _db;
    }
  }

  Future<Database> initializeDb() async {
    Directory dir = await getApplicationDocumentsDirectory();
    String path = dir.path + "movies.db";
    var dbMovies = await openDatabase(path, version: 1, onCreate: _createDb);
    return dbMovies;
  }

  void _createDb(Database db, int newVersion) async {
    await db.execute(
      "CREATE TABLE $tblMovie($colId INTEGER PRIMARY KEY, $colTitle TEXT, "+
        "$colDescription TEXT, $colDirector TEXT, $colProducer TEXT, $colReleaseDate TEXT)"
    );
  }

  Future<int> insertMovie(Movie movie) async {
    Database db = await this.db;
    var result = await db.insert(tblMovie, movie.toMap());
    return result;//returns id inserted
  }
  
  Future<List> getMovies() async {
    Database db = await this.db;
    var result = await db.rawQuery("SELEC * FROM $tblMovie");
    return result;
  }

  Future<int> getCount() async{
    Database db = await this.db;
    var result = Sqflite.firstIntValue(
      await db.rawQuery("SELECT COUNT (*) FROM $tblMovie")
    );
    return result;
  }

  Future<int> updateMovie(Movie movie) async{
    var db = await this.db;
    var result = await db.update(tblMovie,movie.toMap(),
      where: "$colId = ?", whereArgs: [movie.id]);
    return result;
  }

  Future<int> deleteMovie(int id) async{
    var db = await this.db;
    int result = await db.rawDelete("DELETE FROM $tblMovie WHERE $colId = $id");
    return result;
  }
}