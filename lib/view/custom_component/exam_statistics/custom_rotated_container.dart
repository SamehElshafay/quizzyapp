import 'package:flutter/material.dart';

class RotatedContainer extends StatelessWidget {
  final double angleInDegrees;
  final Widget child;
  final int? value;

  const RotatedContainer(
      {required this.angleInDegrees, required this.child, this.value = 180});

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: angleInDegrees * (3.1415926535 / 180),
      child: child,
    );
  }
}
