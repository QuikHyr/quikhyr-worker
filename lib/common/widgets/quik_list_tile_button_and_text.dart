import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../quik_themes.dart';

class QuikListTileButtonAndText extends StatelessWidget {
  final String title;
  final String leadingSvgLink;
  const QuikListTileButtonAndText({
    super.key,
    required this.title,
    required this.leadingSvgLink,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: SvgPicture.asset(leadingSvgLink),
      title: Text(
        title,
        style: workerListNameTextStyle,
      ),
    );
  }
}