import 'package:flutter/material.dart';

class GradientSeparator extends StatelessWidget {
  final double? paddingTop;
  final double? paddingBottom;
  const GradientSeparator({Key? key, this.paddingTop, this.paddingBottom})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, paddingTop ?? 22, 0, paddingBottom ?? 22),
      child: Container(
        height: 1,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.transparent,
              Colors.grey.withOpacity(0.5),
              Colors.grey.withOpacity(1),
              Colors.grey.withOpacity(1),
              Colors.grey.withOpacity(1),
              Colors.grey.withOpacity(0.5),
              Colors.transparent,
            ],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
        ),
      ),
    );
  }
}
