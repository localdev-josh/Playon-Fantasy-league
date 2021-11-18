import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:playon/data/local_database/saved_players.dart';
import 'package:playon/data/models/player_model/player.dart';
import 'package:playon/data/models/result.dart';
import 'package:playon/data/services/player_service.dart';
import '../../locator.dart';

abstract class ABSPlayerViewModel extends ChangeNotifier {
  List<PlayerItem> _f1PlayerList = <PlayerItem>[];
  List<PlayerItem> get f1PlayerList => _f1PlayerList;
  set setF1Player(List<PlayerItem> value);

  Future<Result<Player>> fetchF1Players();
  Future<void> savePlayerToDB(List<PlayerItem> teamsItem);
  Future<void> fetchPlayersFromDB();
}

class PlayerViewModel extends ABSPlayerViewModel {
  ABSPlayerService _playerService = locator<ABSPlayerService>();

  PlayerViewModel();

  set setF1Player(List<PlayerItem> value) {
    savePlayerToDB(value).whenComplete(() {
      fetchPlayersFromDB();
    });
  }

  @override
  Future<Result<Player>> fetchF1Players() async {
    var result = await _playerService.fetchF1Players();
    if(!result.error) {
      setF1Player = result.data.playerItems;
    }
    return result;
  }

  @override
  Future<void> fetchPlayersFromDB() async {
    PlayersDatabaseProvider.db.getSavedPlayers().then((value) async {
      _f1PlayerList = value;
      notifyListeners();
    });
  }

  @override
  Future<void> savePlayerToDB(List<PlayerItem> playerItems) async {
    await PlayersDatabaseProvider.db.getSavedPlayers().then((value) async {
      if(value.isEmpty) {
        for(var player in playerItems) {
          PlayersDatabaseProvider.db.insert(player);
        }
      } else {
        fetchPlayersFromDB();
      }
    });
  }
}
