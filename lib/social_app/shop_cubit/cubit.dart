
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:social_app/constants/signOu.dart';
import 'package:social_app/social_app/Dio/dio_helper.dart';
import 'package:social_app/social_app/categaroies/cat_screen.dart';
import 'package:social_app/social_app/favourate/fav_screen.dart';
import 'package:social_app/social_app/model/add_fav_model.dart';
import 'package:social_app/social_app/model/categories_model.dart';
import 'package:social_app/social_app/model/get_fav_model.dart';
import 'package:social_app/social_app/model/home_model.dart';
import 'package:social_app/social_app/model/shop_data_model.dart';
import 'package:social_app/social_app/product/products_screen.dart';
import 'package:social_app/social_app/settings/setting_screen.dart';
import 'package:social_app/social_app/shop_cubit/states.dart';

class ShopCubit extends Cubit<ShopAppStates> {
  ShopCubit() : super(ShopIntialStates());
  static ShopCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<Widget> bottomNavScreens = [
    ProductScreen(),
    CategoriesScreen(),
    FavScreen(),
    SettingScreen()
  ];

  void changeBottomScreen(int index) {
    currentIndex = index;
    emit(ShopChangeBottomNavStates());
  }

  HomeModel? homeModel;
  Map<int, bool> favourites = {};

  void getHomeData() {
    emit(ShopLoadingHomeDataStates());

    DioHelper.getData(
            url: 'https://student.valuxapps.com/api/home', token: token??null)
        .then((value) {
      // print(value);
      print('hello');
      homeModel = HomeModel.fromJson(value.data);
      // print(homeModel!.status);
      //  print(homeModel!.data!.banners![0].image);

      //  print(homeModel!.data!.banners![0].id);
      //printFullText(homeModel.toString());
      homeModel!.data?.products!.forEach((element) {
        favourites.addAll({
          element.id: element.in_favorites,
        });
      });
      print(favourites.toString());
      emit(ShopSucessHomeDataStates());
    }).catchError((error) {
      emit(ShopErorrHomeDataStates());
      Fluttertoast.showToast(
          msg: error.toString(),
          backgroundColor: Colors.red,
          textColor: Colors.white,
          toastLength: Toast.LENGTH_LONG);
      print(error.toString());
    });
  }

  CategoriesModel? CatModel;

  void getCategoriesData() {
    DioHelper.getData(
      url: 'https://student.valuxapps.com/api/categories',
    ).then((value) {
      //print(value);
      print('hello');

      CatModel = CategoriesModel.fromJson(value.data);
      //print(CatModel!.status);

      emit(ShopSucessCategoriesDataStates());
    }).catchError((error) {
      emit(ShopErorrCategoriesDataStates());
      print(error.toString());
      Fluttertoast.showToast(
          msg: error.toString(),
          backgroundColor: Colors.red,
          textColor: Colors.white,
          toastLength: Toast.LENGTH_LONG);
    });
  }

  FavorietsModel? favorietsModel;

  void geFavData() {
    emit(ShopLoadingGetFavDataStates());
    DioHelper.getData(
      url: 'https://student.valuxapps.com/api/favorites',
      token: token??null,
    ).then((value) {
      print('hello');

      favorietsModel = FavorietsModel.fromJson(value.data);
      //print(CatModel!.status);

      emit(ShopSucessFavDataStates());
    }).catchError((error) {
      emit(ShopErorrFavDataStates());
      print(error.toString());
    });
  }

  ChangFavMode? favModel;
  void changFavorites(int productId) {
    favourites[productId] = !favourites[productId]!;
    emit(ShopSucessGetDataChangeFavoritesDataStates());
    DioHelper.postData(
            url: 'https://student.valuxapps.com/api/favorites',
            data: {'product_id': productId},
        token: token??null)
        .then((value) {
      favModel = ChangFavMode.fromJson(value.data);
      print(favModel!.status);
      print(favModel!.message);
      if (favModel?.status == false) {
        favourites[productId] = !favourites[productId]!;
      } else {
        geFavData();
      }
      emit(ShopSucessChangeFavoritesDataStates(favModel));
    }).catchError((onError) {
      favourites[productId] = !favourites[productId]!;
      emit(ShopErorrChangeFavoritesDataStates());
    });
  }

  ShopLoginModel? userData;

  void getUserData() {
    emit(ShopLoadingUserDataStates());
    DioHelper.getData(
            url: 'https://student.valuxapps.com/api/profile', token: token??null)
        .then((value) {
      //print(value);

      userData = ShopLoginModel.fromJson(value.data);
      print(userData!.data!.name);

      emit(ShopSucessUserDataStates(userData));
    }).catchError((error) {
      emit(ShopErorrUserDataStates());
      print(error.toString());
      Fluttertoast.showToast(
          msg: error.toString(),
          backgroundColor: Colors.red,
          textColor: Colors.white,
          toastLength: Toast.LENGTH_LONG);
    });
  }

  void UpdateUserData({
    required String name,
    required String email,
    required String phone,
  }) {
    emit(ShopLoadingUpdateProfileStates());
    DioHelper.putData(
        url: 'https://student.valuxapps.com/api/update-profile',
        token: token??null,
        data: {'name': name, 'phone': phone, 'email': email,}).then((value) {
      //print(value);

      userData = ShopLoginModel.fromJson(value.data);
      print(userData!.data!.name);
      print(userData!.data!.phone);
      print(userData!.data!.email);

      emit(ShopSucessUpdateProfileStates(userData));
    }).catchError((error) {
      emit(ShopErorrUpdateProfileStates());
      print(error.toString());
    });
  }


}

void printFullText(String text) {
  final pattern = RegExp('.{1,800}');
  pattern.allMatches(text).forEach((element) => print(element.group(0)));
}
