import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:quest/data/models/quest.dart';
import 'package:quest/domain/repository/quest_repository.dart';
import 'package:quest/injection_container.dart';
import 'package:quest/presentation/pages/all_quests.dart';
import 'package:quest/presentation/widgets/quest_creation/quest_in_list.dart';

class MyQuests extends StatelessWidget {
  List<QuestModel>? allQuests;
  MyQuests({super.key, this.allQuests});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Your quests',
          style: Theme.of(context)
              .textTheme
              .bodyMedium
              ?.copyWith(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: allQuests != null && allQuests!.isNotEmpty
          ? ListView.builder(
              itemCount: allQuests!.length,
              itemBuilder: (context, index) {
                return ListTile(
                    title: QuestInList(questModel: allQuests![index]));
              })
          : const Center(
              child: Text('You haven`t created any quests yet'),
            ),
    );
  }
}
