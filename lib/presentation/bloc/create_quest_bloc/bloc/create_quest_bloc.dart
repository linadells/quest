import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'create_quest_event.dart';
part 'create_quest_state.dart';

class CreateQuestBloc extends Bloc<CreateQuestEvent, CreateQuestState> {
  CreateQuestBloc() : super(CreateQuestInitial()) {
    on<CreateQuestEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
