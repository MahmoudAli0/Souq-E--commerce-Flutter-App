import 'package:social_app/social_app/model/search_model.dart';

abstract class ShopSearchStates{}
class ShopSearchLoadingState extends ShopSearchStates{

}
class ShopSearchIntialState extends ShopSearchStates{}
class ShopSearchSucessgState extends ShopSearchStates{
  final SearchModel searchModel;

  ShopSearchSucessgState(this.searchModel);
}
class ShopSearchErorrState extends ShopSearchStates{}