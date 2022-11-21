import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
            condition: cubit.homeResponse != null,
            builder: (context) => _productsBuilder(cubit.homeResponse),
            fallback: (context) => loadingBuilder());
      },
    );
  }

  Widget _productsBuilder(HomeResponse? products) => SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
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
                      Text('${productModel?.price.round()}',
                          style:
                              TextStyle(fontSize: 12.0, color: defaultColor)),
                      SizedBox(
                        width: 5.0,
                      ),
                      if (productModel?.oldPrice != null)
                        Text('${productModel?.oldPrice.round()}',
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
