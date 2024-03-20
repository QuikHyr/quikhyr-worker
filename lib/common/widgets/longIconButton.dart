import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quikhyr_worker/common/quik_spacings.dart';

class LongIconButton extends StatelessWidget {
  final String text;
  final String? svgPath;
  final VoidCallback onPressed;
  final Color? foregroundColor;
  final Color? backgroundColor;
  final double height; // Added optional height with default value

  const LongIconButton({
    Key? key,
    required this.text,
    this.svgPath,
    required this.onPressed,
    this.foregroundColor,
    this.backgroundColor,
    this.height = 54, // Set default value for height
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width - 50,
      height: height,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor ?? Theme.of(context).colorScheme.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              text,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: foregroundColor ?? Theme.of(context).colorScheme.onPrimary,)
            ),
            if (svgPath != null) ...[
              QuikSpacing.hS6(),
              SvgPicture.asset(
                colorFilter: ColorFilter.mode(foregroundColor ?? Theme.of(context).colorScheme.onPrimary, BlendMode.srcIn),
                svgPath!,
                height: 14,
                width: 14,
              ),
            ],
          ],
        ),
      ),
    );
  }
}