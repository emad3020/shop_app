import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/response/categories_response.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/cubit/app_cubit.dart';
import 'package:shop_app/shared/cubit/app_states.dart';

class CategoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        cubit.loadCategories();
        return ListView.separated(
          physics: BouncingScrollPhysics(),
          scrollDirection: Axis.vertical,
          itemBuilder: (context, index) => _buildCategoryItem(
              cubit.categoriesResponse?.data?.categoriesList[index]),
          separatorBuilder: (context, index) => listDivider(),
          itemCount: cubit.categoriesResponse?.data?.categoriesList.length ?? 0,
        );
      },
    );
  }

  Widget _buildCategoryItem(CategoryModel? category) => Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Image(
              image: NetworkImage(category?.categoryImage ?? ""),
              width: 80.0,
              height: 80.0,
              fit: BoxFit.cover,
            ),
            SizedBox(
              width: 20.0,
            ),
            Text(
              category?.name ?? "",
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            Spacer(),
            Icon(Icons.arrow_forward_ios)
          ],
        ),
      );
}
