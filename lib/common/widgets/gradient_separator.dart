import 'package:flutter/material.dart';

class GradientSeparator extends StatelessWidget {
  const GradientSeparator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 22),
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