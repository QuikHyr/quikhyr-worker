import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:quikhyr_worker/common/quik_asset_constants.dart';
import 'package:quikhyr_worker/common/quik_routes.dart';
import 'package:quikhyr_worker/common/quik_themes.dart';
import 'package:quikhyr_worker/models/client_model.dart';

class UserItem extends StatefulWidget {
  const UserItem({super.key, required this.client});

  final ClientModel client;

  @override
  State<UserItem> createState() => _UserItemState();
}

class _UserItemState extends State<UserItem> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Container(
        alignment: Alignment.center,
        height: 64,
        width: 64,
        child: Stack(
          children: [
            const Positioned.fill(
                child: CircleAvatar(
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
                child: SvgPicture.asset(QuikAssetConstants.chatGreenBubbleSvg)),
          ],
        ),
      ),
      title: Text(widget.client.name,
          style: Theme.of(context).textTheme.headlineSmall),
      subtitle: Text(widget.client.id, style: chatSubTitle),
      trailing: const Text(
        "7:04 pm",
        style: chatTrailingActive,
      ),
      onTap: () {
        context.pushNamed(QuikRoutes.chatConversationName,
            extra: widget.client);
      },
    );
  }
}
