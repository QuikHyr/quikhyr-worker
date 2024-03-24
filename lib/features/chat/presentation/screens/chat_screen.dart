import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quikhyr_worker/common/quik_asset_constants.dart';
import 'package:quikhyr_worker/common/quik_spacings.dart';
import 'package:quikhyr_worker/common/widgets/clickable_svg_icon.dart';
import 'package:quikhyr_worker/common/widgets/gradient_separator.dart';
import 'package:quikhyr_worker/common/widgets/quik_search_bar.dart';
import 'package:quikhyr_worker/features/chat/firebase_provider.dart';
import 'package:quikhyr_worker/features/chat/presentation/components/user_item.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  void initState() {
    Provider.of<FirebaseProvider>(context, listen: false).getAllClients();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

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
                          text: 'Chat',
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
                    onTap: () {}),
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
        body: Consumer<FirebaseProvider>(builder: (context, value, child) {
          return Padding(
            padding:
                const EdgeInsets.only(left: 24, right: 24, top: 24, bottom: 0),
            child: Column(children: [
              QuikSearchBar(
                onChanged: (String value) {}, // Default onChanged function
                hintText: 'Search for chats..', // Default hintText value
                onMicPressed: () {}, // Default onMicPressed function
                onSearch: (String onSearch) {}, // Default onSearch function
                controller: TextEditingController(), // Default controller
              ),
              QuikSpacing.vS24(),
              Expanded(
                  child: ListView.separated(
                separatorBuilder: (context, index) => const GradientSeparator(),
                itemBuilder: (context, index) {
                  return value.users[index].id !=
                          FirebaseAuth.instance.currentUser?.uid
                      ? UserItem(
                          client: value.users.elementAt(index),
                        )
                      : const SizedBox();
                },
                itemCount: value.users.length,
              )),

              // Expanded(
              //   child: ListView(
              //     shrinkWrap: true,
              //     children: [
              // ListTile(
              //   contentPadding: EdgeInsets.zero,
              //   leading: Container(
              //     decoration: const BoxDecoration(
              //       shape: BoxShape.circle,
              //       color: gridItemBackgroundColor,
              //     ),
              //     alignment: Alignment.center,
              //     height: 64,
              //     width: 64,
              //     child: Stack(
              //       children: [
              //         const Positioned.fill(
              //             child: CircleAvatar(
              //           backgroundImage: AssetImage(
              //             "assets/images/ratedWorker2.png",
              //           ),
              //         )),
              //         // if (state.workers[index].isVerified)
              //         Positioned(
              //           top: 0,
              //           right: 0,
              //           child: SvgPicture.asset(
              //             QuikAssetConstants.verifiedBlueSvg,
              //           ),
              //         ),
              //         Positioned(
              //             bottom: 0,
              //             left: 4,
              //             child: SvgPicture.asset(
              //                 QuikAssetConstants.chatGreenBubbleSvg)),
              //       ],
              //     ),
              //   ),
              //   title: Text("Kenny Kirk",
              //       style: Theme.of(context).textTheme.headlineSmall),
              //   subtitle: const Text("Will meet you tomorrow.",
              //       style: chatSubTitle),
              //   trailing: const Text(
              //     "7:04 pm",
              //     style: chatTrailingActive,
              //   ),
              //   onTap: () =>
              //       context.pushNamed(Routes.chatConversationNamedPageName),
              // ),
              // const GradientSeparator(),
              //       ListTile(
              //         contentPadding: EdgeInsets.zero,
              //         leading: Container(
              //           decoration: const BoxDecoration(
              //             shape: BoxShape.circle,
              //             color: gridItemBackgroundColor,
              //           ),
              //           alignment: Alignment.center,
              //           height: 64,
              //           width: 64,
              //           child: Stack(
              //             children: [
              //               const Positioned.fill(
              //                   child: CircleAvatar(
              //                 backgroundImage: AssetImage(
              //                   "assets/images/ratedWorker3.png",
              //                 ),
              //               )),
              //               // if (state.workers[index].isVerified)
              //               Positioned(
              //                 top: 0,
              //                 right: 0,
              //                 child: SvgPicture.asset(
              //                   QuikAssetConstants.verifiedBlueSvg,
              //                 ),
              //               ),
              //               Positioned(
              //                   bottom: 0,
              //                   left: 4,
              //                   child: SvgPicture.asset(
              //                       QuikAssetConstants.chatGreyBubbleSvg)),
              //             ],
              //           ),
              //         ),
              //         title: Text("Henry Kal",
              //             style: Theme.of(context).textTheme.headlineSmall),
              //         subtitle: const Text("Payment has been transferred.",
              //             overflow: TextOverflow.ellipsis,
              //             style: chatSubTitleRead),
              //         trailing: const Text(
              //           "Yesterday",
              //           style: chatTrailingInactive,
              //         ),
              //       ),
              //       const GradientSeparator(),
              //       ListTile(
              //         contentPadding: EdgeInsets.zero,
              //         leading: Container(
              //           decoration: const BoxDecoration(
              //             shape: BoxShape.circle,
              //             color: gridItemBackgroundColor,
              //           ),
              //           alignment: Alignment.center,
              //           height: 64,
              //           width: 64,
              //           child: Stack(
              //             children: [
              //               const Positioned.fill(
              //                   child: CircleAvatar(
              //                 backgroundImage: AssetImage(
              //                   "assets/images/ratedWorker1.png",
              //                 ),
              //               )),
              //               // if (state.workers[index].isVerified)
              //               Positioned(
              //                 top: 0,
              //                 right: 0,
              //                 child: SvgPicture.asset(
              //                   QuikAssetConstants.verifiedBlueSvg,
              //                 ),
              //               ),
              //               Positioned(
              //                   bottom: 0,
              //                   left: 4,
              //                   child: SvgPicture.asset(
              //                       QuikAssetConstants.chatGreyBubbleSvg)),
              //             ],
              //           ),
              //         ),
              //         title: Text("John Burke",
              //             style: Theme.of(context).textTheme.headlineSmall),
              //         subtitle: const Text("Thank you for choosing me.",
              //             style: chatSubTitle),
              //         trailing: const Text("29/02/24", style: chatTrailingActive),
              //       ),
              //     ],
              //   ),
              // )
            ]),
          );
        }));
  }
}
