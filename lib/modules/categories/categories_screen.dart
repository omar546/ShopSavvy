import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_savvy/models/categories_model.dart';
import 'package:shop_savvy/shared/cubit/cubit.dart';
import 'package:shop_savvy/shared/cubit/states.dart';
import 'package:shop_savvy/shared/styles/colors.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition: ShopCubit.get(context).homeModel != null &&
              ShopCubit.get(context).categoriesModel != null,
          builder:(context) => ListView.separated(
              itemBuilder: (context, index) => buildCatItem(ShopCubit.get(context).categoriesModel.data?.data[index]as DataModel,context),
              separatorBuilder: (context, index) => Container(
                    height: MediaQuery.of(context).size.height * 0.001,
                    color: MyColors.greyColor,
                  ),
              itemCount: ShopCubit.get(context).categoriesModel.data?.data.length ?? 0),
          fallback: (context) => const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  Widget buildCatItem(DataModel model, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          Image(
            image: NetworkImage(model.image ?? ''),
            width: MediaQuery.of(context).size.width * 0.3,
            height: MediaQuery.of(context).size.height * 0.15,
            fit: BoxFit.cover,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.04,
          ),
          Text(
            model.name?.toUpperCase()??'',
            style: TextStyle(fontSize: 15.0,fontFamily: 'bitter-bold',overflow: TextOverflow.ellipsis),
          ),
          Spacer(),
          Icon(Icons.arrow_forward_ios,color: MyColors.fire,)
        ],
      ),
    );
  }
}
