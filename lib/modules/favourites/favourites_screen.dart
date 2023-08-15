import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/components/components.dart';
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
                itemBuilder: (context, index) => buildListProducts(
                    ShopCubit.get(context).favouritesModel.data?.data![index].product
                    ,
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

}
