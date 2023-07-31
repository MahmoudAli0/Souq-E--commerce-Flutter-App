import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/social_app/Dio/dio_helper.dart';
import 'package:social_app/social_app/model/shop_data_model.dart';
import 'package:social_app/social_app/register/cubit/states.dart';

class ShopRegisteCubit extends Cubit<ShopRegisterStates>{
  ShopRegisteCubit() : super(ShopRegisterInitialStates());
  static ShopRegisteCubit get(context) =>BlocProvider.of(context);
  ShopLoginModel? loginModel;

  void userRegister({
    required String email,
    required String password,
    required String name,
    required String phone,
  }){
    emit(ShopRegisterLoadingStates());
    DioHelper.postData(
        url: 'https://student.valuxapps.com/api/register',
        data: {
          'name':name,
          'phone':phone,
          'email':email,
          'password':password,
        }
    ).then((value) {
      print(value);
      loginModel=ShopLoginModel.fromJson(value.data);
      //print(loginModel!.message);
      //print(loginModel!.status);
      emit(ShopRegisterSucessStates(loginModel));
    }).catchError((error){
      print(error.toString());
      emit(ShopRegisterErorrStates(error.toString()));
    });
  }
  IconData sufix= Icons.visibility;
  bool passwordHidden=true;
  void changePasswordVis(){
    passwordHidden=!passwordHidden;
    sufix= passwordHidden? Icons.visibility:Icons.visibility_off_rounded ;

    emit(ShopRegisterChangePasswordStates());
  }
}