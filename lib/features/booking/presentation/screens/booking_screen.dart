import 'package:flutter/material.dart';
import 'package:quikhyr_worker/common/quik_asset_constants.dart';
import 'package:quikhyr_worker/common/quik_colors.dart';
import 'package:quikhyr_worker/common/quik_spacings.dart';
import 'package:quikhyr_worker/common/widgets/clickable_svg_icon.dart';
import 'package:quikhyr_worker/common/widgets/quik_search_bar.dart';

class BookingScreen extends StatelessWidget {
  const BookingScreen({super.key});

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
                          style:
                              TextStyle(fontFamily: 'Moonhouse', fontSize: 32),
                        ),
                        TextSpan(
                          text: 'uik',
                          style:
                              TextStyle(fontFamily: 'Moonhouse', fontSize: 24),
                        ),
                        TextSpan(
                          text: 'Book',
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
        body: Container(
          padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
          child: Column(
            children: [
              QuikSearchBar(
                onChanged: (String value) {}, // Default value for onChanged
                hintText: "Search for bookings...",
                onMicPressed: () {},
                onSearch: (String onSearch) {},
                controller: TextEditingController(),
              ),
              QuikSpacing.vS24(),
              Row(
                children: [
                  RichText(
                    text: TextSpan(
                      text: "CURRENT ",
                      style: Theme.of(context).textTheme.titleMedium,
                      children: [
                        TextSpan(
                          text: "BOOKINGS",
                          style:
                              Theme.of(context).textTheme.titleMedium?.copyWith(
                                    color: primary,
                                  ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}
