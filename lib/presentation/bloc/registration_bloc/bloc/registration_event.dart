part of 'registration_bloc.dart';

sealed class RegistrationEvent extends Equatable {
  const RegistrationEvent();

  @override
  List<Object> get props => [];
}

class Register extends RegistrationEvent {
  final String email, password, nickname;
  const Register({required this.email, required this.password, required this.nickname});
}

class LogIn extends RegistrationEvent {
  final String email, password;
  const LogIn({required this.email, required this.password});
}
