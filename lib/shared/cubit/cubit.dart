import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_savvy/models/home_model.dart';
import 'package:shop_savvy/shared/components/constants.dart';
import 'package:shop_savvy/shared/cubit/states.dart';
import 'package:shop_savvy/modules/favourites/favourites_screen.dart';
import 'package:shop_savvy/modules/products/products_screen.dart';
import 'package:shop_savvy/modules/settings/settings_screen.dart';
import 'package:shop_savvy/shared/network/end_points.dart';
import 'package:shop_savvy/shared/network/remote/dio_helper.dart';

import '../../modules/categories/categories_screen.dart';

class ShopCubit extends Cubit<ShopStates>
{
  ShopCubit() : super(ShopInitialState());
  static ShopCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<Widget> Screens =[
    ProductsScreen(),
    CategoriesScreen(),
    FavouritesScreen(),
    SettingsScreen(),
  ];

  void changeBottom(int index)
  {
    currentIndex = index;
    emit(ShopChangeBottomNavState());
  }

  HomeModel? homeModel;

  void getHomeData()
  {

    emit(ShopLoadingHomeDataState());
    DioHelper.getData(url: Home,token: token).then((value){
      homeModel = HomeModel.fromJson(value.data);
      printFullText(homeModel?.data?.banners[0].image);
      print(homeModel?.status);
      emit(ShopSuccessHomeDataState());
    }).catchError((error){
      print(error.toString());
      emit(ShopErrorHomeDataState());
    });

  }
}
