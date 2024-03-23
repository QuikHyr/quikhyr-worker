import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:quikhyr_worker/common/quik_asset_constants.dart';
import 'package:quikhyr_worker/common/quik_colors.dart';
import 'package:quikhyr_worker/common/quik_spacings.dart';
import 'package:quikhyr_worker/common/widgets/named_nav_bar_item_widget.dart';

class MainWrapper extends StatefulWidget {
  const MainWrapper({Key? key, required this.navigationShell})
      : super(key: key);

  final StatefulNavigationShell navigationShell;

  @override
  State<MainWrapper> createState() => _MainWrapperState();
}

class _MainWrapperState extends State<MainWrapper> {
  int selectedIndex = 0;

  void _goToBranch(int index) {
    widget.navigationShell.goBranch(index,
        initialLocation: index == widget.navigationShell.currentIndex);
  }

  final tabs = [
    NamedNavigationBarItemWidget(
      activeIcon: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            QuikAssetConstants.homeNavBarActiveSvg,
          ),
          QuikSpacing.hS2(),
          Text("Home", style: ThemeData.dark().textTheme.bodyLarge),
        ],
      ),
      icon: SvgPicture.asset(
        QuikAssetConstants.homeNavBarSvg,
      ),
      label: 'Home',
    ),
    NamedNavigationBarItemWidget(
      activeIcon: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            QuikAssetConstants.chatNavBarActiveSvg,
          ),
          QuikSpacing.hS2(),
          Text("Chat", style: ThemeData.dark().textTheme.bodyLarge),
        ],
      ),
      icon: SvgPicture.asset(
        QuikAssetConstants.chatNavBarSvg,
      ),
      label: 'Chat',
    ),
    NamedNavigationBarItemWidget(
      activeIcon: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            QuikAssetConstants.bookNavBarActiveSvg,
          ),
          QuikSpacing.hS2(),
          Text("Book", style: ThemeData.dark().textTheme.bodyLarge),
        ],
      ),
      icon: SvgPicture.asset(
        QuikAssetConstants.bookNavBarSvg,
      ),
      label: 'Bookmark',
    ),
    NamedNavigationBarItemWidget(
      activeIcon: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            QuikAssetConstants.feedbackActiveSvg,
          ),
          QuikSpacing.hS2(),
          Text(
              overflow: TextOverflow.clip,
              "Feedback",
              style: ThemeData.dark().textTheme.bodyLarge),
        ],
      ),
      icon: SvgPicture.asset(
        QuikAssetConstants.feedbackSvg,
      ),
      label: 'Feedback',
    ),
    NamedNavigationBarItemWidget(
      activeIcon: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            QuikAssetConstants.settingsActiveSvg,
          ),
          QuikSpacing.hS2(),
          Text("Settings", style: ThemeData.dark().textTheme.bodyLarge),
        ],
      ),
      icon: SvgPicture.asset(
        QuikAssetConstants.settingsSvg,
      ),
      label: 'Settings',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (Navigator.canPop(context)) {
        Navigator.pop(context);
      }
    });

    return WillPopScope(
      onWillPop: () async {
        bool shouldClose = await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Confirmation'),
            content: const Text('Are you sure you want to close the app?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('No'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: const Text('Yes'),
              ),
            ],
          ),
        );
        return shouldClose;
        //return shouldClose ?? false
      },
      child: Scaffold(
        body: widget.navigationShell,
        // bottomNavigationBar: _buildBottomNavigation(context, tabs),
        bottomNavigationBar: Container(
          decoration: const BoxDecoration(
              border:
                  Border(top: BorderSide(color: placeHolderText, width: 0.3))),
          child: BottomNavigationBar(
            items: tabs,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            elevation: 0,
            backgroundColor: Colors.black,
            currentIndex: selectedIndex,
            type: BottomNavigationBarType.shifting,
            onTap: (index) {
              setState(() {
                selectedIndex = index;
                //if having lag move _goToBranch(index) to the bottom of the setState
                _goToBranch(index);
              });
            },
          ),
        ),
      ),
    );
  }
}

// BlocBuilder<NavigationCubit, NavigationState> _buildBottomNavigation(
//         mContext, List<NamedNavigationBarItemWidget> tabs) =>
//     BlocBuilder<NavigationCubit, NavigationState>(
//       buildWhen: (previous, current) => previous.index != current.index,
//       builder: (context, state) {
//         return BottomNavigationBar(
//           onTap: (value) {
//             // if (state.index != value) {
//             //   context.read<NavigationCubit>().getNavBarItem(value);
//             //   context.go(tabs[value].initialLocation);
//             // }
//           },
//           showSelectedLabels: false,
//           showUnselectedLabels: false,
//           elevation: 0,
//           backgroundColor: Colors.black,
//           unselectedItemColor: Colors.white,
//           // selectedIconTheme: IconThemeData(
//           //   size: ((IconTheme.of(mContext).size)! * 1.3),
//           // ),
//           items: tabs,
//           currentIndex: state.index,
//           type: BottomNavigationBarType.fixed,
//         );
//       },
//     );
