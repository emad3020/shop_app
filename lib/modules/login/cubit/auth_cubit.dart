import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/response/login_response.dart';
import 'package:shop_app/modules/login/cubit/auth_states.dart';
import 'package:shop_app/shared/network/end_pints.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

class AuthCubit extends Cubit<AuthStates> {
  static AuthCubit? _instance;
  IconData passwordSuffix = Icons.visibility_outlined;
  bool isShowPassword = true;
  late LoginResponse loginResponse;

  AuthCubit() : super(AuthInitState());

  static AuthCubit get(context) => _instance ?? BlocProvider.of(context);

  void changePasswordVisibility() {
    isShowPassword = !isShowPassword;
    passwordSuffix = isShowPassword
        ? Icons.visibility_outlined
        : Icons.visibility_off_outlined;
    emit(ChangePasswordState());
  }

  void login({
    required String email,
    required String password,
  }) {
    emit(AuthLoadingState());
    DioHelper.postDate(url: LOGIN, data: {
      'email': email,
      'password': password,
    }).then((value) {
      print('Login response--> ${value?.data}');
      loginResponse = LoginResponse.toJson(value?.data);
      emit(AuthLoginSuccessState(loginResponse));
    }).catchError((error) {
      print('Login error response --> $error');
      emit(AuthLoginFailureState(error.toString()));
    });
  }
}
