import 'package:path/path.dart';
import 'package:playon/data/models/player_model/player.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

class PlayersDatabaseProvider {
  static const String TABLE_TEAM = "f1players";
  static const String COLUMN_ID = "column_id";
  static const String COLUMN_UN_ID = "id";
  static const String COLUMN_FIRST_NAME = "first_name";
  static const String COLUMN_LAST_NAME = "last_name";
  static const String COLUMN_TEAM_NAME = "team_name";
  static const String COLUMN_TEAM_ABBREVIATION = "team_abbreviation";
  static const String COLUMN_POSITION = "position";
  static const String COLUMN_POSITION_ID = "position_id";
  static const String COLUMN_POSITION_ABBREVIATION = "position_abbreviation";
  static const String COLUMN_HEADSHOT = "headshot";
  static const String COLUMN_IS_CONSTRUCTOR = "assistant_manager";

  PlayersDatabaseProvider._();

  static final PlayersDatabaseProvider db = PlayersDatabaseProvider._();

  Database _database;

  Future<Database> get database async {
    print("database getter called");

    if (_database != null) {
      return _database;
    }

    _database = await createDatabase();

    return _database;
  }

  Future<Database> createDatabase() async {
    String dbPath = await getDatabasesPath();

    return await openDatabase(
      join(dbPath, 'playonLocalDB1.db'),
      version: 1,
      onCreate: (Database database, int version) async {
        await database.execute(
            "CREATE TABLE $TABLE_TEAM ("
                "$COLUMN_ID INTEGER PRIMARY KEY,"
                "$COLUMN_UN_ID TEXT,"
                "$COLUMN_FIRST_NAME TEXT,"
                "$COLUMN_LAST_NAME TEXT,"
                "$COLUMN_TEAM_NAME TEXT,"
                "$COLUMN_POSITION TEXT,"
                "$COLUMN_POSITION_ID TEXT,"
                "$COLUMN_POSITION_ABBREVIATION TEXT,"
                "$COLUMN_TEAM_ABBREVIATION TEXT,"
                "$COLUMN_HEADSHOT TEXT,"
                "$COLUMN_IS_CONSTRUCTOR TEXT"
                ")"
        );
      },
    );
  }

  Future<List<PlayerItem>> getSavedPlayers() async {
    final db = await database;
    var savedTeams = await db.query(TABLE_TEAM, columns: [
      COLUMN_ID,
      COLUMN_UN_ID,
      COLUMN_FIRST_NAME,
      COLUMN_LAST_NAME,
      COLUMN_TEAM_NAME,
      COLUMN_POSITION,
      COLUMN_POSITION_ID,
      COLUMN_POSITION_ABBREVIATION,
      COLUMN_TEAM_ABBREVIATION,
      COLUMN_HEADSHOT,
      COLUMN_IS_CONSTRUCTOR,
    ]);

    List<PlayerItem> playerList = List<PlayerItem>();

    savedTeams.forEach((currentItem) {
      PlayerItem players = PlayerItem.fromSQMap(currentItem);
      playerList.add(players);
    });

    return playerList;
  }

  Future<PlayerItem> insert(PlayerItem playerItem) async {
    final db = await database;
    playerItem.column_id = await db.insert(TABLE_TEAM, playerItem.toLocalMap(), conflictAlgorithm: ConflictAlgorithm.replace);
    return playerItem;
  }


  Future<int> delete(int id) async {
    final db = await database;

    return await db.delete(
      TABLE_TEAM,
      where: "column_id = ?",
      whereArgs: [id],
    );
  }

  Future<int> update(PlayerItem updatePlayer) async {
    final db = await database;
    var savedId = updatePlayer.column_id;

    return await db.update(
      TABLE_TEAM,
      updatePlayer.toLocalMap(),
      where: "column_id = ?",
      whereArgs: [savedId],
    );
  }
}
