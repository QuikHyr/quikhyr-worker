import 'package:flutter/material.dart';
import 'package:quikhyr_worker/common/quik_colors.dart';

class RatingStar extends StatelessWidget {
  final String rating;

  const RatingStar({Key? key, required this.rating}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 2),
      height: 16,
      // width: 30,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: quikHyrOrange,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(rating, style: Theme.of(context).textTheme.labelMedium),
          const Icon(
            Icons.star_rounded,
            size: 8,
          ),
        ],
      ),
    );
  }
}
