import 'package:bordered_text/bordered_text.dart';
import 'package:flutter/material.dart';
import 'package:playon/utilities/app_colors.dart';
import 'package:playon/utilities/app_margin.dart';
import 'package:playon/utilities/app_strings.dart';


class ExitApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Material(
          color: Colors.white,
          elevation: 2,
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  YMargin(25),
                  BorderedText(
                      strokeWidth: 0.1,
                      strokeColor: Colors.black.withOpacity(0.8),
                      child: Text(
                        'playon',
                        textScaleFactor: 1,
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          decoration: TextDecoration.none,
                          decorationColor: Colors.black.withOpacity(0.8),
                          color: Colors.black.withOpacity(0.8),
                          fontSize: 18,
                          letterSpacing: -0.6,
                          fontFamily: AppStrings.dmBold,
                        ),
                      )),
                  YMargin(13),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      'You are about to exit playon app',
                      textScaleFactor: 1,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xff858282),
                        fontSize: 14.1,
                        letterSpacing: -0.4,
                        height: 1.65,
                        fontFamily: AppStrings.dmRegular,
                      ),
                    ),
                  ),
                  YMargin(25),
                  Container(
                    height: 1.5,
                      color: Color(0xffF4F4F4)
                  ),
                  Container(
                    color: Colors.transparent,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () => Navigator.of(context).pop(false),
                            child: Container(
                              height: 50,
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                                border: Border(
                                  right: BorderSide(color: Color(0xffF4F4F4), width: 1.5)
                                )
                              ),
                              child: Transform.translate(
                                offset: Offset(0, -3),
                                child: Center(
                                  child: Text(
                                    'Cancel',
                                    textScaleFactor: 1,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Color(0xff858282),
                                      fontSize: 14.1,
                                      letterSpacing: -0.4,
                                      height: 1.65,
                                      fontFamily: AppStrings.dmRegular,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              Navigator.of(context).pop(true);
                            },
                            child: Container(
                              height: 50,
                              decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  border: Border(
                                      right: BorderSide(color: Color(0xffF4F4F4), width: 1.5)
                                  )
                              ),
                              child: Transform.translate(
                                offset: Offset(0, -3),
                                child: Center(
                                  child: Text(
                                    'Exit app',
                                    textScaleFactor: 1,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: AppColors.kPrimaryColorBlue,
                                      fontSize: 14.5,
                                      letterSpacing: -0.4,
                                      height: 1.65,
                                      fontFamily: AppStrings.dmBold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}