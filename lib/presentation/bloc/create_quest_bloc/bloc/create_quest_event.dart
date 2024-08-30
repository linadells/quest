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
  QuestionModel? questionModel;
FinishAddQuestionEvent({this.questionModel});
}

class AddLocationEvent extends CreateQuestEvent {
  AddLocationEvent();
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