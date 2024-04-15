import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quikhyr_worker/common/quik_spacings.dart';

class ShortIconButton extends StatelessWidget {
  final String text;
  final String? svgPath;
  final VoidCallback? onPressed;
  final Color? foregroundColor;
  final Color? backgroundColor;
  final double height;
  final double width;
  final bool isEnabled; // Added isEnabled property

  const ShortIconButton({
    Key? key,
    required this.text,
    this.svgPath,
    this.onPressed,
    this.foregroundColor,
    this.backgroundColor,
    this.height = 54,
    this.width = 100,
    this.isEnabled = true, // Set default value for isEnabled
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: isEnabled ? 1.0 : 0.5, // Adjust opacity based on isEnabled
      child: SizedBox(
        width: width,
        height: height,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: isEnabled
                ? backgroundColor ?? Theme.of(context).colorScheme.primary
                : Theme.of(context)
                    .disabledColor, // Use disabled color when not enabled
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          onPressed: isEnabled
              ? onPressed
              : null, // Disable onPressed when not enabled
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              if (svgPath != null) ...[
                SvgPicture.asset(
                  svgPath!,
                  color: isEnabled
                      ? foregroundColor ??
                          Theme.of(context).colorScheme.onPrimary
                      : Theme.of(context)
                          .disabledColor, // Use disabled color for SVG when not enabled
                  height: 14,
                  width: 14,
                ),
                QuikSpacing.hS6(),
              ],
              Text(
                text,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: isEnabled
                          ? foregroundColor ??
                              Theme.of(context).colorScheme.onPrimary
                          : Theme.of(context)
                              .disabledColor, // Use disabled color for text when not enabled
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
