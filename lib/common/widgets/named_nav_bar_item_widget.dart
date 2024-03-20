import 'package:flutter/material.dart';

enum LabelPosition { right, left }

class NamedNavigationBarItemWidget extends BottomNavigationBarItem {


  NamedNavigationBarItemWidget({required Widget activeIcon, required Widget icon, String? label}) : super(icon: icon, label: label, activeIcon: activeIcon);

}
