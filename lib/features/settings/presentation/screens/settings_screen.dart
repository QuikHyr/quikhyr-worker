import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../common/bloc/worker_bloc.dart';
import '../../../../common/quik_asset_constants.dart';
import '../../../../common/quik_colors.dart';
import '../../../../common/quik_spacings.dart';
import '../../../../common/widgets/clickable_svg_icon.dart';
import '../../../../common/widgets/gradient_separator.dart';
import '../../../../common/widgets/quik_search_bar.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 337,
        titleSpacing: 24,
        automaticallyImplyLeading: false, // Remove back button
        backgroundColor: Colors.transparent,
        title: Container(
          padding: const EdgeInsets.only(top: 18),
          height: 337,
          child: Column(
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
              QuikSpacing.vS30(),
              QuikSearchBar(
                onChanged: (String onChanged) {},
                hintText: 'Search for settings..',
                onMicPressed: () {},
                onSearch: (String value) {},
                controller: TextEditingController(),
              ),
              const SizedBox(
                height: 24,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'PROFILE',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      BlocBuilder<WorkerBloc, WorkerState>(
                        builder: (context, state) {
                          if (state is WorkerLoaded) {
                            return CircleAvatar(
                              radius: 32,
                              backgroundImage:
                                  NetworkImage(state.worker.avatar),
                            );
                          } else {
                            return const CircleAvatar(
                              radius: 32,
                              backgroundImage: NetworkImage(
                                  QuikAssetConstants.placeholderImage),
                            );
                          }
                        },
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          BlocBuilder<WorkerBloc, WorkerState>(
                            builder: (context, state) {
                              if (state is WorkerLoaded) {
                                return Text(
                                  state.worker.name,
                                  style: const TextStyle(
                                    color: Color(0xFFFAFFFF),
                                    fontFamily: 'Trap',
                                    fontSize: 20,
                                    fontStyle: FontStyle.normal,
                                    fontWeight: FontWeight.w700,
                                    height: 1.0,
                                  ),
                                );
                              } else {
                                return const Text(
                                  'Noah Johny',
                                  style: TextStyle(
                                    color: Color(0xFFFAFFFF),
                                    fontFamily: 'Trap',
                                    fontSize: 20,
                                    fontStyle: FontStyle.normal,
                                    fontWeight: FontWeight.w700,
                                    height: 1.0,
                                  ),
                                );
                              }
                            },
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          Text(
                            'MEMBER',
                            style: TextStyle(
                              color: Color(0xFF3399CC),
                              fontFamily: 'Trap',
                              fontSize: 14,
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w500,
                              height: 1.0,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: OutlinedButton.icon(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.edit,
                        color: secondary,
                      ),
                      label: const Text(
                        'Edit',
                        style: TextStyle(
                          color: secondary,
                        ),
                      ),
                      style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: secondary)),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 24,
              ),
              const GradientSeparator(),
            ],
          ),
        ),
        // actions: [
        //   ClickableSvgIcon(
        //       svgAsset: QuikAssetConstants.bellNotificationActiveSvg,
        //       onTap: () {
        //         //HANDLE GO TO NOTIFICATIONS
        //       }),
        //   QuikSpacing.hS10(),
        //   ClickableSvgIcon(
        //       svgAsset: QuikAssetConstants.logoutSvg,
        //       onTap: () {
        //         // context.read<SignInBloc>().add(const SignOutRequired());
        //       }),
        //   QuikSpacing.hS24(),
        // ],
      ),
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'SETTINGS',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(
                height: 24,
              ),
              SingleChildScrollView(
                physics: const NeverScrollableScrollPhysics(),
                child: Column(
                  children: [
                    ListTile(
                      leading: ClickableSvgIcon(
                        svgAsset: QuikAssetConstants.accountSvg,
                        onTap: () {},
                      ),
                      title: Text(
                        'Manage Account',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                    ListTile(
                      leading: ClickableSvgIcon(
                        svgAsset: QuikAssetConstants.notificationsSvg,
                        onTap: () {},
                      ),
                      title: Text(
                        'Manage Notifications',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                    ListTile(
                      leading: ClickableSvgIcon(
                        svgAsset: QuikAssetConstants.blockSvg,
                        onTap: () {},
                      ),
                      title: Text(
                        'Block/Unblock Workers',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                'SUPPORT',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(
                height: 24,
              ),
              SingleChildScrollView(
                physics: const NeverScrollableScrollPhysics(),
                child: Column(
                  children: [
                    ListTile(
                      leading: ClickableSvgIcon(
                        svgAsset: QuikAssetConstants.faqSvg,
                        onTap: () {},
                      ),
                      title: Text(
                        'Explore FAQs',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                    ListTile(
                      leading: ClickableSvgIcon(
                        svgAsset: QuikAssetConstants.bugSvg,
                        onTap: () {},
                      ),
                      title: Text(
                        'Report Bugs',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                'ABOUT',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(
                height: 24,
              ),
              SingleChildScrollView(
                physics: const NeverScrollableScrollPhysics(),
                child: Column(
                  children: [
                    ListTile(
                      leading: ClickableSvgIcon(
                        svgAsset: QuikAssetConstants.termsAndConditionsSvg,
                        onTap: () {},
                      ),
                      title: Text(
                        'Terms and Conditions',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                    ListTile(
                      leading: ClickableSvgIcon(
                        svgAsset: QuikAssetConstants.privacySvg,
                        onTap: () {},
                      ),
                      title: Text(
                        'Privacy Policy',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                    // ListTile(
                    //  leading: Icon(Icons.info, color: secondary, size: 24),
                    //   title: Text(
                    //     'QuikHyr',
                    //     style: Theme.of(context).textTheme.bodyMedium,
                    //   ),
                    // )
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Icon(Icons.info_outline_rounded,
                              color: secondary, size: 24),
                          SizedBox(
                            width: 8,
                          ),
                          Text(
                            'QuikHyr',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
