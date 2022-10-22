import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/categories/categories_screen.dart';
import 'package:shop_app/modules/favorites/favorites_screen.dart';
import 'package:shop_app/modules/products/products_screen.dart';
import 'package:shop_app/modules/settings/settings_screen.dart';
import 'package:shop_app/shared/cubit/app_states.dart';

class AppCubit extends Cubit<AppStates> {
  static AppCubit? _instance;
  int currentIndex = 0;
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
}
