import 'package:playon/data/local_database/saved_players.dart';

class Player {
  List<PlayerItem> playerItems = new List<PlayerItem>();

  Player({this.playerItems});

  Player.fromJson(Map<String, dynamic> json) {
    if (json['players'] != null) {
      final Iterable resultIterate = json['players'];
      playerItems = resultIterate
          .map((e) => PlayerItem.fromJson(e))
          .toList();
    }
  }
}

class PlayerItem {
  int column_id;
  int id;
  String firstName;
  String lastName;
  String teamName;
  String team_abbreviation;
  String position;
  int positionId;
  String positionAbbreviation;
  String headshot;
  bool isConstructor;

  PlayerItem({
    this.id,
    this.column_id,
    this.firstName,
    this.lastName,
    this.teamName,
    this.team_abbreviation,
    this.position,
    this.positionId,
    this.positionAbbreviation,
    this.headshot,
    this.isConstructor
  });

  PlayerItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'] ?? "";
    lastName = json['last_name']  ?? "";
    teamName = json['team_name'] ?? "";
    team_abbreviation = json['team_abbreviation'] ?? "";
    position = json['position'] ?? "";
    positionId = json['position_id'];
    positionAbbreviation = json['position_abbreviation'] ?? "";
    headshot = json['headshot']['profile'] ?? "";
    isConstructor = json['is_constructor'];
  }

  Map<String, dynamic> toLocalMap() {
    var map = <String, dynamic>{
      PlayersDatabaseProvider.COLUMN_UN_ID: id.toString(),
      PlayersDatabaseProvider.COLUMN_FIRST_NAME: firstName,
      PlayersDatabaseProvider.COLUMN_LAST_NAME: lastName,
      PlayersDatabaseProvider.COLUMN_TEAM_NAME: teamName,
      PlayersDatabaseProvider.COLUMN_TEAM_ABBREVIATION: team_abbreviation,
      PlayersDatabaseProvider.COLUMN_POSITION: position,
      PlayersDatabaseProvider.COLUMN_POSITION_ID: positionId,
      PlayersDatabaseProvider.COLUMN_POSITION_ABBREVIATION: positionAbbreviation,
      PlayersDatabaseProvider.COLUMN_HEADSHOT: headshot,
      PlayersDatabaseProvider.COLUMN_IS_CONSTRUCTOR: isConstructor ? "1" : "0"
    };
    if (column_id != null) {
      map[PlayersDatabaseProvider.COLUMN_ID] = column_id;
    }
    return map;
  }

  PlayerItem.fromSQMap(Map<String, dynamic> map) {
    column_id = map[PlayersDatabaseProvider.COLUMN_ID];
    id = map[int.tryParse(PlayersDatabaseProvider.COLUMN_UN_ID)];
    firstName = map[PlayersDatabaseProvider.COLUMN_FIRST_NAME];
    lastName = map[PlayersDatabaseProvider.COLUMN_LAST_NAME];
    teamName = map[PlayersDatabaseProvider.COLUMN_TEAM_NAME];
    team_abbreviation = map[PlayersDatabaseProvider.COLUMN_TEAM_ABBREVIATION];
    position = map[PlayersDatabaseProvider.COLUMN_POSITION];
    positionId = int.tryParse(map[PlayersDatabaseProvider.COLUMN_POSITION_ID] ?? "0");
    positionAbbreviation = map[PlayersDatabaseProvider.COLUMN_POSITION_ABBREVIATION];
    headshot = map[PlayersDatabaseProvider.COLUMN_HEADSHOT];
    isConstructor = map[PlayersDatabaseProvider.COLUMN_IS_CONSTRUCTOR] == "1" ? true : false;
  }
}