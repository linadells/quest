
import 'package:flutter/material.dart';
import 'package:quest/core/style.dart';

class NavigationBarCreateQuest extends StatelessWidget {
  const NavigationBarCreateQuest({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const BottomAppBar(
      child: TabBar(
        labelColor: kMedium,
        unselectedLabelColor: Colors.white,
        indicatorSize: TabBarIndicatorSize.label,
        tabs: [
          Tab(icon: Icon(Icons.question_mark), text: 'Questions'),
          Tab(icon: Icon(Icons.location_pin), text: 'Locations'),
          Tab(icon: Icon(Icons.settings), text: 'Settings'),
        ],
      ),
      color: kDark,
    );
  }
}
