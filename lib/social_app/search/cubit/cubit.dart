import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:social_app/constants/signOu.dart';
import 'package:social_app/social_app/Dio/dio_helper.dart';
import 'package:social_app/social_app/model/search_model.dart';
import 'package:social_app/social_app/search/cubit/states.dart';

class ShopSearchCubit extends Cubit<ShopSearchStates> {
  ShopSearchCubit() : super(ShopSearchIntialState());

  static ShopSearchCubit get(context) => BlocProvider.of(context);

  SearchModel? searchModel;
  void search(String text) {
    emit(ShopSearchLoadingState());
    DioHelper.postData(
            url: 'https://student.valuxapps.com/api/products/search',
            data: {'text': text},
            token: token)
        .then((value) {
      emit(ShopSearchSucessgState(searchModel!));
      searchModel = SearchModel.fromJson(value.data);
    }).catchError((onError) {
      emit(ShopSearchErorrState());
      print(onError.toString());
    });
  }
}
