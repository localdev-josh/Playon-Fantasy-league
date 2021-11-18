import 'package:flutter/material.dart';

class DividerWidget extends StatelessWidget {
  final double opacityLevel;

  const DividerWidget({Key key, this.opacityLevel = 0.5}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 1,
        color: Color(0xffC5D4F6).withOpacity(opacityLevel)
    );
  }
}
