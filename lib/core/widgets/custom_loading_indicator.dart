import 'package:flutter/material.dart';

class CustomLoadingIndicator extends StatelessWidget {
  const CustomLoadingIndicator({
    super.key,
    this.height,
    this.color,
    this.backgroundColor,
    this.showBackGround = true,
  });
  final double? height;
  final Color? color, backgroundColor;
  final bool showBackGround;
  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator(
      color: color,
      backgroundColor: backgroundColor,
    );
  }
}
