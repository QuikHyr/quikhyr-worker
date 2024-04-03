import 'package:flutter/material.dart';
import 'package:quikhyr_worker/common/quik_asset_constants.dart';
import 'package:quikhyr_worker/common/quik_spacings.dart';
import 'package:quikhyr_worker/common/widgets/clickable_svg_icon.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                        style: TextStyle(fontFamily: 'Moonhouse', fontSize: 32),
                      ),
                      TextSpan(
                        text: 'uik',
                        style: TextStyle(fontFamily: 'Moonhouse', fontSize: 24),
                      ),
                      TextSpan(
                        text: 'Settings',
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
                  svgAsset: QuikAssetConstants.bellNotificationActiveSvg,
                  onTap: () {
                    //HANDLE GO TO NOTIFICATIONS
                  }),
              QuikSpacing.hS10(),
              ClickableSvgIcon(
                  svgAsset: QuikAssetConstants.logoutSvg,
                  onTap: () {
                    // context.read<SignInBloc>().add(const SignOutRequired());
                  }),
              QuikSpacing.hS24(),
            ],
          ),
        ),
      ),
    );
  }
}
