import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quest/data/models/quest.dart';
import 'package:quest/domain/entities/quest.dart';
import 'package:quest/domain/entities/question.dart';
import 'package:quest/domain/repository/quest_repository.dart';
import 'package:quest/injection_container.dart';
import 'package:quest/presentation/bloc/create_quest_bloc/bloc/create_quest_bloc.dart';

class QuestRepositoryImpl implements QuestRepository {
  @override
  Future<String> createQuest(QuestModel quest) async {
    String res;
    try {
      final db = sl<FirebaseFirestore>();
      res=await db.collection("quest").add(quest.toJson()).then((DocumentReference doc) {
        print('DocumentSnapshot added with ID: ${doc.id}');
        return doc.id;
      });
      return res;
    } catch (e) {
      print(e);
      throw Exception(e);
    }
  }

  @override
  Future<List<QuestModel>> getMyQuests(String email) async {
    try {
      final db = sl<FirebaseFirestore>();
      var querySnapshot = await db
          .collection("quest")
          .where("creatorEmail", isEqualTo: email)
          .get();
      var quests = querySnapshot.docs.map((doc) {
        return QuestModel.fromJson(doc.data(), doc.id);
      }).toList();
      return quests;
    } catch (e) {
      print(e);
    }
    return Future<List<QuestModel>>(
      () {
        return List.empty();
      },
    );
  }

  @override
  Future<void> editQuest(QuestModel quest) async {
    try {
      final db = sl<FirebaseFirestore>();
      var collection = await db.collection("quest").doc(quest.id);
      await collection.update(quest.toJson());
    } catch (e) {
      print(e);
      throw(e);
    }
  }
}
