import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/favourites_model.dart';
import '../../shared/cubit/cubit.dart';
import '../../shared/cubit/states.dart';
import '../../shared/styles/colors.dart';

class FavouritesScreen extends StatelessWidget {
  const FavouritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return ConditionalBuilder(
            condition: state is! ShopLoadingFavDataState,
            builder: (context) => ListView.separated(
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) => buildFavItem(
                    ShopCubit.get(context).favouritesModel.data?.data![index]
                        as FavouritesData,
                    context),
                separatorBuilder: (context, index) => Container(
                      height: MediaQuery.of(context).size.height * 0.001,
                      color: MyColors.greyColor,
                    ),
                itemCount:
                    ShopCubit.get(context).favouritesModel.data?.data?.length ??
                        0),
            fallback: (context) =>
                const Center(child: CircularProgressIndicator()),
          );
        });
  }

  Widget buildFavItem(FavouritesData model, BuildContext context) => Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          height: MediaQuery.of(context).size.height * 0.15,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                alignment: Alignment.bottomLeft,
                children: [
                  Image(
                    image: NetworkImage(model.product?.image ?? ''),
                    width: MediaQuery.of(context).size.width * 0.35,
                    height: MediaQuery.of(context).size.height * 0.24,
                  ),
                  if (model.product?.discount != 0)
                    Container(
                      color: MyColors.fire,
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: const Text(
                        'OFFER',
                        style: TextStyle(
                          fontSize: 9,
                          color: MyColors.whiteColor,
                        ),
                      ),
                    ),
                ],
              ),
              SizedBox(width: MediaQuery.of(context).size.width * 0.02),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      model.product?.name?.toUpperCase() ?? '',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 13, height: 1.2),
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        Text(
                          '${model.product?.price!.round()}',
                          style: const TextStyle(
                              fontSize: 12, height: 1.2, color: MyColors.fire),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        if (model.product?.discount != 0)
                          Text(
                            '${model.product?.oldPrice!.round()}',
                            style: const TextStyle(
                                fontSize: 10,
                                height: 1.2,
                                color: MyColors.greyColor,
                                decoration: TextDecoration.lineThrough,
                                decorationColor: MyColors.fire),
                          ),
                        const Spacer(),
                        IconButton(
                          onPressed: () {
                            ShopCubit.get(context)
                                .changeFavourites(model.product!.id!);
                            if (kDebugMode) {}
                          },
                          tooltip: 'favourite',
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          icon: Icon(
                            Icons.favorite_rounded,
                            color: ShopCubit.get(context)
                                        .favourites[model.product?.id] ??
                                    false
                                ? MyColors.fire
                                : MyColors.greyColor,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
}
