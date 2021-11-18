import 'package:achievement_view/achievement_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:playon/components/splash_tap.dart';
import 'package:playon/data/models/teams_model/teams.dart';
import 'package:playon/data/view_models/team_view_model.dart';
import 'package:playon/utilities/app_colors.dart';
import 'package:playon/utilities/app_margin.dart';
import 'package:playon/utilities/app_strings.dart';
import 'package:provider/provider.dart';


class RenameTeam extends StatefulWidget {
  final TeamsItem teamsItem;
  final int index;

  const RenameTeam({Key key, this.teamsItem, this.index = 1}) : super(key: key);

  @override
  _RenameTeamState createState() => _RenameTeamState();
}

class _RenameTeamState extends State<RenameTeam> {
  TextEditingController teamNameController;
  final FocusNode _nodeText1 = FocusNode();
  ABSTeamViewModel teamViewModel;
  bool autoValidate = false;
  bool isFocused = false;

  @override
  void initState() {
    super.initState();
    teamNameController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    teamViewModel = Provider.of(context);
    return SafeArea(
      top: true,
      child: GestureDetector(
        onTap: () {
          _nodeText1.unfocus();
          setState(() {
            isFocused = false;
          });
        },
        child: IntrinsicHeight(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                margin: EdgeInsets.only(right: 20, bottom: 10),
                decoration:  BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.transparent
                ),
                child: IntrinsicWidth(
                  child: Material(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(100),
                    child: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      borderRadius: BorderRadius.circular(100),
                      child: Container(
                        decoration:  BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.transparent,
                        ),
                        height: 40,
                        width: 40,
                        child: Icon(Icons.close, color: AppColors.kWhite, size: 28,),
                      ),
                    ),
                  ),
                ),
              ),
              IntrinsicHeight(
                child: AnimatedContainer(
                  color: Colors.white,
                  duration: Duration(milliseconds: 400),
                  constraints: BoxConstraints(
                      minHeight: isFocused ? 460 : 180
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      YMargin(20),
                      Text('RENAME TEAM ${widget.index}',
                          textScaleFactor: 1,
                          style: TextStyle(color: Color(0xff5F6C84),
                              fontFamily: AppStrings.dmMedium,
                              fontSize: 12)),
                      YMargin(10),
                      Container(
                        color: Colors.transparent,
                        height: 60,
                        child: Stack(
                          children: [
                            TextFormField(
                              controller: teamNameController,
                              focusNode: _nodeText1,
                              onTap: () {
                                _nodeText1.requestFocus();
                                setState(() {
                                  isFocused = true;
                                });
                              },
                              onFieldSubmitted: (teamName) async {
                                _nodeText1.unfocus();
                                setState(() {
                                  isFocused = false;
                                });
                              },
                              onChanged: (value) {
                                setState(() {});
                              },
                              style: TextStyle(fontFamily: AppStrings.dmBold, color: AppColors.kBlack, fontSize: 15),
                              decoration: InputDecoration(
                                filled: true,
                                contentPadding: EdgeInsets.symmetric(horizontal: 0),
                                fillColor: Colors.white,
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Color(0xffE5E5E5), width: 1.0),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Color(0xffE5E5E5), width: 1.5),
                                ),
                                errorBorder: autoValidate ? teamNameController.text.isEmpty ? UnderlineInputBorder(
                                  borderSide: BorderSide(color: AppColors.kRed.withOpacity(1), width: 1.5),
                                ) : UnderlineInputBorder() : UnderlineInputBorder(),
                                hintText: 'Type team name',
                                hintStyle: TextStyle(fontFamily: AppStrings.dmRegular, color: Color(0xffBABABA), fontSize: 14),
                                // counterText: 'counter',
                              ),
                            ),
                          ],
                        ),
                      ),
                      autoValidate ? teamNameController.text.isEmpty ?
                      Padding(
                        padding: const EdgeInsets.only(top: 0),
                        child: Text('Team name is required',
                            textScaleFactor: 1,
                            style: TextStyle(color: Color(0xffED5757),
                                fontSize: 12,
                                fontFamily: AppStrings.dmMedium
                            )),
                      ) : Container() : Container(),
                      YMargin(10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Splash(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            splashColor: AppColors.kBlack,
                            maxRadius: 25,
                            minRadius: 15,
                            child: Container(
                              // width: 200,
                              color: Colors.transparent,
                              padding: EdgeInsets.symmetric(horizontal: 25, vertical: 7),
                              alignment: Alignment.center,
                              child: Text("Cancel",
                                textScaleFactor: 1,
                                style: TextStyle(
                                    fontFamily: AppStrings.dmMedium,
                                    fontSize: 15.2,
                                    letterSpacing: 0,
                                    color: Color(0xff000000)
                                ),
                              ),
                            ),
                          ),
                          Splash(
                            onTap: () async {
                              HapticFeedback.lightImpact();
                              setState(() {
                                autoValidate = true;
                              });
                              if (teamNameController.text.isEmpty) {
                                return;
                              }
                              EasyLoading.show();
                              await teamViewModel.updateTeam(TeamsItem(
                                  id: widget.teamsItem.id,
                                  column_id: widget.teamsItem.column_id,
                                  abbreviation: widget.teamsItem.abbreviation,
                                  assistant_manager: widget.teamsItem.assistant_manager,
                                  founded: widget.teamsItem.founded,
                                  jersey_image: widget.teamsItem.jersey_image,
                                  manager: widget.teamsItem.manager,
                                  marketing_modal_text: widget.teamsItem.marketing_modal_text,
                                  name: teamNameController.text,
                                  short_name: widget.teamsItem.short_name,
                                  slug: widget.teamsItem.slug,
                                  sport_id: widget.teamsItem.sport_id,
                                  team_badge_image: widget.teamsItem.team_badge_image,
                                  team_logo_image: widget.teamsItem.team_logo_image,
                                  show_marketing_modal: false
                              ));
                              Navigator.pop(context);
                              AchievementView(
                                context,
                                title: "Rename Successful",
                                subTitle: "",
                                alignment: Alignment.topRight,
                                color: AppColors.kGreen2,
                                duration: Duration(milliseconds: 1000),
                                isCircle: false,
                                listener: (status) {
                                  print(status);
                                },
                              )..show();
                              EasyLoading.dismiss();
                            },
                            splashColor: AppColors.kPrimaryColorLightGrey,
                            maxRadius: 25,
                            minRadius: 15,
                            child: Container(
                              child: Card(
                                color: teamNameController.text.isEmpty ? Color(0xffD8D8D8) : AppColors.kGreen2,
                                child: Container(
                                  // width: 200,
                                  padding: EdgeInsets.symmetric(horizontal: 25, vertical: 7),
                                  alignment: Alignment.center,
                                  child: Text("Rename",
                                    textScaleFactor: 1,
                                    style: TextStyle(
                                        fontFamily: AppStrings.dmMedium,
                                        fontSize: 15.2,
                                        letterSpacing: 0,
                                        color: Color(0xffffffff)
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
