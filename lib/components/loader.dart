import 'package:flutter/material.dart';

class Loader extends StatelessWidget {
  const Loader({
    this.size = 20,
    this.padding = 10,
    this.strokeWidth = 2,
  });

  final double size;
  final double padding;
  final double strokeWidth;

  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(padding),
      child: SizedBox(
        height: size,
        width: size,
        child: CircularProgressIndicator(
          strokeWidth: strokeWidth,
        ),
      ),
    );
  }
}
