import 'package:flutter/material.dart';

class OvalBottomClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, 0);
    path.lineTo(0, size.height - 32);
    path.quadraticBezierTo(8, size.height, size.width / 2, size.height);
    path.quadraticBezierTo(
        size.width - 8, size.height, size.width, size.height - 32);
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
