import 'dart:async';
import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animator/widgets/animator_widget.dart';
import 'package:playon/components/divider.dart';
import 'package:playon/data/view_models/dashboard_view_model.dart';
import 'package:playon/data/view_models/team_view_model.dart';
import 'package:playon/screens/dashboard_navigations/widgets/nav_header.dart';
import 'package:playon/screens/dashboard_navigations/widgets/teams_list_widget.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with AfterLayoutMixin<HomeScreen> {
  GlobalKey<AnimatorWidgetState> _animationKey = GlobalKey<AnimatorWidgetState>();
  ABSDashboardViewModel dashboardViewModel;
  ABSTeamViewModel teamViewModel;
  Timer _animationTimer;

  @override
  void afterFirstLayout(BuildContext context) {
    Future.delayed(Duration(seconds: 1)).whenComplete(() {
      dashboardViewModel.playGlitchLoader();
    });
    _animationTimer = Timer.periodic(Duration(seconds: 5), (timer) {
      dashboardViewModel.playGlitchLoader();
      if (_animationKey.currentState == null) {
        return;
      } else {
        _animationKey.currentState.forward();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    dashboardViewModel = Provider.of(context);
    teamViewModel = Provider.of(context);
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          NavHeader(navText: "Teams"),
          DividerWidget(),
          Expanded(
            child: TeamsListView(),
          ),
        ],
      ),
    );
  }
}
