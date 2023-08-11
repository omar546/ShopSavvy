import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_savvy/models/home_model.dart';
import 'package:shop_savvy/modules/login/cubit/login_states.dart';
import 'package:shop_savvy/shared/cubit/cubit.dart';
import 'package:shop_savvy/shared/cubit/states.dart';

import '../../shared/styles/colors.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return ConditionalBuilder(
            condition: ShopCubit.get(context).homeModel != null,
            builder: (context) =>
                productsBuilder(ShopCubit.get(context).homeModel!, context),
            fallback: (context) =>
                const Center(child: CircularProgressIndicator()),
          );
        });
  }

  Widget productsBuilder(HomeModel model, BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        children: [
          CarouselSlider(
            items: model.data?.banners
                .map((b) => Image(
                      image: NetworkImage('${b.image}'),
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ))
                .toList(),
            options: CarouselOptions(
                initialPage: 0,
                viewportFraction: 1.0,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 3),
                autoPlayAnimationDuration: const Duration(seconds: 1),
                autoPlayCurve: Curves.fastOutSlowIn,
                scrollDirection: Axis.horizontal,
                height: MediaQuery.of(context).size.height * 0.3),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.01,
          ),
          GridView.count(
            childAspectRatio: 1 / 1.53,
            mainAxisSpacing: 1,
            crossAxisSpacing: 1,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            children: List.generate(
                model.data?.products.length ?? 0,
                (index) => buildGridProduct(
                    model.data?.products[index] as ProductModel, context)),
          )
        ],
      ),
    );
  }

  Widget buildGridProduct(ProductModel model, BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: Alignment.bottomLeft,
            children: [
              Image(
                image: NetworkImage(model.image ?? ''),
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.24,
              ),
              if (model.discount != 0)
                Container(
                  color: MyColors.fire,
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  child: Text(
                    'OFFER',
                    style: TextStyle(
                      fontSize: 9,
                      color: MyColors.whiteColor,
                    ),
                  ),
                ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  model.name!,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 13, height: 1.2),
                ),
                Row(
                  children: [
                    Text(
                      '${model.price!.round()}',
                      style: TextStyle(
                          fontSize: 12, height: 1.2, color: MyColors.fire),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    if (model.discount != 0)
                      Text(
                        '${model.oldPrice!.round()}',
                        style: TextStyle(
                            fontSize: 10,
                            height: 1.2,
                            color: MyColors.greyColor,
                            decoration: TextDecoration.lineThrough,
                            decorationColor: MyColors.fire),
                      ),
                    Spacer(),
                    IconButton(
                      padding: EdgeInsets.zero,
                        onPressed: () {}, icon: Icon(Icons.favorite_rounded,color: MyColors.greyColor,),)
                  ],
                ),
              ],
            ),
          ),
        ],
      );
}
