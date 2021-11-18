import 'package:achievement_view/achievement_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:playon/components/splash_tap.dart';
import 'package:playon/data/view_models/team_view_model.dart';
import 'package:playon/screens/dashboard_navigations/widgets/team_card.dart';
import 'package:playon/utilities/app_colors.dart';
import 'package:playon/utilities/app_strings.dart';
import 'package:provider/provider.dart';

class TeamsListView extends StatefulWidget {
  @override
  _TeamsListViewState createState() => _TeamsListViewState();
}

class _TeamsListViewState extends State<TeamsListView> {
  ABSTeamViewModel teamViewModel;

  @override
  Widget build(BuildContext context) {
    teamViewModel = Provider.of(context);
    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          height: constraints.minHeight,
          child: Center(
            child: teamViewModel.f1TeamList.isEmpty ?
            Container(
              height: constraints.minHeight - 100,
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width - 40,
              decoration: BoxDecoration(
                color: AppColors.kWhite,
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
              child: Splash(
                onTap: () async {
                  EasyLoading.show();
                  await teamViewModel.fetchF1Teams();
                  if(teamViewModel.f1TeamListFull.isEmpty) {
                    EasyLoading.dismiss();
                    AchievementView(
                      context,
                      title: "Team not created",
                      subTitle: "Please connect to the internet and try again",
                      alignment: Alignment.topRight,
                      icon: Icon(Icons.error_outline, color: Colors.white,),
                      color: AppColors.kRed,
                      duration: Duration(milliseconds: 1000),
                      isCircle: false,
                      listener: (status) {
                        print(status);
                      },
                    )..show();
                  } else {
                    Future.delayed(Duration(seconds: 2)).whenComplete(() {
                      AchievementView(
                        context,
                        title: "Team created",
                        subTitle: "",
                        alignment: Alignment.topRight,
                        color: AppColors.kGreen3,
                        duration: Duration(milliseconds: 1000),
                        isCircle: false,
                        listener: (status) {
                          print(status);
                        },
                      )..show();
                      EasyLoading.dismiss();
                    });
                  }
                },
                splashColor: AppColors.kPrimaryColorLightGrey,
                maxRadius: 35,
                minRadius: 20,
                child: Container(
                  child: Card(
                    color: AppColors.kGreen2,
                    child: Container(
                      height: 50,
                      width: 200,
                      alignment: Alignment.center,
                      child: Text("Create Team 1",
                        textScaleFactor: 1,
                        style: TextStyle(
                            fontFamily: AppStrings.dmBold,
                            fontSize: 15,
                            letterSpacing: -0.5,
                            color: Color(0xffffffff)
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ) :
            ListView.builder(
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 80),
              itemCount: teamViewModel.f1TeamList.length + 1,
              itemBuilder: (context, int index) {
                if(index == teamViewModel.f1TeamList.length) {
                  if(teamViewModel.f1TeamList.length != 3) {
                    return Container(
                      height: constraints.minHeight - 100,
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width - 40,
                      decoration: BoxDecoration(
                        color: AppColors.kWhite,
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
                      child: Splash(
                        onTap: () async {
                          EasyLoading.show();
                          await teamViewModel.fetchNextF1Team();
                          if(teamViewModel.f1TeamListFull.isEmpty) {
                            EasyLoading.dismiss();
                            AchievementView(
                              context,
                              title: "Team not created",
                              subTitle: "Please connect to the internet and try again",
                              alignment: Alignment.topRight,
                              icon: Icon(Icons.error_outline, color: Colors.white,),
                              color: AppColors.kRed,
                              duration: Duration(milliseconds: 1000),
                              isCircle: false,
                              listener: (status) {
                                print(status);
                              },
                            )..show();
                          } else {
                            Future.delayed(Duration(seconds: 2)).whenComplete(() {
                              AchievementView(
                                context,
                                title: "Team created",
                                subTitle: "",
                                alignment: Alignment.topRight,
                                color: AppColors.kGreen3,
                                duration: Duration(milliseconds: 1000),
                                isCircle: false,
                                listener: (status) {
                                  print(status);
                                },
                              )..show();
                              EasyLoading.dismiss();
                            });
                          }
                        },
                        splashColor: AppColors.kPrimaryColorLightGrey,
                        maxRadius: 35,
                        minRadius: 20,
                        child: Container(
                          child: Card(
                            color: AppColors.kGreen2,
                            child: Container(
                              height: 50,
                              width: 200,
                              alignment: Alignment.center,
                              child: Text("Create Team ${teamViewModel.f1TeamList.length + 1}",
                                textScaleFactor: 1,
                                style: TextStyle(
                                    fontFamily: AppStrings.dmMedium,
                                    fontSize: 15,
                                    letterSpacing: -0.5,
                                    color: Color(0xffffffff)
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  } else {
                    return Container();
                  }
                }
                return TeamCard(
                  teamsItem: teamViewModel.f1TeamList[index],
                  removePadding: teamViewModel.f1TeamList.length == 3 && index == 2,
                  index: index + 1,
                );
              },
            ),
          ),
        );
      },
    );
  }
}
