import 'package:bordered_text/bordered_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:playon/components/custom_paint_draw.dart';
import 'package:playon/data/models/player_model/player.dart';
import 'package:playon/utilities/app_colors.dart';
import 'package:playon/utilities/app_margin.dart';
import 'package:playon/utilities/app_strings.dart';

class PlayerCard extends StatefulWidget {
  final PlayerItem playerItem;

  const PlayerCard({Key key, this.playerItem}) : super(key: key);
  @override
  _PlayerCardState createState() => _PlayerCardState();
}

class _PlayerCardState extends State<PlayerCard> {
  double _value = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 129,
      width: 105,
      decoration: BoxDecoration(
        color: AppColors.kWhite,
        borderRadius: BorderRadius.circular(7),
      ),
      margin: EdgeInsets.symmetric(horizontal: 5, vertical: 15),
      child: Stack(
        overflow: Overflow.visible,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 105,
                height: 50,
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(7)
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        top: -15,
                        child: ClipRRect(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(7)
                          ),
                          child: Transform.rotate(
                            angle: 3.14,
                            child: CustomPaint(
                              painter: TrianglePainter(
                                strokeColor: AppColors.kPrimaryColorDarkGrey,
                                strokeWidth: 10,
                                paintingStyle: PaintingStyle.fill,
                              ),
                              child: Container(
                                height: 50,
                                width: 50,
                                padding: EdgeInsets.only(right: 5, bottom: 5),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

            ],
          ),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Text(
              '${widget.playerItem.team_abbreviation}',
              textScaleFactor: 1,
              textAlign: TextAlign.start,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                decoration: TextDecoration.none,
                decorationColor: AppColors.kWhite,
                color: AppColors.kWhite,
                fontSize: 10.5,
                letterSpacing: -0.4,
                fontFamily: AppStrings.dmMedium,
              ),
            ),
          ),
          Positioned(
            top: -15,
            right: 5,
            child: CachedNetworkImage(
              height: 65,
              width: 65,
              imageUrl: widget.playerItem.headshot,
              placeholder: (context, url) => Align(
                  alignment: Alignment.center,
                  child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.kPrimaryColorShadeGrey,
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.kBlack.withOpacity(0.25),
                            spreadRadius: 3,
                            blurRadius: 7,
                            offset: Offset(-3, 7), // changes position of shadow
                          ),
                        ],
                    ),
                    child: Opacity( opacity: 0.9,child: Image.asset(AppStrings.appLogoMicro))
                  )
              ),
              errorWidget: (context, url, error) => Align(
                  alignment: Alignment.center,
                  child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.kPrimaryColorShadeGrey,
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.kBlack.withOpacity(0.25),
                            spreadRadius: 3,
                            blurRadius: 7,
                            offset: Offset(-3, 7), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Opacity( opacity: 0.9,child: Image.asset(AppStrings.appLogoMicro))
                  )
              ),
              fit: BoxFit.cover,
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(7),
                bottomRight: Radius.circular(7),
              ),
              child: Container(
                color: AppColors.kWhite,
                height: 79,
                width: 105,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: 4, top: 3),
                      child: Text(
                        '${widget.playerItem.firstName} ${widget.playerItem.lastName}'.toUpperCase(),
                        textScaleFactor: 1,
                        textAlign: TextAlign.start,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          decoration: TextDecoration.none,
                          decorationColor: AppColors.kBlack,
                          color: AppColors.kBlack,
                          fontSize: 10,
                          letterSpacing: -0.4,
                          fontFamily: AppStrings.dmMedium,
                        ),
                      ),
                    ),
                    YMargin(4),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 4),
                      padding: EdgeInsets.symmetric(vertical: 3),
                      decoration: BoxDecoration(
                          color: AppColors.kPrimaryColorLightShadeGrey,
                          borderRadius: BorderRadius.circular(4)
                      ),
                      alignment: Alignment.center,
                      child: BorderedText(
                          strokeWidth: 0.7,
                          strokeColor: Color(0xff797F86),
                          child: Text(
                            '${widget.playerItem.positionAbbreviation}',
                            textScaleFactor: 1,
                            textAlign: TextAlign.start,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              decoration: TextDecoration.none,
                              decorationColor: Color(0xff797F86),
                              color: Color(0xff797F86),
                              fontSize: 10.9,
                              letterSpacing: 0.6,
                              fontFamily: AppStrings.dmMedium,
                            ),
                          )),
                    ),
                    YMargin(4),
                    Expanded(
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 4),
                          padding: EdgeInsets.symmetric(horizontal: 4, vertical: 3),
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Color(0xffE0E4E8)
                              ),
                              borderRadius: BorderRadius.circular(4)
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(child: Text(
                                    '${AppStrings.dollarSymbol}00.0M',
                                    textScaleFactor: 1,
                                    textAlign: TextAlign.start,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      color: AppColors.kBlack,
                                      fontSize: 10.9,
                                      letterSpacing: -0.4,
                                      fontFamily: AppStrings.dmBold,
                                    ),
                                  )),
                                  Icon(Icons.arrow_drop_up_rounded,
                                      size: 13, color: AppColors.kGreen2),
                                  Expanded(child: Container(
                                    child: Text(
                                      '${AppStrings.dollarSymbol}00.0M',
                                      textScaleFactor: 1,
                                      textAlign: TextAlign.start,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        color: AppColors.kGreen2,
                                        fontSize: 10.9,
                                        letterSpacing: -0.4,
                                        fontFamily: AppStrings.dmBold,
                                      ),
                                    ),
                                  ))
                                ],
                              ),
                              YMargin(3),
                              IntrinsicHeight(
                                child: Container(
                                  child: SliderTheme(
                                    data: SliderTheme.of(context).copyWith(
                                      activeTrackColor: AppColors.kSecondaryColor3.withOpacity(0.8),
                                      inactiveTrackColor: AppColors.kPrimaryColorLightShadeGrey,
                                      trackShape: RoundedRectSliderTrackShape(),
                                      trackHeight: 1.5,
                                      thumbShape: RoundSliderThumbShape(enabledThumbRadius: 3.5),
                                      thumbColor: AppColors.kGreen2,
                                      overlayColor: Colors.red.withAlpha(32),
                                      overlayShape: RoundSliderOverlayShape(overlayRadius: 4.0),
                                      tickMarkShape: RoundSliderTickMarkShape(),
                                      activeTickMarkColor: AppColors.kGreen2,
                                      inactiveTickMarkColor: AppColors.kGreen2,
                                      valueIndicatorShape: PaddleSliderValueIndicatorShape(),
                                      valueIndicatorColor: AppColors.kGreen2,
                                      valueIndicatorTextStyle: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                    child: Slider(
                                      value: _value,
                                      min: 0,
                                      max: 100,
                                      divisions: 10,
                                      label: '$_value',
                                      onChanged: (value) {
                                        setState(
                                              () {
                                            _value = value;
                                          },
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )),
                    YMargin(4),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
