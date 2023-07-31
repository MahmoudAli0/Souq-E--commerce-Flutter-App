import 'package:social_app/social_app/model/add_fav_model.dart';
import 'package:social_app/social_app/model/shop_data_model.dart';

abstract class ShopAppStates {}

class ShopIntialStates extends ShopAppStates {}

class ShopChangeBottomNavStates extends ShopAppStates {}

class ShopLoadingHomeDataStates extends ShopAppStates {}

class ShopLoadingGetFavDataStates extends ShopAppStates {}

class ShopSucessHomeDataStates extends ShopAppStates {}

class ShopSucessFavDataStates extends ShopAppStates {}

class ShopErorrFavDataStates extends ShopAppStates {}

class ShopErorrHomeDataStates extends ShopAppStates {}

class ShopSucessCategoriesDataStates extends ShopAppStates {}

class ShopErorrCategoriesDataStates extends ShopAppStates {}

class ShopErorrChangeFavoritesDataStates extends ShopAppStates {}

class ShopSucessGetDataChangeFavoritesDataStates extends ShopAppStates {}

class ShopSucessChangeFavoritesDataStates extends ShopAppStates {
  final ChangFavMode? favMode;

  ShopSucessChangeFavoritesDataStates(this.favMode);
}

class ShopSucessUserDataStates extends ShopAppStates {
  final ShopLoginModel? userMode;

  ShopSucessUserDataStates(this.userMode);
}

class ShopErorrUserDataStates extends ShopAppStates {}

class ShopErorrUpdateProfileStates extends ShopAppStates {}

class ShopSucessUpdateProfileStates extends ShopAppStates {
  final ShopLoginModel? userUpdateMode;

  ShopSucessUpdateProfileStates(this.userUpdateMode);
}

class ShopLoadingUpdateProfileStates extends ShopAppStates {}

class ShopLoadingUserDataStates extends ShopAppStates {}

class ShopLoginImageLoadingStates extends ShopAppStates{}
class ShopLoginImageSucessStates extends ShopAppStates{}
class ShopLoginImageErorrStates extends ShopAppStates{}
