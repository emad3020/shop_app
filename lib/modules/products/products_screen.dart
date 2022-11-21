import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/response/categories_response.dart';
import 'package:shop_app/models/response/home_response.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/cubit/app_cubit.dart';
import 'package:shop_app/shared/cubit/app_states.dart';
import 'package:shop_app/shared/styles/colors.dart';

class ProductsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, states) {},
      builder: (context, states) {
        var cubit = AppCubit.get(context);
        return ConditionalBuilder(
            condition:
                cubit.homeResponse != null && cubit.categoriesResponse != null,
            builder: (context) =>
                _productsBuilder(cubit.homeResponse, cubit.categoriesResponse),
            fallback: (context) => loadingBuilder());
      },
    );
  }

  Widget _productsBuilder(
          HomeResponse? products, CategoriesResponse? categories) =>
      SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CarouselSlider(
              items: products?.data?.banners
                  .map((e) => Image(
                        image: NetworkImage(e.image ?? ""),
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ))
                  .toList(),
              options: CarouselOptions(
                height: 250.0,
                initialPage: 0,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlay: true,
                viewportFraction: 1.0,
                autoPlayInterval: Duration(seconds: 3),
                autoPlayAnimationDuration: Duration(seconds: 1),
                autoPlayCurve: Curves.fastOutSlowIn,
                scrollDirection: Axis.horizontal,
              ),
            ),
            SizedBox(height: 10.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Categories',
                    style:
                        TextStyle(fontSize: 24.0, fontWeight: FontWeight.w800),
                  ),
                  SizedBox(height: 10.0),
                  Container(
                    height: 100.0,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (context, index) => _buildCategoryItem(
                          categories?.data?.categoriesList[index]),
                      separatorBuilder: (context, index) => SizedBox(
                        width: 10.0,
                      ),
                      itemCount: categories?.data?.categoriesList.length ?? 0,
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Text(
                    'New Products ',
                    style:
                        TextStyle(fontSize: 24.0, fontWeight: FontWeight.w800),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10.0),
            Container(
              color: Colors.grey[300],
              child: GridView.count(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                mainAxisSpacing: 1.0,
                crossAxisSpacing: 1.0,
                childAspectRatio: 1 / 1.6,
                children: List.generate(
                  products?.data?.products.length ?? 0,
                  (index) => _buildGridProduct(products?.data?.products[index]),
                ),
              ),
            )
          ],
        ),
      );

  Widget _buildCategoryItem(CategoryModel? category) => Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          Image(
            fit: BoxFit.cover,
            image: NetworkImage(category?.categoryImage ?? ""),
            width: 100,
            height: 100,
          ),
          Container(
            width: 100.0,
            color: Colors.black.withOpacity(0.8),
            child: Text(
              category?.name ?? "",
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          )
        ],
      );

  Widget _buildGridProduct(ProductModel? productModel) => Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Image(
                  image: NetworkImage(productModel?.image ?? ""),
                  width: double.infinity,
                  height: 200.0,
                ),
                if (productModel?.oldPrice != null)
                  Container(
                    color: Colors.red,
                    padding: EdgeInsets.symmetric(horizontal: 5.0),
                    child: Text(
                      'DISCOUNT',
                      style: TextStyle(fontSize: 12.0, color: Colors.white),
                    ),
                  ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(productModel?.name ?? "",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 14.0,
                        height: 1.3,
                      )),
                  Row(
                    children: [
                      Text('${productModel?.price.round()} EGP',
                          style: TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold,
                              color: defaultColor)),
                      SizedBox(
                        width: 5.0,
                      ),
                      if (productModel?.oldPrice != null)
                        Text('${productModel?.oldPrice.round()} EGP',
                            style: TextStyle(
                                fontSize: 10.0,
                                color: Colors.grey,
                                decoration: TextDecoration.lineThrough)),
                      Spacer(),
                      IconButton(
                          padding: EdgeInsets.zero,
                          onPressed: () {},
                          icon: Icon(Icons.favorite_border_outlined))
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      );
}
