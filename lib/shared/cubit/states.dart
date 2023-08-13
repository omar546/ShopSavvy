import '../../models/change_favourites_model.dart';

abstract class ShopStates{}

class ShopInitialState extends ShopStates{}

class ShopChangeBottomNavState extends ShopStates{}

class ShopLoadingHomeDataState extends ShopStates{}

class ShopSuccessHomeDataState extends ShopStates{}

class ShopErrorHomeDataState extends ShopStates{}

class ShopSuccessCategoriesDataState extends ShopStates{}

class ShopErrorCategoriesDataState extends ShopStates{}

class ShopChangeFavouritesDataState extends ShopStates{}

class ShopSuccessChangeFavouritesDataState extends ShopStates{
  final ChangeFavouritesModel model;

  ShopSuccessChangeFavouritesDataState(this.model);
}

class ShopErrorChangeFavouritesDataState extends ShopStates{}

class ShopLoadingFavDataState extends ShopStates{}

class ShopSuccessGetFavDataState extends ShopStates{}

class ShopErrorGetFavDataState extends ShopStates{}
