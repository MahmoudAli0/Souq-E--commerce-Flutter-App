import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/constants/signOu.dart';
import 'package:social_app/social_app/model/get_fav_model.dart';
import 'package:social_app/social_app/shop_cubit/cubit.dart';
import 'package:social_app/social_app/shop_cubit/states.dart';

class FavScreen extends StatelessWidget {
  const FavScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopAppStates>(
      listener: (context,state){},
      builder: (context,state){
        return ConditionalBuilder(
          condition: state is! ShopLoadingGetFavDataStates,
          builder: (context) => ListView.separated(
              itemBuilder: (context, index) => buildItem(ShopCubit.get(context).favorietsModel!.data!.data![index].product,context),
              separatorBuilder: (context, index) => Divider(),
              itemCount: ShopCubit.get(context).favorietsModel!.data!.data!.length),
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

}
