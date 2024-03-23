import 'package:flutter/material.dart';
import 'package:quikhyr_worker/common/quik_asset_constants.dart';
import 'package:quikhyr_worker/common/quik_spacings.dart';
import 'package:quikhyr_worker/common/widgets/clickable_svg_icon.dart';

class FeedbackScreen extends StatelessWidget {
  const FeedbackScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(56),
          child: Padding(
            padding: const EdgeInsets.only(top: 12),
            child: AppBar(
              titleSpacing: 24,
              automaticallyImplyLeading: false, // Remove back button
              backgroundColor: Colors.transparent,
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: const TextSpan(
                      children: [
                        TextSpan(
                          text: 'Q',
                          style:
                              TextStyle(fontFamily: 'Moonhouse', fontSize: 32),
                        ),
                        TextSpan(
                          text: 'uik',
                          style:
                              TextStyle(fontFamily: 'Moonhouse', fontSize: 24),
                        ),
                        TextSpan(
                          text: 'Feedback',
                          style: TextStyle(
                              fontFamily: 'Trap',
                              fontSize: 24,
                              letterSpacing: -1.5),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              actions: [
                ClickableSvgIcon(
                    svgAsset: QuikAssetConstants.filterSvg,
                    onTap: () {
                      //HANDLE GO TO NOTIFICATIONS
                    }),
                QuikSpacing.hS24(),
              ],
            ),
          ),
        ),
        body: const Center(child: Text("Feedback")));
  }
}
