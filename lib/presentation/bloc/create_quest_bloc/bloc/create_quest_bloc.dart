import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:quest/data/models/quest.dart';
import 'package:quest/data/repository/quest_repository.dart';
import 'package:quest/domain/entities/location.dart';
import 'package:quest/domain/entities/question.dart';
import 'package:quest/injection_container.dart';

part 'create_quest_event.dart';
part 'create_quest_state.dart';

class CreateQuestBloc extends Bloc<CreateQuestEvent, CreateQuestState> {
  QuestModel questModel = QuestModel();
  CreateQuestBloc() : super(CreateQuestInitialState()) {
    on<AddQuestionEvent>(onAddQuestion);
    on<FinishCreationQuestEvent>(onFinishQuestCreation);
    on<FinishAddQuestionEvent>(onFinishAddQuestion);
    on<AddLocationEvent>(onAddLocation);
    on<FinishAddLocationEvent>(onFinishAddLocation);
  }

  onAddQuestion(AddQuestionEvent event, Emitter<CreateQuestState> emit) {
    emit(AddingQuestionState());
  }

  onFinishAddQuestion(
      FinishAddQuestionEvent event, Emitter<CreateQuestState> emit) {
    if (event.questionEntity != null)
      questModel.questions != null
          ? questModel.questions?.add(event.questionEntity!)
          : questModel.questions = [event.questionEntity!];
    emit(CreateQuestInitialState());
  }

  onAddLocation(AddLocationEvent event, Emitter<CreateQuestState> emit) {
    emit(AddingLocationState());
  }

  onFinishAddLocation(
      FinishAddLocationEvent event, Emitter<CreateQuestState> emit) {
    if (event.locationEntities != null)
      questModel.locations != null
          ? questModel.locations?.addAll(event.locationEntities!)
          : questModel.locations = event.locationEntities!;
    emit(CreateQuestInitialState());
  }

  onFinishQuestCreation(
      FinishCreationQuestEvent event, Emitter<CreateQuestState> emit) async {
        print('in finish');
    emit(LoadingQuestCreationState());
    await sl<QuestRepositoryImpl>().createQuest(questModel);
    emit(FinishQuestCreationState());
  }
}
