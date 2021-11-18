
import 'package:playon/data/local_database/saved_teams.dart';

class Teams {
  List<TeamsItem> teamItems = new List<TeamsItem>();

  Teams({this.teamItems});

  Teams.fromJson(Map<String, dynamic> json) {
    if (json['teams'] != null) {
      final Iterable resultIterate = json['teams'];
      teamItems = resultIterate
          .map((e) => TeamsItem.fromJson(e))
          .toList();
    }
  }
}

class TeamsItem {
  int column_id;
  int id;
  String name;
  String short_name;
  String slug;
  String founded;
  String manager;
  String assistant_manager;
  String abbreviation;
  String jersey_image;
  String team_logo_image;
  String team_badge_image;
  int sport_id;
  bool show_marketing_modal;
  String marketing_modal_text;

  TeamsItem({
        this.id,
        this.column_id,
        this.name,
        this.short_name,
        this.slug,
        this.founded,
        this.manager,
        this.assistant_manager,
        this.abbreviation,
        this.jersey_image,
        this.team_logo_image,
        this.team_badge_image,
        this.sport_id,
        this.show_marketing_modal,
        this.marketing_modal_text,
      });

  TeamsItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'] ?? "";
    short_name = json['short_name']  ?? "";
    slug = json['slug'] ?? "";
    founded = json['founded'] ?? "";
    manager = json['manager'] ?? "";
    assistant_manager = json['assistant_manager'] ?? "";
    abbreviation = json['abbreviation'] ?? "";
    jersey_image = json['jersey_image']['url'] ?? "";
    team_logo_image = json['team_logo_image']['url'] ?? "";
    team_badge_image = json['team_badge_image']['url'] ?? "";
    sport_id = json['sport_id'];
    show_marketing_modal = json['show_marketing_modal'];
    marketing_modal_text = json['marketing_modal_text'] ?? "";
  }

  Map<String, dynamic> toLocalMap() {
    var map = <String, dynamic>{
      TeamsDatabaseProvider.COLUMN_UN_ID: id.toString(),
      TeamsDatabaseProvider.COLUMN_NAME: name,
      TeamsDatabaseProvider.COLUMN_SHORT_NAME: short_name,
      TeamsDatabaseProvider.COLUMN_SLUG: slug,
      TeamsDatabaseProvider.COLUMN_FOUNDED: founded,
      TeamsDatabaseProvider.COLUMN_MANAGER: manager,
      TeamsDatabaseProvider.COLUMN_ASSISTANT_MANAGER: assistant_manager,
      TeamsDatabaseProvider.COLUMN_ABBREVIATION: abbreviation,
      TeamsDatabaseProvider.COLUMN_JERSEY_IMAGE: jersey_image,
      TeamsDatabaseProvider.COLUMN_TEAM_LOGO: team_logo_image,
      TeamsDatabaseProvider.COLUMN_TEAM_BADGE: team_badge_image,
      TeamsDatabaseProvider.COLUMN_SPORT_ID: sport_id,
      TeamsDatabaseProvider.COLUMN_SHOW_MARKET_MODAL: show_marketing_modal ? "1" : "0",
      TeamsDatabaseProvider.COLUMN_MARKET_MODAL_TEXT: marketing_modal_text,
    };
    if (column_id != null) {
      map[TeamsDatabaseProvider.COLUMN_ID] = column_id;
    }
    return map;
  }

  TeamsItem.fromSQMap(Map<String, dynamic> map) {
    column_id = map[TeamsDatabaseProvider.COLUMN_ID];
    id = map[int.tryParse(TeamsDatabaseProvider.COLUMN_UN_ID)];
    name = map[TeamsDatabaseProvider.COLUMN_NAME];
    short_name = map[TeamsDatabaseProvider.COLUMN_SHORT_NAME];
    slug = map[TeamsDatabaseProvider.COLUMN_SLUG];
    founded = map[TeamsDatabaseProvider.COLUMN_FOUNDED];
    manager = map[TeamsDatabaseProvider.COLUMN_MANAGER];
    assistant_manager = map[TeamsDatabaseProvider.COLUMN_ASSISTANT_MANAGER];
    abbreviation = map[TeamsDatabaseProvider.COLUMN_ABBREVIATION];
    jersey_image = map[TeamsDatabaseProvider.COLUMN_JERSEY_IMAGE];
    team_logo_image = map[TeamsDatabaseProvider.COLUMN_TEAM_LOGO];
    team_badge_image = map[TeamsDatabaseProvider.COLUMN_TEAM_BADGE];
    sport_id = int.tryParse(map[TeamsDatabaseProvider.COLUMN_SPORT_ID] ?? "0");
    show_marketing_modal = map[TeamsDatabaseProvider.COLUMN_SHOW_MARKET_MODAL] == "1" ? true : false;
    marketing_modal_text = map[TeamsDatabaseProvider.COLUMN_MARKET_MODAL_TEXT];
  }
}