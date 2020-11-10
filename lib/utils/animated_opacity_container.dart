import 'package:flutter/cupertino.dart';

class AnimatedOpacityContainer extends StatelessWidget {
  AnimatedOpacityContainer(
      {this.opacityCurve,
      this.animationCurve,
      this.opacityDuration,
      this.animationDuration,
      this.transform,
      this.opacity,
      this.child});

  final Curve opacityCurve;
  final Curve animationCurve;
  final Duration opacityDuration;
  final Duration animationDuration;
  final Matrix4 transform;
  final double opacity;
  final Widget child;

  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: animationDuration,
      transform: transform,
      curve: animationCurve,
      child: AnimatedOpacity(
        duration: opacityDuration,
        opacity: opacity,
        curve: opacityCurve,
        child: child,
      ),
    );
  }
}
