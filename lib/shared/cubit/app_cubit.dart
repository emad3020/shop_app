import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/response/home_response.dart';
import 'package:shop_app/modules/categories/categories_screen.dart';
import 'package:shop_app/modules/favorites/favorites_screen.dart';
import 'package:shop_app/modules/products/products_screen.dart';
import 'package:shop_app/modules/settings/settings_screen.dart';
import 'package:shop_app/shared/cubit/app_states.dart';
import 'package:shop_app/shared/network/end_pints.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

class AppCubit extends Cubit<AppStates> {
  static AppCubit? _instance;
  int currentIndex = 0;
  HomeResponse? homeResponse;
  List<Widget> bottomScreens = [
    ProductsScreen(),
    CategoriesScreen(),
    FavoritesScreen(),
    SettingssScreen(),
  ];

  AppCubit() : super(InitialState());

  static AppCubit get(context) => _instance ??= BlocProvider.of(context);

  void changeBottomNavIndex(int index) {
    currentIndex = index;
    emit(ChangeBottomNavIndex());
  }

  void loadHomeData() {
    emit(LoadingStates());
    DioHelper.getData(url: HOME, query: null).then((value) {
      homeResponse = HomeResponse.fromJson(value?.data);
      log('---> ${homeResponse?.data?.banners[0].image}');
      emit(HomeSuccessStates());
    }).catchError((error) {
      log(error.toString());
      emit(HomeFailureStates());
    });
  }

  void loadCategories() {
    DioHelper.getData(url: CATEGORIES, query: null).then((value) {
      log('Categories---> ${value}');
    });
  }
}
