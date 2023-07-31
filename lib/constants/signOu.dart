import 'package:flutter/material.dart';
import 'package:social_app/social_app/login/login_screen.dart';
import 'package:social_app/social_app/shared_prefernces/cashe_helper.dart';
import 'package:social_app/social_app/shop_cubit/cubit.dart';
String token='';
String categories='categories';
String favorites='favorites';

  void SignOut(context){
    Cashe_Helper.removeData(
      Key: 'token',
    ).then((value) => {
      if (value)
        {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => ShopLoginScreen())),
        }
    });
  }

Widget buildItem( model,context,{bool isOldPrice=true})=> Padding(

  padding: const EdgeInsets.all(20.0),
  child: SizedBox(
    height: 120,
    child: Row(
      children: [
        Stack(
          alignment: AlignmentDirectional.bottomStart,
          children: [
            Image(
              image: NetworkImage(model.image),
              width:120,
              height: 120,
            ),
            if (model.discount != 0 && isOldPrice)
              Container(
                color: Colors.red,
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: const Text(
                  'DISCOUNT',
                  style: TextStyle(color: Colors.white, fontSize: 8),
                ),
              ),
          ],
        ),
        const SizedBox(width: 20,),
        Expanded(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  model.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 14, height: 1.3),
                ),
                const Spacer(),
                Row(
                  children: [
                    Text(
                      model.price.toString(),
                      style:
                      const TextStyle(fontSize: 12, color: Colors.blueAccent),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    if (model.discount != 0 && isOldPrice)
                      Text(
                        model.oldPrice.toString(),
                        style: const TextStyle(
                            fontSize: 10,
                            decoration: TextDecoration.lineThrough,
                            color: Colors.grey),
                      ),
                    const Spacer(),
                    IconButton(
                      onPressed: () {
                        // print(productModel.id);
                        ShopCubit.get(context)
                            .changFavorites(model.id);
                      },
                      icon: CircleAvatar(
                        radius: 15,
                        backgroundColor:  ShopCubit.get(context).favourites[model.id]?? true
                            ? Colors.orange.shade400
                            : Colors.grey,
                        child: const Icon(
                          Icons.favorite_border,
                          color: Colors.white,
                          size: 18,
                        ),
                      ),
                    )
                  ],
                ),
              ]),
        ),
      ],
    ),
  ),
);
