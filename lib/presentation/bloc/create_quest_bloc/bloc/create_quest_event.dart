part of 'create_quest_bloc.dart';

sealed class CreateQuestEvent extends Equatable {
  const CreateQuestEvent();

  @override
  List<Object> get props => [];
}

class AddQuestionEvent extends CreateQuestEvent {
  AddQuestionEvent();
}
class FinishAddQuestionEvent extends CreateQuestEvent {
  QuestionEntity? questionEntity;
FinishAddQuestionEvent({this.questionEntity});
}

class AddLocationEvent extends CreateQuestEvent {
  AddLocationEvent();
}
class FinishAddLocationEvent extends CreateQuestEvent {
  List<LocationEntity>? locationEntities;
FinishAddLocationEvent({this.locationEntities});
}

class FinishCreationQuestEvent extends CreateQuestEvent {
  const FinishCreationQuestEvent();
}
