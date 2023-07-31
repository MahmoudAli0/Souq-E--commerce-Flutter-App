import 'package:social_app/social_app/model/shop_data_model.dart';

abstract class ShopLoginStates{}
 class ShopLoginInitialStates extends ShopLoginStates{}
 class ShopLoginLoadingStates extends ShopLoginStates{}

 class ShopLoginSucessStates extends ShopLoginStates{
 final ShopLoginModel;

  ShopLoginSucessStates(this.ShopLoginModel);
 }
 class ShopLoginChangePasswordStates extends ShopLoginStates{}
 class ShopLoginErorrStates extends ShopLoginStates{
  final String error;

  ShopLoginErorrStates(this.error);


}
