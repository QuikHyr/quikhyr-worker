// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:quikhyr_worker/common/quik_colors.dart';
import 'package:quikhyr_worker/common/quik_spacings.dart';
import 'package:quikhyr_worker/common/quik_themes.dart';

class HomeDetailScreen extends StatelessWidget {
  const HomeDetailScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(56),
          child: Padding(
            padding: const EdgeInsets.only(top: 12),
            child: AppBar(
              leading: GestureDetector(
                  onTap: () {
                    context.pop();
                  },
                  child:
                      const Icon(Icons.arrow_back_ios_new, color: secondary)),
              titleSpacing: 24,
              // automaticallyImplyLeading: false, // Remove back button
              backgroundColor: Colors.transparent,
              title: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Container(
                  //     decoration: const BoxDecoration(
                  //         shape: BoxShape.circle,
                  //         color: gridItemBackgroundColor),
                  //     alignment: Alignment.center,
                  //     height: 36,
                  //     width: 36,
                  //     // child: SvgPicture.asset(
                  //     //   // serviceModel.iconPath,
                  //     // )),
                  //     ,
                  QuikSpacing.hS12(),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          "Home Detail",
                          style: Theme.of(context).textTheme.titleLarge),
                      QuikSpacing.vS8(),
                      const Text("Service", style: chatSubTitle),
                    ],
                  )
                ],
              ),
              actions: const [
                // ClickableSvgIcon(
                //     svgAsset: QuikAssetConstants.bellNotificationActiveSvg,
                //     onTap: () {
                //       //HANDLE GO TO NOTIFICATIONS
                //     }),
                // QuikSpacing.hS10(),
                // ClickableSvgIcon(
                //     svgAsset: QuikAssetConstants.logoutSvg,
                //     onTap: () {
                //       context.read<SignInBloc>().add(const SignOutRequired());
                //     }),
                // QuikSpacing.hS24(),
              ],
            ),
          ),
        ),

        // body: Center(child: Text(serviceModel.title)));
        body: const Center(child: Text('No Sub Service Selected')));
  }
}
