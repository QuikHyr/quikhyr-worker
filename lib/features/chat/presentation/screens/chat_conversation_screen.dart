import 'package:flutter/material.dart';
import 'package:quikhyr_worker/common/quik_spacings.dart';

class ChatConversationScreen extends StatelessWidget {
  const ChatConversationScreen({super.key});

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
                  // RichText(
                  //   text: const TextSpan(
                  //     children: [
                  //       TextSpan(
                  //         text: 'Q',
                  //         style:
                  //             TextStyle(fontFamily: 'Moonhouse', fontSize: 32),
                  //       ),
                  //       TextSpan(
                  //         text: 'uik',
                  //         style:
                  //             TextStyle(fontFamily: 'Moonhouse', fontSize: 24),
                  //       ),
                  //       TextSpan(
                  //         text: 'Chat',
                  //         style: TextStyle(
                  //             fontFamily: 'Trap',
                  //             fontSize: 24,
                  //             letterSpacing: -1.5),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                ],
              ),
              // actions: [
              //   ClickableSvgIcon(
              //       svgAsset: QuikAssetConstants.callingSvg,
              //       onTap: () {
              //         //HANDLE GO TO NOTIFICATIONS
              //       }),
              //   QuikSpacing.hS10(),
              //   ClickableSvgIcon(
              //       svgAsset: QuikAssetConstants.cameraSvg,
              //       onTap: () {
              //         // context.read<SignInBloc>().add(const SignOutRequired());
              //       }),
              //   QuikSpacing.hS24(),
              // ],
            ),
          ),
        ),
        body: Padding(
          padding:
              const EdgeInsets.only(left: 24, right: 24, top: 24, bottom: 0),
          child: Column(children: [
            QuikSpacing.vS24(),
            const Center(child: Text("Chat Conversation Screen")),
            // Expanded(
            //   child: ListView(
            //     shrinkWrap: true,
            //     children: [
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
            //                   "assets/images/ratedWorker2.png",
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
            //                       QuikAssetConstants.chatGreenBubbleSvg)),
            //             ],
            //           ),
            //         ),
            //         title: Text("Kenny Kirk",
            //             style: Theme.of(context).textTheme.headlineSmall),
            //         subtitle: const Text("Will meet you tomorrow.",
            //             style: chatSubTitle),
            //         trailing: const Text(
            //           "7:04 pm",
            //           style: chatTrailingActive,
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
        ));
  }
}
