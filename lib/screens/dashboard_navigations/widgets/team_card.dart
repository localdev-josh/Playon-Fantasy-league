import 'package:achievement_view/achievement_view.dart';
import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:playon/animations/loading.dart';
import 'package:playon/components/divider.dart';
import 'package:playon/animations/splash_tap.dart';
import 'package:playon/data/models/player_model/player.dart';
import 'package:playon/data/models/teams_model/teams.dart';
import 'package:playon/data/view_models/dashboard_view_model.dart';
import 'package:playon/data/view_models/player_view_model.dart';
import 'package:playon/data/view_models/team_view_model.dart';
import 'package:playon/screens/dashboard_navigations/widgets/player_card.dart';
import 'package:playon/screens/dashboard_navigations/widgets/rename_team.dart';
import 'package:playon/utilities/app_colors.dart';
import 'package:playon/utilities/app_margin.dart';
import 'package:playon/utilities/app_strings.dart';
import 'package:provider/provider.dart';

class TeamCard extends StatefulWidget {
  final TeamsItem teamsItem;
  final bool removePadding;
  final int index;

  const TeamCard({Key key, this.teamsItem, this.removePadding = false, this.index = 1}) : super(key: key);
  @override
  _TeamCardState createState() => _TeamCardState();
}

class _TeamCardState extends State<TeamCard> with AfterLayoutMixin<TeamCard> {
  ABSTeamViewModel teamViewModel;
  ABSPlayerViewModel playerViewModel;
  bool menuIsOpen = false;
  bool menuIsFaded = false;
  bool playerIsLoading = false;
  List<PlayerItem> _f1PlayerList = <PlayerItem>[];

  @override
  void afterFirstLayout(BuildContext context) async {
    playerIsLoading = true;
    if(playerViewModel.f1PlayerList.isEmpty) {
      var result = await playerViewModel.fetchF1Players();
      playerIsLoading = false;
      if(!result.error) {
        for(var player in result.data.playerItems) {
          if(player.team_abbreviation.contains(widget.teamsItem.abbreviation)) {
            _f1PlayerList.add(player);
          }
        }
      }
    } else {
      playerIsLoading = false;
      for(var player in playerViewModel.f1PlayerList) {
        if(player.team_abbreviation.contains(widget.teamsItem.abbreviation)) {
          _f1PlayerList.add(player);
        }
      }
      setState(() {});
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ABSDashboardViewModel dashboardViewModel = Provider.of(context);
    teamViewModel = Provider.of(context);
    playerViewModel = Provider.of(context);
    return LayoutBuilder(
        builder: (context, constraints) {
          return Container(
            height: constraints.minHeight - 100,
            width: MediaQuery.of(context).size.width - 40,
            margin: EdgeInsets.only(right: widget.removePadding ? 0 : 30),
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.kBlack2,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        spreadRadius: 3,
                        blurRadius: 7,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Container(
                        height: 70,
                        child: Row(
                          children: [
                            Container(
                              width: 50,
                              alignment: Alignment.center,
                              child: Text(
                                'T${widget.index}',
                                textScaleFactor: 1,
                                textAlign: TextAlign.start,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  decoration: TextDecoration.none,
                                  decorationColor: AppColors.kWhite,
                                  color: AppColors.kWhite,
                                  fontSize: 16.7,
                                  letterSpacing: -0.6,
                                  fontFamily: AppStrings.dmMedium,
                                ),
                              ),
                            ),
                            Expanded(child: Container(
                              height: 70,
                              alignment: Alignment.centerLeft,
                              padding: EdgeInsets.only(left: 20),
                              decoration: BoxDecoration(
                                color: AppColors.kWhite,
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(10)
                                ),
                              ),
                              child: Text(
                                '${widget.teamsItem.name}',
                                textScaleFactor: 1,
                                textAlign: TextAlign.start,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  decoration: TextDecoration.none,
                                  decorationColor: AppColors.kBlack,
                                  color: AppColors.kBlack,
                                  fontSize: 16.7,
                                  letterSpacing: -0.4,
                                  fontFamily: AppStrings.dmMedium,
                                ),
                              ),
                            ))
                          ],
                        ),
                      ),
                      DividerWidget(opacityLevel: 0.1),
                      Expanded(
                          child: Container(
                            // color: Colors.blueGrey,
                            child: Stack(
                              children: [
                                Center(child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 15),
                                  child: SvgPicture.asset("assets/images/s1.svg", width: MediaQuery.of(context).size.width - 40,),
                                )),
                                Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Padding(
                                      padding: const EdgeInsets.only(bottom: 15.0),
                                      child: SvgPicture.asset("${AppStrings.appLogoFullSVG}",
                                        width: 50,
                                      ),
                                    )),
                                Container(
                                  color: Colors.transparent,
                                  height: constraints.minHeight - 100,
                                  width: MediaQuery.of(context).size.width - 40,
                                  margin: EdgeInsets.symmetric(vertical: 40),
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  alignment: Alignment.center,
                                  child: SingleChildScrollView(
                                    physics: BouncingScrollPhysics(),
                                    child: playerIsLoading ? LoadingWIdgetSmall() :
                                    _f1PlayerList.isNotEmpty ? Wrap(
                                      direction: Axis.horizontal,
                                      alignment: WrapAlignment.center,
                                      children: [
                                        ...List.generate(_f1PlayerList.length, (index) {
                                          return PlayerCard(playerItem: _f1PlayerList[index]);
                                        }),
                                      ],
                                    ) : Container(),
                                  ),
                                ),
                              ],
                            ),
                          )),
                      Container(
                        height: 50,
                        alignment: Alignment.centerRight,
                        decoration: BoxDecoration(
                          color: AppColors.kWhite,
                          borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(10),
                            bottomLeft: Radius.circular(10),
                          ),
                        ),
                        child: Splash(
                          onTap: () {
                            setState(() {
                              menuIsOpen = !menuIsOpen;
                            });
                          },
                          splashColor: AppColors.kBlack2,
                          maxRadius: 30,
                          minRadius: 20,
                          child: Container(
                            color: Colors.transparent,
                            height: 50,
                            width: 50,
                            padding: EdgeInsets.all(9),
                            child: Container(
                                child: Icon(Icons.more_vert_rounded),
                                decoration: BoxDecoration(
                                  color: menuIsOpen ? Color(0xffEBECF0) : Colors.transparent,
                                  borderRadius: BorderRadius.circular(5)
                                ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),

                menuIsOpen ? Positioned(
                  bottom: 44,
                  right: 10,
                  child: Container(
                    width: 230,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Color(0xffD1D6DE)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          spreadRadius: 3,
                          blurRadius: 7,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        YMargin(5),
                        Splash(
                          onTap: () {
                            setState(() {
                              menuIsOpen = !menuIsOpen;
                            });
                            showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                isDismissible: true,
                                enableDrag: true,
                                builder: (scaffoldContext) => RenameTeam(index: widget.index, teamsItem: widget.teamsItem));
                          },
                          splashColor: AppColors.kBlack2,
                          maxRadius: 30,
                          minRadius: 20,
                          child: Container(
                            // padding: const EdgeInsets.only(bottom: 23, left: 16, right: 16),
                            padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 16),
                            color: Colors.transparent,
                            child: Row(
                              children: [
                                Icon(Icons.edit, size: 19,),
                                XMargin(15),
                                Text(
                                  'Rename',
                                  textScaleFactor: 1,
                                  textAlign: TextAlign.start,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    decoration: TextDecoration.none,
                                    decorationColor: AppColors.kWhite,
                                    color: AppColors.kBlack,
                                    fontSize: 16,
                                    letterSpacing: -0.4,
                                    fontFamily: AppStrings.dmRegular,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Splash(
                          onTap: () {},
                          splashColor: AppColors.kBlack2,
                          maxRadius: 30,
                          minRadius: 20,
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 16),
                            color: Colors.transparent,
                            child: Row(
                              children: [
                                SvgPicture.asset("assets/images/Group 21667.svg"),
                                XMargin(16),
                                Text(
                                  'Recreate',
                                  textScaleFactor: 1,
                                  textAlign: TextAlign.start,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    decoration: TextDecoration.none,
                                    decorationColor: AppColors.kWhite,
                                    color: AppColors.kBlack,
                                    fontSize: 16,
                                    letterSpacing: -0.4,
                                    fontFamily: AppStrings.dmRegular,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Splash(
                          onTap: () {
                            setState(() {
                              menuIsOpen = !menuIsOpen;
                              dashboardViewModel.setShouldReload = !dashboardViewModel.shouldReload;
                              dashboardViewModel.setProgressValue = dashboardViewModel.shouldReload ? null : 0;
                              if(teamViewModel.f1TeamList.length < 3) {
                                Future.delayed(Duration(milliseconds: 1500)).whenComplete(() {
                                  dashboardViewModel.setShouldReload = !dashboardViewModel.shouldReload;
                                  dashboardViewModel.setProgressValue = dashboardViewModel.shouldReload ? null : 0;
                                  AchievementView(
                                    context,
                                    title: "${widget.teamsItem.name}",
                                    subTitle: "Replication successful",
                                    alignment: Alignment.topRight,
                                    color: AppColors.kGreen3,
                                    icon: SvgPicture.asset("assets/images/copy.svg", width: 19, color: Colors.white),
                                    duration: Duration(milliseconds: 1000),
                                    isCircle: false,
                                    listener: (status) {
                                      print(status);
                                    },
                                  )..show();
                                  teamViewModel.replicateTeam(TeamsItem(
                                      id: 1000,
                                      abbreviation: widget.teamsItem.abbreviation,
                                      assistant_manager: widget.teamsItem.assistant_manager,
                                      founded: widget.teamsItem.founded,
                                      jersey_image: widget.teamsItem.jersey_image,
                                      manager: widget.teamsItem.manager,
                                      marketing_modal_text: widget.teamsItem.marketing_modal_text,
                                      name: widget.teamsItem.name,
                                      short_name: widget.teamsItem.short_name,
                                      slug: widget.teamsItem.slug,
                                      sport_id: widget.teamsItem.sport_id,
                                      team_badge_image: widget.teamsItem.team_badge_image,
                                      team_logo_image: widget.teamsItem.team_logo_image,
                                      show_marketing_modal: false
                                  ));
                                });
                              } else {
                                Future.delayed(Duration(milliseconds: 1500)).whenComplete(() {
                                  dashboardViewModel.setShouldReload = !dashboardViewModel.shouldReload;
                                  dashboardViewModel.setProgressValue = dashboardViewModel.shouldReload ? null : 0;
                                  AchievementView(
                                    context,
                                    title: "Max limit reached",
                                    subTitle: "You have reached your maximum of 3 team slots",
                                    alignment: Alignment.topRight,
                                    color: AppColors.kRed,
                                    icon: SvgPicture.asset("assets/images/copy.svg", width: 19, color: Colors.white),
                                    duration: Duration(milliseconds: 2000),
                                    isCircle: false,
                                    listener: (status) {
                                      print(status);
                                    },
                                  )..show();
                                });
                              }
                            });
                          },
                          splashColor: AppColors.kBlack2,
                          maxRadius: 30,
                          minRadius: 20,
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 16),
                            color: Colors.transparent,
                            child: Row(
                              children: [
                                SvgPicture.asset("assets/images/copy.svg", width: 19,),
                                XMargin(15),
                                Text(
                                  'Replicate',
                                  textScaleFactor: 1,
                                  textAlign: TextAlign.start,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    decoration: TextDecoration.none,
                                    decorationColor: AppColors.kWhite,
                                    color: AppColors.kBlack,
                                    fontSize: 16,
                                    letterSpacing: -0.4,
                                    fontFamily: AppStrings.dmRegular,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        DividerWidget(),
                        YMargin(3),
                        Splash(
                          onTap: () {
                            setState(() {
                              menuIsOpen = !menuIsOpen;
                              dashboardViewModel.setShouldReload = !dashboardViewModel.shouldReload;
                              dashboardViewModel.setProgressValue = dashboardViewModel.shouldReload ? null : 0;
                              Future.delayed(Duration(milliseconds: 1500)).whenComplete(() {
                                dashboardViewModel.setShouldReload = !dashboardViewModel.shouldReload;
                                dashboardViewModel.setProgressValue = dashboardViewModel.shouldReload ? null : 0;
                                AchievementView(
                                  context,
                                  title: "${widget.teamsItem.name}",
                                  subTitle: "Deleted",
                                  alignment: Alignment.topRight,
                                  color: AppColors.kRed,
                                  icon: SvgPicture.asset("assets/images/delete.svg", width: 19, color: Colors.white),
                                  duration: Duration(milliseconds: 1000),
                                  isCircle: false,
                                  listener: (status) {
                                    print(status);
                                  },
                                )..show();
                                teamViewModel.deleteTeamFromDB(widget.teamsItem.column_id);
                              });
                            });
                          },
                          splashColor: AppColors.kBlack2,
                          maxRadius: 30,
                          minRadius: 20,
                          child: Container(
                            // padding: const EdgeInsets.only(bottom: 23, left: 16, right: 16, top: 20),
                            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 16),
                            color: Colors.transparent,
                            child: Row(
                              children: [
                                SvgPicture.asset("assets/images/delete.svg", width: 19,),
                                XMargin(15),
                                Text(
                                  'Delete',
                                  textScaleFactor: 1,
                                  textAlign: TextAlign.start,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    decoration: TextDecoration.none,
                                    decorationColor: AppColors.kWhite,
                                    color: AppColors.kBlack,
                                    fontSize: 16,
                                    letterSpacing: -0.4,
                                    fontFamily: AppStrings.dmRegular,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        YMargin(2),
                      ],
                    ),
                  ),
                ) : Container()
              ],
            ),
          );
        }
    );
  }
}
