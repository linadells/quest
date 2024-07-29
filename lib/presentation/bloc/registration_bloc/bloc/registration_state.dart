part of 'registration_bloc.dart';

sealed class RegistrationState extends Equatable {
  const RegistrationState();
  
  @override
  List<Object> get props => [];
}

final class RegistrationInitial extends RegistrationState {}

final class RegistrationLoading extends RegistrationState {}

final class RegistrationDone extends RegistrationState {
  const RegistrationDone();
}

final class RegistrationError extends RegistrationState {
  final Exception error;
  const RegistrationError({required this.error});
}
