part of 'create_quest_bloc.dart';

sealed class CreateQuestEvent extends Equatable {
  const CreateQuestEvent();

  @override
  List<Object> get props => [];
}

class AddQuestionEvent extends CreateQuestEvent {
  const AddQuestionEvent();
}

class EditQuestionEvent extends CreateQuestEvent {
  QuestionModel questionModel;
  EditQuestionEvent(this.questionModel);
}


class FinishEditQuestionEvent extends CreateQuestEvent {
  QuestionModel questionModel, oldQuestionModel;
FinishEditQuestionEvent({required this.questionModel, required this.oldQuestionModel});
}

class EditLocationEvent extends CreateQuestEvent {
  LocationModel locationModel;
  EditLocationEvent(this.locationModel);
}


class FinishEditLocationEvent extends CreateQuestEvent {
  LocationModel locationModel, oldLocationModel;
FinishEditLocationEvent({required this.locationModel, required this.oldLocationModel});
}

class FinishAddQuestionEvent extends CreateQuestEvent {
  QuestionModel? questionModel;
FinishAddQuestionEvent({this.questionModel});
}

class AddLocationEvent extends CreateQuestEvent {
  const AddLocationEvent();
}
class FinishAddLocationEvent extends CreateQuestEvent {
  List<LocationModel>? locationModels;
FinishAddLocationEvent({this.locationModels});
}

class FinishCreationQuestEvent extends CreateQuestEvent {
  const FinishCreationQuestEvent();
}

class LeaveQuestCreationEvent extends CreateQuestEvent{
  const LeaveQuestCreationEvent();
}

class EditQuestEvent extends CreateQuestEvent{
  QuestModel questModel;
  EditQuestEvent({required this.questModel});
}

class EditInDataBaseQuestEvent extends CreateQuestEvent{
  QuestModel questModel;
  EditInDataBaseQuestEvent({required this.questModel});
}

class StartCreatingQuestEvent extends CreateQuestEvent{
  QuestModel questModel;
  StartCreatingQuestEvent({required this.questModel});
}