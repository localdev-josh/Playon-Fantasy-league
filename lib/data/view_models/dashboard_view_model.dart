import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:playon/components/glitch_effect.dart';
import 'package:playon/data/services/dashboard_service.dart';
import '../../locator.dart';

abstract class ABSDashboardViewModel extends ChangeNotifier {

  /// Controls Top progress loader
  bool _shouldReload = false;
  bool get shouldReload => _shouldReload;
  set setShouldReload(bool value);

  /// Controls progress loader animation value
  double _progressValue;
  double get progressValue => _progressValue;
  set setProgressValue(double value);

  /// [_progressController] is the animation controller in charge of the top progress-bar
  AnimationController _progressController;
  AnimationController get progressController => _progressController;
  set setProgressLoader(AnimationController value);

  GlitchController _glitchController = GlitchController(duration: Duration(milliseconds: 400));
  GlitchController get glitchController => _glitchController;
  set setGlitchLoader(GlitchController value);
  playGlitchLoader();

  bool _controlLoader = false;
  bool get controlLoader => _controlLoader;
  set setControlLoader(bool value);

  @override
  void dispose() {
    super.dispose();
    _progressController.dispose();
    _glitchController.dispose();
  }
}

class DashboardViewModel extends ABSDashboardViewModel {
  ABSDashboardService _dashboardService = locator<ABSDashboardService>();

  DashboardViewModel();

  set setShouldReload(bool value) {
    _shouldReload = value;
    notifyListeners();
  }

  set setProgressValue(double value) {
    _progressValue = value;
    notifyListeners();
  }

  set setProgressLoader(AnimationController value) {
    _progressController = value;
    notifyListeners();
  }

  set setGlitchLoader(GlitchController value) {
    _glitchController = value;
    notifyListeners();
  }

  playGlitchLoader() {
    _glitchController
      ..reset()
      ..forward();
    notifyListeners();
  }

  set setControlLoader(bool value) {
    _controlLoader = value;
    notifyListeners();
  }
}
