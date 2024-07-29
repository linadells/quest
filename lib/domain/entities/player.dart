import 'package:quest/domain/entities/quest.dart';

class PlayerEntity{
  String nickname;
  Map<QuestEntity, int> quests;
  PlayerEntity({required this.nickname, required this.quests});
}