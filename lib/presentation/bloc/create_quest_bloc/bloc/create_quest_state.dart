part of 'create_quest_bloc.dart';

sealed class CreateQuestState extends Equatable {
  const CreateQuestState();

  @override
  List<Object> get props => [];
}

final class CreateQuestInitialState extends CreateQuestState {
  CreateQuestInitialState();
}

final class AddingQuestionState extends CreateQuestState {
  AddingQuestionState();
}

final class AddingLocationState extends CreateQuestState {
  AddingLocationState();
}

final class LoadingQuestCreationState extends CreateQuestState {}

final class FinishQuestCreationState extends CreateQuestState {
  const FinishQuestCreationState();
}

final class ErrorQuestCreationState extends CreateQuestState {
  final Exception error;
  const ErrorQuestCreationState({required this.error});
}
