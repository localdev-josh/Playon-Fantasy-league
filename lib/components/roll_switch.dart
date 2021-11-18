import 'package:flutter/material.dart';
import 'dart:ui';
import 'dart:math';


class LiteRollingSwitch extends StatefulWidget {
  @required
  final bool value;
  @required
  final Function(bool) onChanged;
  final String textOff;
  final String textOn;
  final Color colorOn;
  final Color colorOff;
  final double textSize;
  final Duration animationDuration;
  final IconData iconOn;
  final IconData iconOff;
  final Function onTap;
  final Function onDoubleTap;
  final Function onSwipe;

  LiteRollingSwitch(
      {this.value = false,
        this.textOff = "Off",
        this.textOn = "On",
        this.textSize = 12.0,
        this.colorOn = Colors.green,
        this.colorOff = Colors.red,
        this.iconOff = Icons.flag,
        this.iconOn = Icons.check,
        this.animationDuration = const Duration(milliseconds: 400),
        this.onTap,
        this.onDoubleTap,
        this.onSwipe,
        this.onChanged});

  @override
  _RollingSwitchState createState() => _RollingSwitchState();
}

class _RollingSwitchState extends State<LiteRollingSwitch>
    with SingleTickerProviderStateMixin {
  AnimationController animationController;
  Animation<double> animation;
  double value = 0.0;

  bool turnState;

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
        vsync: this,
        lowerBound: 0.0,
        upperBound: 1.0,
        duration: widget.animationDuration);
    animation =
        CurvedAnimation(parent: animationController, curve: Curves.easeInOut);
    animationController.addListener(() {
      setState(() {
        value = animation.value;
      });
    });
    turnState = widget.value;
    _determine();
  }

  @override
  Widget build(BuildContext context) {
    Color transitionColor = Color.lerp(widget.colorOff, widget.colorOn, value);

    return GestureDetector(
      onDoubleTap: () {
        _action();
        if (widget.onDoubleTap != null) widget.onDoubleTap();
      },
      onTap: () {
        _action();
        if (widget.onTap != null) widget.onTap();
      },
      onPanEnd: (details) {
        _action();
        if (widget.onSwipe != null) widget.onSwipe();
        //widget.onSwipe();
      },
      child: Container(
        padding: EdgeInsets.all(0),
        width: 55,
        decoration: BoxDecoration(
            color: transitionColor, borderRadius: BorderRadius.circular(50),
          border: Border.all(color: Color(0xffC4C4C4).withOpacity(0.8))
        ),
        child: Stack(
          children: <Widget>[
            Transform.translate(
              offset: Offset(2 * value, 0), //original
              child: Opacity(
                opacity: (1 - value).clamp(0.0, 1.0),
                child: Container(
                  padding: EdgeInsets.only(right: 10),
                  alignment: Alignment.centerRight,
                  color: Colors.transparent,
                  height: 30,
                  child: Text(
                    widget.textOff,
                    textScaleFactor: 1,
                    style: TextStyle(
                        color: Colors.transparent,
                        fontWeight: FontWeight.bold,
                        fontSize: widget.textSize),
                  ),
                ),
              ),
            ),
            Transform.translate(
              offset: Offset(10 * (1 - value), 0), //original
              child: Opacity(
                opacity: value.clamp(0.0, 1.0),
                child: Container(
                  padding: EdgeInsets.only(left: 7),
                  alignment: Alignment.centerLeft,
                  color: Colors.transparent,
                  height: 30,
                  child: Text(
                    widget.textOn,
                    textScaleFactor: 1,
                    style: TextStyle(
                        color: Colors.transparent,
                            // .green.withOpacity(0.7)
                        fontWeight: FontWeight.bold,
                        fontSize: widget.textSize),
                  ),
                ),
              ),
            ),
            Transform.translate(
              offset: turnState ? Offset((20 * value)-2, 0) : Offset((20 * value)-7, 0),
              child: Transform.rotate(
                angle: lerpDouble(0, 2 * pi, value),
                child: Container(
                  height: 30,
                  width: 40,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: !turnState ? Colors.white : Colors.white,
                      border: Border.all(color: !turnState ? Color(0xffC4C4C4).withOpacity(0.8) : Colors.white, width: 2),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 1,
                        blurRadius: 10,
                        offset: Offset(turnState ? -5 : 5, 1), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Stack(
                    children: <Widget>[
                      Center(
                        child: Opacity(
                          opacity: (1 - value).clamp(0.0, 1.0),
                          child: Icon(
                            widget.iconOff,
                            size: 15,
                            color: Colors.transparent,
                          ),
                        ),
                      ),
                      Center(
                          child: Opacity(
                              opacity: value.clamp(0.0, 1.0),
                              child: Icon(
                                widget.iconOn,
                                size: 14,
                                color: Colors.green,
                                // color: transitionColor,
                              ))),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  _action() {
    _determine(changeState: true);
  }

  _determine({bool changeState = false}) {
    setState(() {
      if (changeState) turnState = !turnState;
      (turnState)
          ? animationController.forward()
          : animationController.reverse();

      widget.onChanged(turnState);
    });
  }
}
