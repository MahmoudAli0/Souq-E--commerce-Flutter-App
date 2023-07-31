
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/social_app/Dio/dio_helper.dart';
import 'package:social_app/social_app/login/states.dart';
import 'package:social_app/social_app/model/shop_data_model.dart';

class ShopLoginCubit extends Cubit<ShopLoginStates>{
  ShopLoginCubit() : super(ShopLoginInitialStates());
  static ShopLoginCubit get(context) =>BlocProvider.of(context);
  ShopLoginModel? loginModel;

  void userLogin({
  required String email,
  required String password,
}){
    emit(ShopLoginLoadingStates());
    DioHelper.postData(
        url: 'https://student.valuxapps.com/api/login',
        data: {
          'email':email,
          'password':password,
        }
    ).then((value) {
      print(value);
      loginModel=ShopLoginModel.fromJson(value.data);
      print(loginModel!.message);
      print(loginModel!.status);
      emit(ShopLoginSucessStates(loginModel));
    }).catchError((error){
      print(error.toString());
      emit(ShopLoginErorrStates(error.toString()));
    });
  }
  IconData sufix= Icons.visibility;
  bool passwordHidden=true;
  void changePasswordVis(){
    passwordHidden=!passwordHidden;
    sufix= passwordHidden? Icons.visibility:Icons.visibility_off_rounded ;

    emit(ShopLoginChangePasswordStates());
  }

}