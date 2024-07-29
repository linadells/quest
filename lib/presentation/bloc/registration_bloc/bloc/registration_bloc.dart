import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:quest/core/data_state.dart';
import 'package:quest/domain/entities/player_data_registration.dart';
import 'package:quest/domain/usecases/log_in.dart';
import 'package:quest/domain/usecases/register.dart';

part 'registration_event.dart';
part 'registration_state.dart';

class RegistrationBloc extends Bloc<RegistrationEvent, RegistrationState> {
  final RegisterUseCase _registerUseCase;
  final LogInUseCase _logInUseCase;
  RegistrationBloc(this._registerUseCase, this._logInUseCase) : super(RegistrationInitial()) {
    on<Register>(onRegister);
    on<LogIn>(onLogIn);
  }

  Future<void> onRegister(
      Register event, Emitter<RegistrationState> emit) async {
    emit(RegistrationLoading());
    DataState<UserCredential> data;
    try {
      data = await _registerUseCase(
          params: PlayerDataRegistrationEntity(email: event.email, password: event.password, nickname: event.nickname));
      emit(RegistrationDone());
    } on FirebaseAuthException catch (e) {
      data=DataFailed(e);
      emit(RegistrationError(error: data.error!));
    }
  }

  Future<void> onLogIn(
      LogIn event, Emitter<RegistrationState> emit) async {
    emit(RegistrationLoading());
    DataState<UserCredential> data;
    try {
      data = await _logInUseCase(
          params: PlayerDataRegistrationEntity(email: event.email, password: event.password));
      emit(RegistrationDone());
    } on FirebaseAuthException catch (e) {
      data=DataFailed(e);
      if(data.error!.toString()=='[firebase_auth/unknown-error] An internal error has occurred.'){
        data=DataFailed(Exception('Incorrect email or password'));
      }
      print(e);
      emit(RegistrationError(error: data.error!));
    }
  }
}
