import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:quest/core/style.dart';
import 'package:quest/data/models/quest.dart';
import 'package:quest/data/repository/quest_repository.dart';
import 'package:quest/domain/repository/quest_repository.dart';
import 'package:quest/injection_container.dart';
import 'package:quest/presentation/bloc/create_quest_bloc/bloc/create_quest_bloc.dart';
import 'package:quest/presentation/routes.dart/routes_constants.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      drawer: Drawer(
          child: ListView(
        children: [
          ListTile(
            title: Row(
              children: [
                Container(
                    padding: const EdgeInsets.all(10),
                    child: const Icon(
                      Icons.supervised_user_circle,
                      size: 50,
                      color: kAccent,
                    )),
                Text(sl<FirebaseAuth>().currentUser!.displayName ??
                    'Unautorized'),
              ],
            ),
          ),
          ListTile(
            title: TextButton(
              onPressed: () {
                GoRouter.of(context).pop();
                GoRouter.of(context).pushNamed(MyRoutes.createQuestScreen);
                BlocProvider.of<CreateQuestBloc>(context).add(StartCreatingQuestEvent(questModel: QuestModel()));
              },
              child: const Text('Create quest'),
            ),
          ),
          ListTile(
            title: TextButton(
              onPressed: () async {
                List<QuestModel> q = await sl<QuestRepositoryImpl>()
                    .getMyQuests(sl<FirebaseAuth>().currentUser!.email!);
                GoRouter.of(context).pop();
                GoRouter.of(context).pushNamed(MyRoutes.allMyQuestsScreen, extra: q);
              },
              child: const Text('My quests'),
            ),
          ),
        ],
      )),
    );
  }
}
