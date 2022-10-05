import 'package:shop_app/models/response/login_response.dart';

abstract class AuthStates {}

class AuthInitState extends AuthStates {}

class AuthLoadingState extends AuthStates {}

class AuthLoginSuccessState extends AuthStates {
  final LoginResponse loginResponse;

  AuthLoginSuccessState(this.loginResponse);
}

class ChangePasswordState extends AuthStates {}

class AuthLoginFailureState extends AuthStates {
  final String error;
  AuthLoginFailureState(this.error);
}
