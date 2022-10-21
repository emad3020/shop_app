import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/shared/cubit/app_states.dart';

class AppCubit extends Cubit<AppStates> {
  static AppCubit? _instance;

  AppCubit() : super(InitialState());

  static AppCubit get(context) => _instance ??= BlocProvider.of(context);
}
