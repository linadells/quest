part of 'create_quest_bloc.dart';

sealed class CreateQuestState extends Equatable {
  const CreateQuestState();
  
  @override
  List<Object> get props => [];
}

final class CreateQuestInitial extends CreateQuestState {}
