import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ClickableSvgIcon extends StatelessWidget {
  final String svgAsset;
  final double size;
  final double? height;
  final double? width;
  final VoidCallback onTap;

  const ClickableSvgIcon({
    Key? key,
    required this.svgAsset,
    this.size = 24.0,
    this.height,
    this.width,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SvgPicture.asset(
        svgAsset,
        height: height ?? size,
        width: width ?? size,
      ),
    );
  }
}