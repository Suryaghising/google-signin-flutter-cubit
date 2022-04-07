part of 'login_cubit.dart';

@immutable
abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginCancelled extends LoginState {}

class LoginSuccess extends LoginState {
  final GoogleSignInAccount googleSignInAccount;

  LoginSuccess({required this.googleSignInAccount});
}
