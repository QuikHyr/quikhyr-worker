import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:quikhyr_worker/common/bloc/worker_bloc.dart';
import 'package:quikhyr_worker/common/quik_asset_constants.dart';
import 'package:quikhyr_worker/common/quik_colors.dart';
import 'package:quikhyr_worker/common/quik_routes.dart';
import 'package:quikhyr_worker/common/quik_spacings.dart';
import 'package:quikhyr_worker/common/quik_themes.dart';
import 'package:quikhyr_worker/common/widgets/clickable_svg_icon.dart';
import 'package:quikhyr_worker/common/widgets/gradient_separator.dart';
import 'package:quikhyr_worker/features/auth/blocs/sign_in_bloc/sign_in_bloc.dart';

import '../../../../notification/cubit/notification_cubit.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  final TextEditingController _pincodeController = TextEditingController();

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
                        text: 'Hyr',
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
                    context.read<NotificationCubit>().getNotifications();
                    context.pushNamed(QuikRoutes.notificationName);
                  }),
              QuikSpacing.hS10(),
              ClickableSvgIcon(
                  svgAsset: QuikAssetConstants.logoutSvg,
                  onTap: () {
                    context.read<SignInBloc>().add(const SignOutRequired());
                  }),
              QuikSpacing.hS24(),
            ],
          ),
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) => SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: BlocBuilder<WorkerBloc, WorkerState>(
              builder: (context, state) {
                if (state is WorkerLoaded) {
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () {
                            context.pushNamed(QuikRoutes.mapName,
                                extra: state.worker.location);
                          }
                          // onTap: () async {
                          //   context.read<WorkerBloc>().add(FetchInitiated());

                          //   bool serviceEnabled;
                          //   LocationPermission permissionGranted;

                          //   serviceEnabled =
                          //       await Geolocator.isLocationServiceEnabled();
                          //   if (!serviceEnabled) {
                          //     ScaffoldMessenger.of(context).showSnackBar(
                          //       const SnackBar(
                          //         content:
                          //             Text('Please enable location services'),
                          //       ),
                          //     );
                          //     return;
                          //   }

                          //   permissionGranted =
                          //       await Geolocator.checkPermission();
                          //   if (permissionGranted ==
                          //       LocationPermission.denied) {
                          //     permissionGranted =
                          //         await Geolocator.requestPermission();
                          //     if (permissionGranted !=
                          //             LocationPermission.always &&
                          //         permissionGranted !=
                          //             LocationPermission.whileInUse) {
                          //       if (context.mounted) {
                          //         ScaffoldMessenger.of(context).showSnackBar(
                          //           const SnackBar(
                          //             content: Text(
                          //                 'Location permission is denied'),
                          //           ),
                          //         );
                          //       }
                          //       return;
                          //     }
                          //   }

                          //   Position position =
                          //       await Geolocator.getCurrentPosition(
                          //           desiredAccuracy: LocationAccuracy.high);
                          //   context.read<WorkerBloc>().add(UpdateLocation(
                          //       LocationModel(
                          //           latitude: position.latitude,
                          //           longitude: position.longitude)));
                          // },
                          ,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                QuikAssetConstants.locationFilledSvg,
                                color: primary,
                              ),
                              Text(
                                state.worker.locationName ?? "Location",
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineSmall
                                    ?.copyWith(fontWeight: FontWeight.w700),
                              ),
                              ClickableSvgIcon(
                                  svgAsset: QuikAssetConstants.dropDownArrowSvg,
                                  height: 18,
                                  width: 18,
                                  onTap: () {}),
                            ],
                          ),
                        ),
                        const GradientSeparator(),
                        QuikSpacing.vS32(),
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                height: 64,
                                padding: EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: quikHyrYellowBg,
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Row(children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      color: quikHyrYellowBg,
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    child: Image.network(state.worker.avatar),
                                  ),
                                  QuikSpacing.hS12(),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        state.worker.name,
                                        style: workerListNameTextStyle,
                                      ),
                                      QuikSpacing.vS12(),
                                      Text(
                                        state.worker.available
                                            ? "Available"
                                            : "Unavailable",
                                        style: availabilityTextStyle400,
                                      )
                                    ],
                                  )
                                ]),
                              ),
                            ),
                            QuikSpacing.hS16(),
                            Container(
                              padding: EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: quikHyrYellowBg,
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: ClickableSvgIcon(
                                height: 32,
                                width: 32,
                                svgAsset: QuikAssetConstants.qrCodeSvg,
                                onTap: () {},
                              ),
                            ),
                          ],
                        ),
                        QuikSpacing.vS16(),
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          decoration: BoxDecoration(
                              color: quikHyrYellowBg,
                              borderRadius: BorderRadius.circular(16)),
                          child: Row(
                            children: [
                              QuikSpacing.hS20(),
                              const Text(
                                "Availability Status",
                                style: workerListNameTextStyle,
                              ),
                              const Spacer(),
                              CupertinoSwitch(
                                  thumbColor: secondary,
                                  activeColor: quikHyrYellow,
                                  trackColor: quikHyrYellow.withOpacity(0.3),
                                  value: state.worker.available,
                                  onChanged: (onChanged) {
                                    context
                                        .read<WorkerBloc>()
                                        .add(UpdateAvailability(onChanged));
                                  }),
                              QuikSpacing.hS16(),
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                } else if (state is WorkerError) {
                  return Text(state.error);
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text('Update Pincode'),
                content: TextField(
                  controller: _pincodeController,
                  decoration: InputDecoration(hintText: "Enter new pincode"),
                ),
                actions: <Widget>[
                  TextButton(
                    child: Text('Update'),
                    onPressed: () {
                      context
                          .read<WorkerBloc>()
                          .add(UpdatePincode(_pincodeController.text));
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          );
        },
        child: const Icon(Icons.edit),
      ),
    );
  }
}
