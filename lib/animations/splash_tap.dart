import 'package:flutter/material.dart';

class Splash extends StatefulWidget {

  Splash({
    Key key,
    @required this.onTap,
    @required this.child,
    this.splashColor,
    this.minRadius = defaultMinRadius,
    this.maxRadius = defaultMaxRadius,
  })  : assert(minRadius != null),
        assert(maxRadius != null),
        assert(minRadius > 0),
        assert(minRadius < maxRadius),
        super(key: key);

  final Widget child;

  final GestureTapCallback onTap;

  final Color splashColor;

  final double minRadius;

  final double maxRadius;

  static const double defaultMinRadius = 30;
  static const double defaultMaxRadius = 70;

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> with SingleTickerProviderStateMixin {
  AnimationController splashLoaderController;
  Tween<double> radiusTween;
  Tween<double> borderWidthTween;
  Animation<double> radiusAnimation;
  Animation<double> borderWidthAnimation;
  AnimationStatus status;
  Offset _tapPosition;

  @override
  void initState() {
    splashLoaderController =
    AnimationController(vsync: this, duration: Duration(milliseconds: 350))
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((AnimationStatus listener) {
        status = listener;
      });
    radiusTween = Tween<double>(begin: 0, end: 50);
    radiusAnimation = radiusTween
        .animate(CurvedAnimation(curve: Curves.ease, parent: splashLoaderController));
    borderWidthTween = Tween<double>(begin: 25, end: 1);
    borderWidthAnimation = borderWidthTween.animate(
        CurvedAnimation(curve: Curves.fastOutSlowIn, parent: splashLoaderController));

    super.initState();
  }

  void _animate() {
    splashLoaderController.forward(from: 0);
  }

  @override
  void dispose() {
    splashLoaderController.dispose();
    super.dispose();
  }

  /// Buttons are disabled by default. To enable a button, set its [onTap]
  /// property to a non-null value.
  bool get _enabled => widget.onTap != null;

  void _handleTap(TapUpDetails tapDetails) {
    if (!_enabled) {
      return;
    }
    final RenderBox renderBox = context.findRenderObject();
    _tapPosition = renderBox.globalToLocal(tapDetails.globalPosition);
    final double radius = (renderBox.size.width > renderBox.size.height)
        ? renderBox.size.width
        : renderBox.size.height;

    double constraintRadius;
    if (radius > widget.maxRadius) {
      constraintRadius = widget.maxRadius;
    } else if (radius < widget.minRadius) {
      constraintRadius = widget.minRadius;
    } else {
      constraintRadius = radius;
    }

    radiusTween.end = constraintRadius * 0.6;
    borderWidthTween.begin = radiusTween.end / 2;
    borderWidthTween.end = radiusTween.end * 0.01;
    _animate();

    widget.onTap();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      foregroundPainter: _SplashPaint(
        radius: radiusAnimation.value,
        borderWidth: borderWidthAnimation.value,
        status: status,
        tapPosition: _tapPosition,
        color: widget.splashColor ?? Colors.black,
      ),
      child: GestureDetector(
        child: widget.child,
        onTapUp: _handleTap,
      ),
    );
  }
}

class _SplashPaint extends CustomPainter {
  _SplashPaint({
    @required this.radius,
    @required this.borderWidth,
    @required this.status,
    @required this.tapPosition,
    @required this.color,
  }) : blackPaint = Paint()
    ..color = color
    ..style = PaintingStyle.stroke
    ..strokeWidth = borderWidth;

  final double radius;
  final double borderWidth;
  final AnimationStatus status;
  final Offset tapPosition;
  final Color color;
  final Paint blackPaint;

  @override
  void paint(Canvas canvas, Size size) {
    if (status == AnimationStatus.forward) {
      canvas.drawCircle(tapPosition, radius, blackPaint);
    }
  }

  @override
  bool shouldRepaint(_SplashPaint oldDelegate) {
    if (radius != oldDelegate.radius) {
      return true;
    } else {
      return false;
    }
  }
}