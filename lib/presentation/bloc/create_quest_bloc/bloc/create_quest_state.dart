part of 'create_quest_bloc.dart';

sealed class CreateQuestState extends Equatable {
  const CreateQuestState();

  @override
  List<Object> get props => [];
}

final class CreateQuestInitialState extends CreateQuestState {
  const CreateQuestInitialState();
}

final class AddingQuestionState extends CreateQuestState {
  const AddingQuestionState();
}

final class EditingQuestionState extends CreateQuestState {
  QuestionModel questionModel;
  EditingQuestionState(this.questionModel);
}

final class EditingLocationState extends CreateQuestState {
  LocationModel locationModel;
  EditingLocationState(this.locationModel);
}

final class AddingLocationState extends CreateQuestState {
  const AddingLocationState();
}

final class LoadingQuestCreationState extends CreateQuestState {}

final class FinishQuestCreationState extends CreateQuestState {
  const FinishQuestCreationState();
}

final class DoneQuestCreationState extends CreateQuestState {
  const DoneQuestCreationState();
}

final class ErrorQuestCreationState extends CreateQuestState {
  final Exception error;
  const ErrorQuestCreationState({required this.error});
}

final class EdditingQuestState extends CreateQuestState{
  EdditingQuestState();
}