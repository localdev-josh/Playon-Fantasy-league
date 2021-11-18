import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:playon/data/view_models/dashboard_view_model.dart';
import 'package:playon/data/view_models/player_view_model.dart';
import 'package:playon/data/view_models/team_view_model.dart';
import 'package:playon/screens/dashboard_controller/widgets/linear_progress_indicator.dart' as ProgressIndicator;
import 'package:playon/screens/dashboard_navigations/home_screen.dart';
import 'package:playon/utilities/app_colors.dart';
import 'package:provider/provider.dart';

class HomeControllerScreen extends StatefulWidget {
  final int tab;
  const HomeControllerScreen({
    Key key,
    this.tab = 0}) : super(key: key);
  static Route<dynamic> route(
      {bool newSignUp = false, Function handleMoreClicked, int tab = 0}) {
    return MaterialPageRoute(
      builder: (_) => HomeControllerScreen(tab: tab),
      settings: RouteSettings(
        name: HomeControllerScreen().toStringShort(),
      ),
    );
  }

  @override
  _HomeControllerScreenState createState() => _HomeControllerScreenState();

}

class _HomeControllerScreenState extends State<HomeControllerScreen> with AfterLayoutMixin<HomeControllerScreen>, SingleTickerProviderStateMixin {
  ABSTeamViewModel teamViewModel;
  ABSPlayerViewModel playerViewModel;
  ABSDashboardViewModel dashboardViewModel;

  bool isLoading = false;
  int taps = 1;

  void startProgressAnimation() {
    dashboardViewModel.setProgressLoader = AnimationController(
      duration: const Duration(milliseconds: 5000),
      vsync: this,
    );
    dashboardViewModel.progressController.addListener(() {
      setState(() {
        dashboardViewModel.setProgressValue = dashboardViewModel.progressController.value;
      });
    });
  }

  @override
  void afterFirstLayout(BuildContext context) async {
    teamViewModel.fetchTeamsFromDB();
    playerViewModel.fetchPlayersFromDB().whenComplete(() {
      if(playerViewModel.f1PlayerList.isEmpty) {
        playerViewModel.fetchF1Players();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    teamViewModel = Provider.of(context);
    playerViewModel = Provider.of(context);
    dashboardViewModel = Provider.of(context);
    return Scaffold(
      backgroundColor: AppColors.kPrimaryColorLightGrey,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        bottom: false,
        child: Stack(
          children: [
            HomeScreen(),
            // Top loader
            !dashboardViewModel.shouldReload ? Container() : Align(
              alignment: Alignment.topCenter,
              child: Container(
                color: Colors.grey.withOpacity(0.2),
                padding: const EdgeInsets.only(top: 0),
                child: ProgressIndicator.LinearProgressIndicator(
                    key: Key("${dashboardViewModel.shouldReload}"),
                    value: dashboardViewModel.progressValue,
                    loopAround: dashboardViewModel.shouldReload,
                    showInCenter: dashboardViewModel.shouldReload,
                    backgroundColor: Colors.transparent,
                    valueColor: AlwaysStoppedAnimation<Color>(AppColors.kBlack2)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
