import 'package:bordered_text/bordered_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:playon/animations/glitch_effect.dart';
import 'package:playon/data/view_models/dashboard_view_model.dart';
import 'package:playon/utilities/app_colors.dart';
import 'package:playon/utilities/app_strings.dart';
import 'package:provider/provider.dart';

class NavHeader extends StatelessWidget {
  final String navText;

  const NavHeader({Key key, this.navText = "Home"}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    /// Dashboard provider
    ABSDashboardViewModel dashboardViewModel = Provider.of(context);
    return Container(
      height: 60,
      width: MediaQuery.of(context).size.width,
      color: AppColors.kWhite,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 13),
      child: Row(
        children: [
          Container(
            // margin: EdgeInsets.only(top: 13),
            child: IntrinsicWidth(
              child: Material(
                color: Colors.transparent,
                child: GestureDetector(
                  onTap: () {
                    dashboardViewModel.setShouldReload = !dashboardViewModel.shouldReload;
                    dashboardViewModel.setProgressValue = dashboardViewModel.shouldReload ? null : 0;

                    // SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.top]);
                    // Navigator.pop(context);
                  },
                  child: Container(
                    decoration:  BoxDecoration(
                      color: Colors.transparent,
                    ),
                    height: 45,
                    width: 45,
                    child: Transform.translate(
                        offset: Offset(0,3),
                        child: Glitch(child: SvgPicture.asset(AppStrings.appLogoMicroSVG))),
                  ),
                ),
              ),
            ),
          ),
          IntrinsicWidth(
            child: Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.only(top: 4, left: 15),
                child: BorderedText(
                    strokeWidth: 0.4,
                    strokeColor: AppColors.kBlack,
                    child: Text(
                      '$navText',
                      textScaleFactor: 1,
                      textAlign: TextAlign.start,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        decoration: TextDecoration.none,
                        decorationColor: AppColors.kBlack,
                        color: AppColors.kBlack,
                        fontSize: 18,
                        letterSpacing: -0.6,
                        fontFamily: AppStrings.dmMedium,
                      ),
                    ))
            ),
          ),
        ],
      ),
    );
  }
}
