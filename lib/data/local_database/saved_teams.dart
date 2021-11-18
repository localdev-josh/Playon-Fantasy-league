import 'package:path/path.dart';
import 'package:playon/data/models/teams_model/teams.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

class TeamsDatabaseProvider {
  static const String TABLE_TEAM = "f1teams";
  static const String COLUMN_ID = "column_id";
  static const String COLUMN_UN_ID = "id";
  static const String COLUMN_NAME = "name";
  static const String COLUMN_SHORT_NAME = "short_name";
  static const String COLUMN_SLUG = "slug";
  static const String COLUMN_FOUNDED = "founded";
  static const String COLUMN_MANAGER = "manager";
  static const String COLUMN_ASSISTANT_MANAGER = "assistant_manager";
  static const String COLUMN_ABBREVIATION = "abbreviation";
  static const String COLUMN_JERSEY_IMAGE = "jersey_image";
  static const String COLUMN_TEAM_LOGO = "team_logo_image";
  static const String COLUMN_TEAM_BADGE = "team_badge_image";
  static const String COLUMN_SPORT_ID = "sport_id";
  static const String COLUMN_SHOW_MARKET_MODAL = "show_marketing_modal";
  static const String COLUMN_MARKET_MODAL_TEXT = "marketing_modal_text";

  TeamsDatabaseProvider._();

  static final TeamsDatabaseProvider db = TeamsDatabaseProvider._();

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
      join(dbPath, 'playonLocalDB.db'),
      version: 1,
      onCreate: (Database database, int version) async {
        await database.execute(
            "CREATE TABLE $TABLE_TEAM ("
                "$COLUMN_ID INTEGER PRIMARY KEY,"
                "$COLUMN_UN_ID TEXT,"
                "$COLUMN_NAME TEXT,"
                "$COLUMN_SHORT_NAME TEXT,"
                "$COLUMN_SLUG TEXT,"
                "$COLUMN_FOUNDED TEXT,"
                "$COLUMN_MANAGER TEXT,"
                "$COLUMN_ASSISTANT_MANAGER TEXT,"
                "$COLUMN_ABBREVIATION TEXT,"
                "$COLUMN_JERSEY_IMAGE TEXT,"
                "$COLUMN_TEAM_LOGO TEXT,"
                "$COLUMN_TEAM_BADGE TEXT,"
                "$COLUMN_SPORT_ID TEXT,"
                "$COLUMN_SHOW_MARKET_MODAL TEXT,"
                "$COLUMN_MARKET_MODAL_TEXT TEXT"
                ")"
        );
      },
    );
  }

  Future<List<TeamsItem>> getSavedTeams() async {
    final db = await database;
    var savedTeams = await db.query(TABLE_TEAM, columns: [
      COLUMN_ID,
      COLUMN_UN_ID,
      COLUMN_NAME,
      COLUMN_SHORT_NAME,
      COLUMN_SLUG,
      COLUMN_FOUNDED,
      COLUMN_MANAGER,
      COLUMN_ASSISTANT_MANAGER,
      COLUMN_ABBREVIATION,
      COLUMN_JERSEY_IMAGE,
      COLUMN_TEAM_LOGO,
      COLUMN_TEAM_BADGE,
      COLUMN_SPORT_ID,
      COLUMN_SHOW_MARKET_MODAL,
      COLUMN_MARKET_MODAL_TEXT,
    ]);

    List<TeamsItem> teamList = List<TeamsItem>();

    savedTeams.forEach((currentTeam) {
      TeamsItem teams = TeamsItem.fromSQMap(currentTeam);
      teamList.add(teams);
    });

    return teamList;
  }

  Future<TeamsItem> insert(TeamsItem teamsItem) async {
    print("started db ${teamsItem.name}");
    final db = await database;
    teamsItem.column_id = await db.insert(TABLE_TEAM, teamsItem.toLocalMap(), conflictAlgorithm: ConflictAlgorithm.replace);
    return teamsItem;
  }


  Future<int> delete(int id) async {
    final db = await database;

    return await db.delete(
      TABLE_TEAM,
      where: "column_id = ?",
      whereArgs: [id],
    );
  }

  Future<int> update(TeamsItem updateTeam) async {
    final db = await database;
    var savedId = updateTeam.column_id;

    print("Update saved after is ${updateTeam.name}");

    return await db.update(
      TABLE_TEAM,
      updateTeam.toLocalMap(),
      where: "column_id = ?",
      whereArgs: [savedId],
    );
  }
}
