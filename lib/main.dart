import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_layout.dart';
import 'package:shop_app/modules/boarding/on_boarding_screen.dart';
import 'package:shop_app/modules/login/cubit/auth_cubit.dart';
import 'package:shop_app/modules/login/login_screen.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/cubit/app_cubit.dart';
import 'package:shop_app/shared/cubit/app_states.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import 'package:shop_app/shared/styles/themes.dart';

import 'shared/bloc_observer.dart';
import 'shared/network/remote/dio_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();
  bool isFirstTime = CacheHelper.getData(key: IS_FIRST_TIME);
  Widget? startWidget;
  String userToken = CacheHelper.getData(key: USER_TOKEN);

  if (!isFirstTime) {
    if (userToken.isNotEmpty)
      startWidget = ShopLayout();
    else {
      startWidget = LoginScreen();
    }
  } else {
    BoardingScreen();
  }
  runApp(MyApp(
    startWidget: startWidget,
  ));
}

class MyApp extends StatelessWidget {
  final bool _isDark = CacheHelper.getData(key: IS_DARK);

  final Widget? startWidget;

  MyApp({this.startWidget});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AppCubit()),
        BlocProvider(create: (context) => AuthCubit()),
      ],
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) => MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          darkTheme: darkTheme,
          theme: lightTheme,
          themeMode: _isDark ? ThemeMode.dark : ThemeMode.light,
          home: startWidget,
        ),
      ),
    );
  }
}
