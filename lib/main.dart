import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:playon/screens/dashboard_controller/home_controller_screen.dart';
import 'package:playon/utilities/app_colors.dart';
import 'package:playon/utilities/app_strings.dart';
import 'package:provider/provider.dart';
import 'dart:ui' as ui;
import 'animations/loading.dart';
import 'data/view_models/dashboard_view_model.dart';
import 'data/view_models/player_view_model.dart';
import 'data/view_models/team_view_model.dart';
import 'locator.dart';
import 'navigator_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Paint.enableDithering = true;
  RenderErrorBox.backgroundColor = Colors.transparent;
  RenderErrorBox.textStyle = ui.TextStyle(color: Colors.transparent);
  // Initialize service locator
  setUpLocator();
  runApp(MyApp());
  configLoading();
}

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 500)
    ..indicatorType = EasyLoadingIndicatorType.circle
    ..loadingStyle = EasyLoadingStyle.custom
    ..indicatorSize = 50.0
    ..radius = 0.0
    ..infoWidget = LoadingWIdget()
    ..indicatorWidget = LoadingWIdget()
    ..progressColor = Colors.yellow
    ..backgroundColor = Colors.transparent
    ..indicatorColor = Colors.yellow
    ..textColor = Colors.yellow
    ..maskType = EasyLoadingMaskType.custom
    ..maskColor = Colors.black.withOpacity(0.2)
    ..userInteractions = false;
}

class MyApp extends StatefulWidget {

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ABSDashboardViewModel>(
          create: (_) => DashboardViewModel(),
        ),
        ChangeNotifierProvider<ABSPlayerViewModel>(
          create: (_) => PlayerViewModel(),
        ),
        ChangeNotifierProvider<ABSTeamViewModel>(
          create: (_) => TeamViewModel(),
        ),
      ],
      child: MaterialApp(
        title: 'Playon',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: AppStrings.dmRegular,
          primarySwatch: Colors.blue,
          primaryColor: AppColors.kSecondaryColor,
          indicatorColor: Colors.red,
          bottomSheetTheme: BottomSheetThemeData(backgroundColor: Colors.transparent),
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        builder: EasyLoading.init(),
        navigatorKey: locator<NavigationService>().navigatorKey,
        home: HomeApp(),
      ),
    );
  }
}

class HomeApp extends StatefulWidget {
  @override
  _HomeAppState createState() => _HomeAppState();
}

class _HomeAppState extends State<HomeApp> with WidgetsBindingObserver {

  @override
  void initState() {
    super.initState();
    if(Platform.isAndroid) {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
          statusBarColor: AppColors.kWhite,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.dark,
          systemNavigationBarColor: AppColors.kWhite,
          systemNavigationBarIconBrightness: Brightness.dark));
    }
  }

  @override
  Widget build(BuildContext context) {
    return HomeControllerScreen();
  }
}
