import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:quikhyr_worker/common/quik_asset_constants.dart';
import 'package:quikhyr_worker/common/quik_routes.dart';
import 'package:quikhyr_worker/common/quik_spacings.dart';
import 'package:quikhyr_worker/common/quik_themes.dart';
import 'package:quikhyr_worker/common/widgets/clickable_svg_icon.dart';
import 'package:quikhyr_worker/common/widgets/gradient_separator.dart';
import 'package:quikhyr_worker/common/widgets/quik_search_bar.dart';
import 'package:quikhyr_worker/features/chat/firebase_firestore_service.dart';
import 'package:quikhyr_worker/features/chat/firebase_provider.dart';
import 'package:quikhyr_worker/features/chat/notification_service.dart';
import 'package:quikhyr_worker/models/chat_list_model.dart';
import 'package:quikhyr_worker/models/chat_message_model.dart';

import '../../../../common/utils/format_date.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> with WidgetsBindingObserver {
  final notificationService = NotificationsService();
  TextEditingController searchController = TextEditingController();
  List<ChatListModel> filteredClients = [];
  List<ChatListModel> allClients = [];

  Timer? searchDebounce;

  void filterClients(String query) {
    if (searchDebounce?.isActive ?? false) {
      searchDebounce?.cancel();
    }
    searchDebounce = Timer(const Duration(milliseconds: 500), () {
      if (query.isEmpty) {
        setState(() {
          filteredClients = allClients;
        });
      } else {
        setState(() {
          filteredClients = allClients.where((client) {
            return client.name.toLowerCase().contains(query.toLowerCase());
          }).toList();
        });
      }
    });
  }


  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    notificationService.firebaseNotification(context);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    switch (state) {
      case AppLifecycleState.resumed:
        FirebaseFirestoreService.updateUserData({
          'isActive': true,
        });
        break;
      case AppLifecycleState.inactive:
      case AppLifecycleState.paused:
      case AppLifecycleState.detached:
        FirebaseFirestoreService.updateUserData({
          'isActive': false,
        });
        break;
      default:
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    searchController.dispose();
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
                        style: TextStyle(fontFamily: 'Moonhouse', fontSize: 32),
                      ),
                      TextSpan(
                        text: 'uik',
                        style: TextStyle(fontFamily: 'Moonhouse', fontSize: 24),
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
        padding: const EdgeInsets.only(left: 24, right: 24, top: 24, bottom: 0),
        child: Column(
          children: [
            QuikSearchBar(
              onChanged: (String value) {
                filterClients(value);
              }, // Default onChanged function
              hintText: 'Search for clients..', // Default hintText value
              onMicPressed: () {}, // Default onMicPressed function
              onSearch: (String onSearch) {}, // Default onSearch function
              controller: searchController, // Default controller
            ),
            QuikSpacing.vS24(),
            Expanded(
              child: StreamBuilder<List<ChatListModel>>(
                stream: Provider.of<FirebaseProvider>(context)
                    .getAllClientsWithLastMessageStream(),
                builder: (context, snapshot) {
                  List<ChatListModel> clientsToShow =
                      filteredClients.isEmpty && searchController.text.isEmpty
                          ? allClients
                          : filteredClients;
                  // debugPrint("All Clients: $allClients");
                  // debugPrint('Clients to Show: $clientsToShow');
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    if (snapshot.hasData && snapshot.data!.isEmpty) {
                      return const Center(child: Text('No Chats Yet'));
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  } else if (snapshot.hasError) {
                    return const Center(child: Text('An error occurred'));
                  } else if (!snapshot.hasData) {
                    return const Text('No Chats Yet');
                  } else {
                    allClients = snapshot.data!;
                    allClients.sort((a, b) => b.sentTime.compareTo(a.sentTime));
                    return ListView.separated(
                      separatorBuilder: (context, index) =>
                          const GradientSeparator(),
                      itemBuilder: (context, index) {
                        return clientsToShow[index].id !=
                                FirebaseAuth.instance.currentUser?.uid
                            ? ListTile(
                                contentPadding: EdgeInsets.zero,
                                leading: Container(
                                  alignment: Alignment.center,
                                  height: 64,
                                  width: 64,
                                  child: Stack(
                                    children: [
                                      const Positioned.fill(
                                          child: CircleAvatar(
                                        backgroundColor: Colors.transparent,
                                        backgroundImage: NetworkImage(
                                          QuikAssetConstants.placeholderImage,
                                        ),
                                      )),
                                      // if (state.workers[index].isVerified)
                                      Positioned(
                                        top: 0,
                                        right: 0,
                                        child: SvgPicture.asset(
                                          QuikAssetConstants.verifiedBlueSvg,
                                        ),
                                      ),
                                      Positioned(
                                          bottom: 0,
                                          left: 4,
                                          child: SvgPicture.asset(
                                              clientsToShow[index].isActive
                                                  ? QuikAssetConstants
                                                      .chatGreenBubbleSvg
                                                  : QuikAssetConstants
                                                      .chatGreyBubbleSvg)),
                                    ],
                                  ),
                                ),
                                title: Text(clientsToShow[index].name,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall),
                                subtitle: clientsToShow[index].messageType ==
                                        MessageType.text
                                    ? Text(
                                        clientsToShow[index].lastMessage,
                                        overflow: TextOverflow.ellipsis,
                                        style: chatSubTitle,
                                      )
                                    : const Text(
                                        "Image received",
                                        style: chatSubTitle,
                                      ),
                                trailing: Text(
                                  formatDate(clientsToShow[index].sentTime)
                                      .toString(),
                                  style: chatTrailingActive,
                                ),
                                onTap: () {
                                  GoRouter.of(context).pushNamed(
                                      QuikRoutes.chatConversationName,
                                      pathParameters: {
                                        'clientId': clientsToShow[index].id
                                      });
                                },
                              )
                            : const SizedBox();
                      },
                      itemCount: clientsToShow.length,
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
