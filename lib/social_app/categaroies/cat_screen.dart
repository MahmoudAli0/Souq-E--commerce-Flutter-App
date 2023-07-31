import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/social_app/model/categories_model.dart';
import 'package:social_app/social_app/shop_cubit/cubit.dart';
import 'package:social_app/social_app/shop_cubit/states.dart';
class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopAppStates>(
      listener: (context,state){},
      builder: (context,state){
        return ListView.separated(
            itemBuilder: (context, index) => buildCatItems(ShopCubit.get(context).CatModel!.data!.data[index]),
            separatorBuilder: (context, index) => Divider(),
            itemCount: ShopCubit.get(context).CatModel!.data!.data.length);
      },
    );
  }
  Widget buildCatItems(DataModel model) => Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Image(
              image: NetworkImage(model.image),
              width: 80,
              height: 80,
              fit: BoxFit.cover,
            ),
            SizedBox(
              width: 20,
            ),
            Text(
              model.name,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Spacer(),
            Icon(Icons.arrow_forward_ios_outlined),
          ],
        ),
      );
}
