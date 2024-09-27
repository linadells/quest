import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:quest/data/models/location.dart';
import 'package:quest/data/models/quest.dart';
import 'package:quest/data/models/question.dart';
import 'package:quest/data/repository/quest_repository.dart';
import 'package:quest/domain/entities/question.dart';
import 'package:quest/injection_container.dart';

part 'create_quest_event.dart';
part 'create_quest_state.dart';

class CreateQuestBloc extends Bloc<CreateQuestEvent, CreateQuestState> {
  QuestModel questModel;
  CreateQuestBloc(this.questModel) : super(CreateQuestInitialState()) {
    on<AddQuestionEvent>(onAddQuestion);
    on<FinishCreationQuestEvent>(onFinishQuestCreation);
    on<FinishAddQuestionEvent>(onFinishAddQuestion);
    on<AddLocationEvent>(onAddLocation);
    on<FinishAddLocationEvent>(onFinishAddLocation);
    on<LeaveQuestCreationEvent>(onLeaveQuestCreation);
    on<EditQuestionEvent>(onEditQuestion);
    on<FinishEditQuestionEvent>(onFinishEditQuestion);
    on<EditLocationEvent>(onEditLocation);
    on<FinishEditLocationEvent>(onFinishEditLocation);
    on<EditQuestEvent>(onEditQuestEvent);
    on<EditInDataBaseQuestEvent>(onEditInDataBaseEvent);
    on<StartCreatingQuestEvent>(onStartCreationQuest);
  }

  onAddQuestion(AddQuestionEvent event, Emitter<CreateQuestState> emit) {
    emit(AddingQuestionState());
  }

  onAddLocation(AddLocationEvent event, Emitter<CreateQuestState> emit) {
    emit(AddingLocationState());
  }

  onFinishAddQuestion(
      FinishAddQuestionEvent event, Emitter<CreateQuestState> emit) {
    if (event.questionModel != null) {
      questModel.questions != null
          ? questModel.questions?.add(event.questionModel!)
          : questModel.questions = [event.questionModel!];
    }
    emit(CreateQuestInitialState());
  }

  onFinishAddLocation(
      FinishAddLocationEvent event, Emitter<CreateQuestState> emit) {
    if (event.locationModels != null) {
      questModel.locations != null
          ? questModel.locations?.addAll(event.locationModels!)
          : questModel.locations = event.locationModels!;
    }
    emit(CreateQuestInitialState());
  }

  onEditQuestion(EditQuestionEvent event, Emitter<CreateQuestState> emit) {
    emit(EditingQuestionState(event.questionModel));
  }

  onEditLocation(EditLocationEvent event, Emitter<CreateQuestState> emit) {
    emit(EditingLocationState(event.locationModel));
  }

  onFinishEditQuestion(
      FinishEditQuestionEvent event, Emitter<CreateQuestState> emit) {
    int tmp = questModel.questions!.indexOf(event.oldQuestionModel);
    questModel.questions![tmp] = event.questionModel;
    emit(CreateQuestInitialState());
  }

  onFinishEditLocation(
      FinishEditLocationEvent event, Emitter<CreateQuestState> emit) {
    int tmp = questModel.locations!.indexOf(event.oldLocationModel);
    questModel.locations![tmp] = event.locationModel;
    emit(CreateQuestInitialState());
  }

  onFinishQuestCreation(
      FinishCreationQuestEvent event, Emitter<CreateQuestState> emit) async {
    emit(LoadingQuestCreationState());
    try {
      questModel.id = await sl<QuestRepositoryImpl>().createQuest(questModel);
    } on Exception catch (e) {
      emit(ErrorQuestCreationState(error: e));
    }
    emit(const FinishQuestCreationState());
  }

  onLeaveQuestCreation(
      LeaveQuestCreationEvent event, Emitter<CreateQuestState> emit) {
    emit(const DoneQuestCreationState());
  }

  onEditQuestEvent(EditQuestEvent event, Emitter<CreateQuestState> emit) {
    questModel = event.questModel;
    emit(EdditingQuestState());
  }

  onEditInDataBaseEvent(
      EditInDataBaseQuestEvent event, Emitter<CreateQuestState> emit) async {
    emit(LoadingQuestCreationState());
    try {
      await sl<QuestRepositoryImpl>().editQuest(questModel);
    } on Exception catch (e) {
      ErrorQuestCreationState(error: e);
    }
    emit(FinishQuestCreationState());
  }

  onStartCreationQuest(StartCreatingQuestEvent event, Emitter<CreateQuestState> emit){
    questModel=event.questModel;
  }
}
