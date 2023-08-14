import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_savvy/models/categories_model.dart';
import 'package:shop_savvy/models/change_favourites_model.dart';
import 'package:shop_savvy/models/favourites_model.dart';
import 'package:shop_savvy/models/home_model.dart';
import 'package:shop_savvy/shared/components/constants.dart';
import 'package:shop_savvy/shared/cubit/states.dart';
import 'package:shop_savvy/modules/favourites/favourites_screen.dart';
import 'package:shop_savvy/modules/products/products_screen.dart';
import 'package:shop_savvy/modules/settings/settings_screen.dart';
import 'package:shop_savvy/shared/network/end_points.dart';
import 'package:shop_savvy/shared/network/remote/dio_helper.dart';

import '../../models/login_model.dart';
import '../../modules/categories/categories_screen.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitialState());
  static ShopCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<Widget> Screens = [
    const ProductsScreen(),
    const CategoriesScreen(),
    const FavouritesScreen(),
    SettingsScreen(),
  ];

  void changeBottom(int index) {
    currentIndex = index;
    emit(ShopChangeBottomNavState());
  }

  HomeModel? homeModel;

  Map<int?, bool?> favourites = {};

  void getHomeData() {
    emit(ShopLoadingHomeDataState());
    DioHelper.getData(url: Home, token: token).then((value) {
      homeModel = HomeModel.fromJson(value.data);

      homeModel?.data?.products.forEach((element) {
        favourites.addAll({
          element.id: element.inFavourites,
        });
      });
      if (kDebugMode) {
        print(favourites);
      }
      emit(ShopSuccessHomeDataState());
    }).catchError((error) {
      if (kDebugMode) {
        print(error.toString());
      }
      emit(ShopErrorHomeDataState());
    });
  }

  late CategoriesModel categoriesModel;

  void getCategoriesData() {
    DioHelper.getData(url: GET_CATEGORIES, token: token).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);
      if (kDebugMode) {
        print(categoriesModel.status);
      }
      emit(ShopSuccessCategoriesDataState());
    }).catchError((error) {
      if (kDebugMode) {
        print(error.toString());
      }
      emit(ShopErrorCategoriesDataState());
    });
  }

  late ChangeFavouritesModel changeFavouritesModel;

  void changeFavourites(int productId) {
    favourites[productId] = !favourites[productId]!;
    emit(ShopChangeFavouritesDataState());
    DioHelper.postData(
            url: FAVOURITES, data: {'product_id': productId}, token: token)
        .then((value) {
      changeFavouritesModel = ChangeFavouritesModel.fromJson(value.data);
      if (kDebugMode) {
        printFullText(value.data.toString());
      }

      if(!changeFavouritesModel.status!)
      {
        favourites[productId] = !favourites[productId]!;
      }else{
        getFavData();
      }
      emit(ShopSuccessChangeFavouritesDataState(changeFavouritesModel));
    }).catchError((onError) {
      if (kDebugMode) {
        print(onError);
      }
      favourites[productId] = !favourites[productId]!;

      emit(ShopErrorChangeFavouritesDataState());
    });
  }

  late FavouritesModel favouritesModel;

  void getFavData() {
    emit(ShopLoadingFavDataState());

    DioHelper.getData(url: FAVOURITES, token: token).then((value) {
      favouritesModel = FavouritesModel.fromJson(value.data);
      if (kDebugMode) {
        print(favouritesModel.status);
      }
      emit(ShopSuccessGetFavDataState());
    }).catchError((error) {
      if (kDebugMode) {
        print(error.toString());
      }
      emit(ShopErrorGetFavDataState());
    });
  }

  LoginModel? profModel;

  void getProfData() {
    emit(ShopLoadingProfDataState());

    DioHelper.getData(url: PROFILE, token: token).then((value) {
      profModel = LoginModel.formJson(value.data);
      if (kDebugMode) {
        print(profModel?.data?.name);
      }
      emit(ShopSuccessProfDataState(profModel!));
    }).catchError((error) {
      if (kDebugMode) {
        print(error.toString());
      }
      emit(ShopErrorProfDataState());
    });
  }
}
