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
  QuestModel questModel = QuestModel();
  CreateQuestBloc() : super(CreateQuestInitialState()) {
    on<AddQuestionEvent>(onAddQuestion);
    on<FinishCreationQuestEvent>(onFinishQuestCreation);
    on<FinishAddQuestionEvent>(onFinishAddQuestion);
    on<AddLocationEvent>(onAddLocation);
    on<FinishAddLocationEvent>(onFinishAddLocation);
    on<LeaveQuestCreationEvent>(onLeaveQuestCreation);
    on<EditQuestionEvent>(onEditQuestion);
    on<FinishEditQuestionEvent>(onFinishEditQuestion);
  }

  onAddQuestion(AddQuestionEvent event, Emitter<CreateQuestState> emit) {
    emit(AddingQuestionState());
  }

  onEditQuestion(EditQuestionEvent event, Emitter<CreateQuestState> emit) {
    emit(EditingQuestionState(event.questionModel));
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

  onFinishEditQuestion(
      FinishEditQuestionEvent event, Emitter<CreateQuestState> emit) {
        int tmp =questModel.questions!.indexOf(event.oldQuestionModel);
    questModel.questions![tmp]=event.questionModel;
    emit(CreateQuestInitialState());
  }

  onAddLocation(AddLocationEvent event, Emitter<CreateQuestState> emit) {
    emit(AddingLocationState());
  }

  onFinishAddLocation(
      FinishAddLocationEvent event, Emitter<CreateQuestState> emit) {
    if (event.locationModels != null)
      questModel.locations != null
          ? questModel.locations?.addAll(event.locationModels!)
          : questModel.locations = event.locationModels!;
    emit(CreateQuestInitialState());
  }

  onFinishQuestCreation(
      FinishCreationQuestEvent event, Emitter<CreateQuestState> emit) async {
    emit(LoadingQuestCreationState());
    await sl<QuestRepositoryImpl>().createQuest(questModel);
    emit(FinishQuestCreationState());
  }

  onLeaveQuestCreation(LeaveQuestCreationEvent event, Emitter<CreateQuestState> emit){
    emit(DoneQuestCreationState());
  }
}
