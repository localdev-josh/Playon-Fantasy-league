import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:playon/data/local_database/saved_teams.dart';
import 'package:playon/data/models/teams_model/teams.dart';
import 'package:playon/data/services/team_service.dart';
import '../../locator.dart';
import 'dart:math';

abstract class ABSTeamViewModel extends ChangeNotifier {
  List<TeamsItem> _f1TeamList = <TeamsItem>[];
  List<TeamsItem> get f1TeamList => _f1TeamList;
  set setF1Teams(List<TeamsItem> value);

  List<TeamsItem> _f1TeamListFull = <TeamsItem>[];
  List<TeamsItem> get f1TeamListFull => _f1TeamListFull;

  Future<void> fetchF1Teams();
  Future<void> fetchNextF1Team();
  Future<void> saveTeamToDB(TeamsItem teamsItem);
  Future<void> fetchTeamsFromDB();
  Future<void> deleteTeamFromDB(int id);
  Future<void> replicateTeam(TeamsItem termItem);
  Future<void> updateTeam(TeamsItem termItem);
}

class TeamViewModel extends ABSTeamViewModel {
  ABSTeamService _teamService = locator<ABSTeamService>();

  TeamViewModel();

  set setF1Teams(List<TeamsItem> value) {
    _f1TeamListFull = value;
    Random random = new Random();
    int randomNumber = random.nextInt(_f1TeamListFull.length - 1);
    saveTeamToDB(_f1TeamListFull[randomNumber]).whenComplete(() {
      notifyListeners();
    });
  }

  @override
  Future<void> fetchF1Teams() async {
      var result = await _teamService.fetchF1Teams();
      if(!result.error) {
        setF1Teams = result.data.teamItems;
      }
      return result;
  }

  @override
  Future<void> fetchNextF1Team() async {
    if(_f1TeamList.length != 3) {
      if(_f1TeamListFull.isEmpty) {
        await fetchF1Teams();
      } else {
        Random random = new Random();
        int randomNumber = random.nextInt(_f1TeamListFull.length - 1);
        await saveTeamToDB(_f1TeamListFull[randomNumber]);
      }
      notifyListeners();
    }
  }

  @override
  Future<void> fetchTeamsFromDB() async {
    await TeamsDatabaseProvider.db.getSavedTeams().then((value) async {
      _f1TeamList = value;
      notifyListeners();
    });
  }

  @override
  Future<void> deleteTeamFromDB(int id) async {
    await TeamsDatabaseProvider.db.delete(id).then((value) async {
      fetchTeamsFromDB();
    });
  }

  @override
  Future<void> replicateTeam(TeamsItem teamsItem) async {
    TeamsDatabaseProvider.db.insert(teamsItem).whenComplete(() async {
      await fetchTeamsFromDB();
    });
  }

  @override
  Future<void> updateTeam(TeamsItem teamsItem) async {
    TeamsDatabaseProvider.db.update(teamsItem).whenComplete(() async {
      await fetchTeamsFromDB();
    });
  }

  @override
  Future<void> saveTeamToDB(TeamsItem teamsItem) async {
    /// Add Team to local database
    await TeamsDatabaseProvider.db.getSavedTeams().then((value) async {
      if(value.isNotEmpty) {
        var teamIsContained = value.where((element) => element.name.toLowerCase() == teamsItem.name.toLowerCase());
        if (teamIsContained.isEmpty) {
          TeamsDatabaseProvider.db.insert(teamsItem).whenComplete(() async {
            _f1TeamList.add(teamsItem);
          });
        } else {
          await fetchNextF1Team();
        }
      } else {
        TeamsDatabaseProvider.db.insert(teamsItem).whenComplete(() async {
          _f1TeamList.add(teamsItem);
        });
      }
    });
  }
}
