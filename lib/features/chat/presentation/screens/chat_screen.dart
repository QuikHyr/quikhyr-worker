import 'package:flutter/material.dart';
import 'package:quikhyr_worker/common/quik_asset_constants.dart';
import 'package:quikhyr_worker/common/quik_spacings.dart';
import 'package:quikhyr_worker/common/widgets/clickable_svg_icon.dart';
import 'package:quikhyr_worker/common/widgets/quik_search_bar.dart';

class Message {
  final String sender;
  final String message;

  Message(this.sender, this.message);
}

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});


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
        body: Padding(
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
                child: ListView.builder(
                  itemCount: 10, // Placeholder data
                  itemBuilder: (context, index) {
                    // Placeholder data
                    String senderName = 'John Doe';
                    String lastMessage = 'Hello!';
                    DateTime timestamp = DateTime.now();

                    return Column(
                      children: [
                        ListTile(
                          title: Text(senderName),
                          subtitle: Text(lastMessage),
                          trailing: Text(timestamp.toString()),
                        ),
                        Divider(),
                      ],
                    );
                  },
                ),
              ),
            ]))
        );
  }
}
