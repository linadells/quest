import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quest/data/models/quest.dart';
import 'package:quest/domain/entities/quest.dart';
import 'package:quest/domain/entities/question.dart';
import 'package:quest/domain/repository/quest_repository.dart';
import 'package:quest/injection_container.dart';

class QuestRepositoryImpl implements QuestRepository {
  @override
  void createQuest(QuestEntity quest) {
    if (quest is QuestModel) {
      final db = sl<FirebaseFirestore>();
      db.collection("quest").add(quest.toJson()).then((DocumentReference doc) =>
          print('DocumentSnapshot added with ID: ${doc.id}'));
    }
  }

  @override
  void createQuestion(QuestEntity quest, QuestionEntity question) {
    final db = sl<FirebaseFirestore>();
    //db.collection("quest").add(user).then((DocumentReference doc) =>
    //print('DocumentSnapshot added with ID: ${doc.id}'));
  }
}
