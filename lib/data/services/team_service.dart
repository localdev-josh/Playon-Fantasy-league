import 'package:dio/dio.dart';
import 'package:playon/data/models/result.dart';
import 'package:playon/data/dio_client.dart';
import 'package:playon/data/models/teams_model/teams.dart';
import '../../locator.dart';

abstract class ABSTeamService {
  Future<Result<Teams>> fetchF1Teams();

}

class TeamService extends ABSTeamService {
  final Dio dio = locator<Dio>();

  @override
  Future<Result<Teams>> fetchF1Teams() async {
    Result<Teams> result = Result(error: false);
    var url = "partner_games/f1/teams";

    try {
      var response = await dio.get(url);
      var response1 = response.data;
      result.error = false;
      result.data = Teams.fromJson(response1);
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
