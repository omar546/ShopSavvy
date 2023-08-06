import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_savvy/layout/cubit/states.dart';
import 'package:shop_savvy/modules/favourites/favourites_screen.dart';
import 'package:shop_savvy/modules/products/products_screen.dart';
import 'package:shop_savvy/modules/settings/settings_screen.dart';

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
}
