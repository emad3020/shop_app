import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/layout/shop_layout.dart';
import 'package:shop_app/models/response/login_response.dart';
import 'package:shop_app/models/toast_type.dart';
import 'package:shop_app/modules/login/cubit/auth_cubit.dart';
import 'package:shop_app/modules/login/cubit/auth_states.dart';
import 'package:shop_app/modules/register/register_screen.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import 'package:shop_app/shared/styles/colors.dart';

class LoginScreen extends StatelessWidget {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthStates>(
      listener: (context, state) {
        if (state is AuthLoginSuccessState) {
          if (state.loginResponse.status == true) {
            CacheHelper.setData(
                    key: USER_TOKEN,
                    value: state.loginResponse.data?.token ?? "")
                .then((value) {
              navigateAndFinish(
                context,
                ShopLayout(),
              );
            });
          } else {
            showToast(
              message: state.loginResponse.message ?? "",
              type: ToastType.ERROR,
            );
          }
        }
      },
      builder: (context, state) {
        var cubit = AuthCubit.get(context);
        return Scaffold(
          appBar: AppBar(),
          body: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'LOGIN',
                        style: Theme.of(context)
                            .textTheme
                            .headline4
                            ?.copyWith(color: Colors.black),
                      ),
                      Text(
                        'login now to browse our hot offers',
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1
                            ?.copyWith(color: Colors.grey),
                      ),
                      SizedBox(height: 30.0),
                      defaultTextFormField(
                        controller: emailController,
                        inputType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value?.isEmpty == true) {
                            return 'Enter valid Email';
                          }
                          return null;
                        },
                        hintText: 'Email Address',
                        prefixIcon: Icon(Icons.email_outlined),
                      ),
                      SizedBox(height: 15.0),
                      defaultTextFormField(
                        controller: passwordController,
                        inputType: TextInputType.visiblePassword,
                        validator: (value) {
                          if (value?.isEmpty == true) {
                            return 'Password is too short';
                          }
                          return null;
                        },
                        hintText: 'Password',
                        prefixIcon: Icon(Icons.lock_outline),
                        suffixIcon: cubit.passwordSuffix,
                        isPassword: cubit.isShowPassword,
                        onSuffixPressed: () {
                          cubit.changePasswordVisibility();
                        },
                        onSubmit: (value) {
                          if (formKey.currentState?.validate() == true) {
                            cubit.login(
                              email: emailController.text,
                              password: passwordController.text,
                            );
                          }
                        },
                      ),
                      SizedBox(height: 15.0),
                      ConditionalBuilder(
                        condition: state is! AuthLoadingState,
                        builder: (context) => defaultButton(
                          onPressed: () {
                            if (formKey.currentState?.validate() == true) {
                              cubit.login(
                                email: emailController.text,
                                password: passwordController.text,
                              );
                            }
                          },
                          title: 'login',
                          textAllCaps: true,
                        ),
                        fallback: (context) => Center(
                          child: CircularProgressIndicator(
                            color: defaultColor,
                          ),
                        ),
                      ),
                      SizedBox(height: 15.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Don\'t have an account?'),
                          defaultTextButton(
                            onPressed: () {
                              navigateTo(context, RegisterScreen());
                            },
                            title: 'Register Now',
                            textColor: defaultColor,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
