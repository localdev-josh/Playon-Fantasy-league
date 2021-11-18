import 'dart:async';

import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:playon/components/glitch_effect.dart';
import 'package:playon/data/view_models/dashboard_view_model.dart';
import 'package:playon/screens/dashboard_controller/widgets/linear_progress_indicator.dart' as ProgressIndicator;
import 'package:playon/utilities/app_colors.dart';
import 'package:playon/utilities/app_strings.dart';
import 'package:provider/provider.dart';

class LoadingWIdget extends StatefulWidget {
  const LoadingWIdget({
    Key key, this.secondaryColor = true
  }) : super(key: key);

  final bool secondaryColor;


  @override
  _LoadingWIdgetState createState() => _LoadingWIdgetState();
}

class _LoadingWIdgetState extends State<LoadingWIdget>
    with TickerProviderStateMixin {
  AnimationController loaderController;
  ABSDashboardViewModel dashboardViewModel;
  double value;
  bool isLoading = true;
  Animation<double> animation;
  Animation<double> rotateAnimation;

  @override
  void initState() {
    loaderController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 700));
    loaderController.repeat(reverse: true);
    animation = Tween(begin: 0.4, end: 0.5).animate(loaderController)
      ..addListener(() {
        setState(() {});
      });

    rotateAnimation = Tween(begin: -0.2, end: 0.2).animate(loaderController)
      ..addListener(() {
        setState(() {});
      });

    super.initState();
  }

  void _startAnimation() {
    loaderController.stop();
    loaderController.reset();
    loaderController.repeat(
      period: Duration(milliseconds: 500),
    );
  }

  @override
  void dispose() {
    loaderController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 100,
      decoration: BoxDecoration(
        // color: Colors.transparent,
        shape: BoxShape.circle,
          color: widget.secondaryColor ? AppColors.kSecondaryColor : AppColors.kBottomNav,
          // borderRadius: BorderRadius.circular(7)
      ),
      child: Center(
        child: Stack(
          children: [
            Positioned(
              left: 0,
              right: 0,
              top: 0,
              bottom: 0,
              child: Transform.scale(
                scale: animation.value,
                child: Transform.rotate(
                    angle: rotateAnimation.value,
                    child: SvgPicture.asset("assets/images/logo-playon-micro.svg")),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LoadingWIdgetSmall extends StatefulWidget {
  const LoadingWIdgetSmall({
    Key key, this.secondaryColor = true, this.iconSize = 70,
    this.loaderOpacity = 1.0
  }) : super(key: key);

  final bool secondaryColor;
  final double iconSize;
  final double loaderOpacity;


  @override
  _LoadingWIdgetSmallState createState() => _LoadingWIdgetSmallState();
}

class _LoadingWIdgetSmallState extends State<LoadingWIdgetSmall>
    with SingleTickerProviderStateMixin {
  AnimationController controller;

  Animation<double> animation;

  @override
  void initState() {
    controller =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    controller.repeat(reverse: true);
    animation = Tween(begin: 0.8, end: 0.6).animate(controller)
      ..addListener(() {
        setState(() {});
      });

    super.initState();
  }

  void _startAnimation() {
    controller.stop();
    controller.reset();
    controller.repeat(
      period: Duration(seconds: 1),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      width: 30,
      decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(7)),
      child: Center(
        child: Stack(
          children: [
            // SizedBox(
            //   height: 45,
            //   width: 45,
            //   child: CircularProgressIndicator(
            //     strokeWidth: 3,
            //     valueColor: AlwaysStoppedAnimation<Color>(AppColors.kPrimaryColorLightGrey),
            //   ),
            // ),
            Positioned(
              left: 0,
              right: 0,
              top: 0,
              bottom: 0,
              child: Transform.scale(
                  scale: animation.value,
                  child: SvgPicture.asset(AppStrings.appLogoMicroSVG)),
            )
          ],
        ),
      ),
    );
  }
}