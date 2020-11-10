import 'package:flutter/material.dart';

class StartButtonWidget extends StatelessWidget {
  final MaterialColor color;
  final Widget child;
  final double width;
  final double height;

  StartButtonWidget(
      {this.child, this.height, this.color = Colors.grey, this.width});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      child: child,
      decoration: BoxDecoration(
        color: color[300],
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
              color: color[600],
              offset: Offset(4.0, 4.0),
              blurRadius: 15.0,
              spreadRadius: 1.0),
          BoxShadow(
              color: Colors.white,
              offset: Offset(-4.0, -4.0),
              blurRadius: 15.0,
              spreadRadius: 1.0),
        ],
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            color[100],
            color[300],
            color[600],
            color[800],
          ],
          stops: [0.1, 0.3, 0.8, 1],
        ),
      ),
    );
  }
}
