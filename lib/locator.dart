import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:playon/utilities/app_strings.dart';
import 'data/services/dashboard_service.dart';
import 'data/services/player_service.dart';
import 'data/services/team_service.dart';
import 'navigator_service.dart';

GetIt locator = GetIt.instance;

void setUpLocator(){
  locator.registerLazySingleton(() => NavigationService());

  locator.registerLazySingleton<Dio>(() {
    BaseOptions options = new BaseOptions(
        baseUrl: AppStrings.baseUrl,
        receiveDataWhenStatusError: true,
        connectTimeout: 30*1000, // 30*1000
        receiveTimeout: 30*1000 // 30*1000
    );
    Dio dio = Dio(options);
    dio.interceptors.add(InterceptorsWrapper(
        onRequest: (RequestOptions options) async {
          print("Inside AppInterceptor");
          return options;
        },
        onError: (DioError error) {
          print("DIO error $error");
        },
        onResponse: (Response<dynamic> response) {
          print("response status ${response.statusCode}}");
          return response;
        }
    ));
    return dio;
  });


  locator.registerLazySingleton<ABSDashboardService>(() => DashboardService());
  locator.registerLazySingleton<ABSPlayerService>(() => PlayerService());
  locator.registerLazySingleton<ABSTeamService>(() => TeamService());
}