import 'package:dio/dio.dart';
import 'package:playon/data/models/player_model/player.dart';
import 'package:playon/data/models/result.dart';
import 'package:playon/data/dio_client.dart';
import '../../locator.dart';

abstract class ABSPlayerService {
  Future<Result<Player>> fetchF1Players();

}

class PlayerService extends ABSPlayerService {
  final Dio dio = locator<Dio>();

  @override
  Future<Result<Player>> fetchF1Players() async {
    Result<Player> result = Result(error: false);
    var url = "partner_games/f1/players";

    try {
      var response = await dio.get(url);
      var response1 = response.data;
      result.error = false;
      result.data = Player.fromJson(response1);
      return result;
    } on DioError catch (error) {
      result.errorMessage = ApiError.fromDioError(error).errorDescription;
      result.error = true;
      if(ApiError.fromDioError(error).errorCode != null) {
        result.errorCode = ApiError.fromDioError(error).errorCode;
      }
      return result;
    }
  }
}
