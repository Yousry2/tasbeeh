import 'package:flutter/material.dart';
import './animated_opacity_container.dart';

const double ANIMATION_DISTANCE = 100;

class AnimatedOpacityWidget extends StatelessWidget {
  final Widget child;
  final bool showCondition;
  final Directions direction;
  AnimatedOpacityWidget(
      {this.child, this.showCondition, this.direction = Directions.top});
  @override
  Widget build(BuildContext context) {
    return AnimatedOpacityContainer(
      animationCurve: Curves.easeInOut,
      opacityCurve: Curves.easeInOut,
      opacityDuration: Duration(milliseconds: 500),
      animationDuration: Duration(milliseconds: 800),
      child: child,
      opacity: showCondition ? 1 : 0,
      transform: Matrix4.translationValues(
        showCondition == false
            ? (direction == Directions.left
                ? -ANIMATION_DISTANCE
                : direction == Directions.right ? ANIMATION_DISTANCE : 0.0)
            : 0.0,
        showCondition == false
            ? (direction == Directions.top
                ? -ANIMATION_DISTANCE
                : direction == Directions.bottom ? ANIMATION_DISTANCE : 0.0)
            : 0.0,
        showCondition == false
            ? (direction == Directions.up
                ? -ANIMATION_DISTANCE
                : direction == Directions.down ? ANIMATION_DISTANCE : 0.0)
            : 0.0,
      ),
    );
  }
}

enum Directions { top, right, bottom, left, up, down }
