// ignore_for_file: constant_identifier_names

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBhelper {
  //! singleton pattern
  DBhelper._();

  static final DBhelper getInstance = DBhelper._();

  static final dbhelper = DBhelper.getInstance;

  // Todo:  constants for notes table
  static const NOTES_TABLE = 'usernotes';
  static const DB_NAME = 'notes.db';
  static const COLUMN_NOTES_ID = 'id';
  static const COLUMN_NOTES_TITLE = 'title';
  static const COLUMN_NOTES_DESCRIPTION = 'description';

  // Todo: constants for todos table
  static const TODO_TABLE = 'todos';
  static const COLUMN_TODO_ID = 'id';
  static const COLUMN_TODO_ITEMNAME = 'items';
  static const COLUMN_TODO_alerts = 'alerts';

  Database? db;

  // Todo: GEt and open database functions for setup
  Future<Database> getdatabase() async {
    db ??= await openDb();
    return db!;
  }

  Future<Database> openDb() async {
    String appDir = await getDatabasesPath();

    String path = join(appDir, DB_NAME);

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        db.execute(
            'CREATE TABLE $NOTES_TABLE ($COLUMN_NOTES_ID integer PRIMARY KEY AUTOINCREMENT, $COLUMN_NOTES_TITLE TEXT, $COLUMN_NOTES_DESCRIPTION TEXT)');

        db.execute(
            'CREATE TABLE $TODO_TABLE ($COLUMN_TODO_ID integer PRIMARY KEY AUTOINCREMENT, $COLUMN_TODO_ITEMNAME TEXT, $COLUMN_TODO_alerts TEXT)');
      },
    );
  }

  // Todo :  Notes DataBase Functions
  Future<bool> addNote({required String title, required String des}) async {
    try {
      var db = await getdatabase();
      int feedback = await db.insert(NOTES_TABLE,
          {COLUMN_NOTES_TITLE: title, COLUMN_NOTES_DESCRIPTION: des});
      return feedback > 0;
    } catch (e) {
      return false;
    }
  }

  Future<bool> updateNote(
      {required int id, required String title, required String des}) async {
    var db = await getdatabase();
    try {
      int feedback = await db.update(NOTES_TABLE,
          {COLUMN_NOTES_TITLE: title, COLUMN_NOTES_DESCRIPTION: des},
          where: "$COLUMN_NOTES_ID =$id");
      // print('value updated successfully$feedback');
      return feedback > 0;
    } catch (e) {
      return false;
    }
  }

  Future<bool> deleteNote({required List<int> id}) async {
    try {
      var db = await getdatabase();
      // print("sucess coming");
      String placeholder = List.filled(id.length, '?').join(',');
      int feedback = await db.delete(NOTES_TABLE,
          where: "$COLUMN_NOTES_ID IN ($placeholder)", whereArgs: id);
      // print("$feedback");

      return feedback > 0;
    } catch (e) {
      return false;
    }
  }

  Future<List<Map<String, dynamic>>> getAllNotes() async {
    var db = await getdatabase();

    List<Map<String, dynamic>> mdata = await db.query(NOTES_TABLE);
    return mdata;
  }

  Future<List<Map<String, dynamic>>> searchNotes(String keywords) async {
    var db = await getdatabase();

    List<Map<String, dynamic>> mdata = await db.query(NOTES_TABLE,
        where:
            '$COLUMN_NOTES_TITLE LIKE ? OR $COLUMN_NOTES_DESCRIPTION LIKE ? ',
        whereArgs: ['%$keywords%', '%$keywords%']);
    return mdata;
  }

  // todo: todos  DataBase functions

  //dont give me hint in this function
  Future<bool> addtodo(String textitems, String alerts) async {
    var db = await getdatabase();
    int feedback = await db.insert(TODO_TABLE,
        {COLUMN_TODO_ITEMNAME: textitems, COLUMN_TODO_alerts: alerts});
    return feedback > 0;
  }
}
