import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../quik_colors.dart';
import '../quik_spacings.dart';

class QuikShortButton extends StatelessWidget {
  final double? paddingHorizontal;
  final double? paddingVertical;
  final String? text;
  final String? svgPath;
  final VoidCallback? onPressed;
  final Color? foregroundColor;
  final Color? backgroundColor;
  final double height;
  final double width;
  final bool isEnabled;

  const QuikShortButton({
    Key? key,
    this.paddingHorizontal,
    this.paddingVertical,
    this.text,
    this.svgPath,
    this.onPressed,
    this.foregroundColor,
    this.backgroundColor = primary,
    this.height = 60,
    this.width = 158,
    this.isEnabled = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: isEnabled ? 1.0 : 0.5,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(
            horizontal: paddingHorizontal ?? 32,
            vertical: paddingVertical ?? 16,
          ),
          backgroundColor: isEnabled
              ? backgroundColor ?? Theme.of(context).colorScheme.primary
              : Theme.of(context).disabledColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        onPressed: isEnabled ? onPressed : null,
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              if (svgPath != null)
                SvgPicture.asset(
                  svgPath!,
                  color: isEnabled
                      ? foregroundColor ??
                          Theme.of(context).colorScheme.onPrimary
                      : Theme.of(context).disabledColor,
                ),
              if (text != null) ...[
                if (svgPath != null) QuikSpacing.hS6(),
                Flexible(
                  child: Text(
                    text!,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: isEnabled
                              ? foregroundColor ??
                                  Theme.of(context).colorScheme.onPrimary
                              : Theme.of(context).disabledColor,
                        ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
