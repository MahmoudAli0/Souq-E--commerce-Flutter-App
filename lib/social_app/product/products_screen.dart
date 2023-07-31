import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:social_app/social_app/model/categories_model.dart';
import 'package:social_app/social_app/model/home_model.dart';
import 'package:social_app/social_app/shop_cubit/cubit.dart';
import 'package:social_app/social_app/shop_cubit/states.dart';

class ProductScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopAppStates>(
      listener: (context, state) {
        if (state is ShopSucessChangeFavoritesDataStates) {
          if (state.favMode!.status == false) {
            Fluttertoast.showToast(
                msg: state.favMode!.message.toString(),
                backgroundColor: Colors.red,
                toastLength: Toast.LENGTH_SHORT,
                textColor: Colors.white);
          }
        }
      },
      builder: (context, state) {
        return ConditionalBuilder(
          condition: ShopCubit.get(context).homeModel != null &&
              ShopCubit.get(context).CatModel != null,
          builder: (context) => buildProduct(ShopCubit.get(context).homeModel,
              ShopCubit.get(context).CatModel, context),
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  Widget buildProduct(
          HomeModel? model, CategoriesModel? categoriesModel, context) =>
      SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8.0, left: 4, right: 4),
              child: CarouselSlider(
                items: model!.data!.banners!
                    .map((e) => Image(
                          image: NetworkImage('${e.image}'),
                          width: double.infinity,
                          fit: BoxFit.fill,
                        ))
                    .toList(),
                options: CarouselOptions(
                  height: 180,
                  initialPage: 0,
                  enableInfiniteScroll: true,
                  reverse: false,
                  autoPlay: true,
                  viewportFraction: 1.0,
                  autoPlayInterval: Duration(seconds: 3),
                  autoPlayAnimationDuration: Duration(seconds: 1),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  scrollDirection: Axis.horizontal,
                ),
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Categories',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 100,
                    child: ListView.separated(
                      physics: BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) => buildCatgerocialItems(
                          categoriesModel!.data!.data[index]),
                      separatorBuilder: (context, index) => SizedBox(
                        width: 10,
                      ),
                      itemCount: categoriesModel!.data!.data.length,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'New Products ',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Container(
              color: Colors.grey[300],
              child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 1.0,
                  mainAxisSpacing: 1.0,
                  childAspectRatio: 1 / 1.75,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  children: List.generate(
                      model.data!.products!.length,
                      (index) => buildGridProduct(
                          model.data!.products![index], context))),
            ),
          ],
        ),
      );
  Widget buildCatgerocialItems(DataModel? dataModel) => Container(
        height: 100,
        width: 100,
        child: Stack(
          alignment: AlignmentDirectional.bottomCenter,
          children: [
            Image(
              image: NetworkImage(dataModel!.image),
              height: 100,
              width: 100,
            ),
            Container(
                color: Colors.black.withOpacity(0.3),
                width: double.infinity,
                child: Text(
                  dataModel.name,
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                )),
          ],
        ),
      );
  Widget buildGridProduct(ProductModel? productModel, context) => Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Image(
                  image: NetworkImage(productModel!.image),
                  width: double.infinity,
                  height: 200,
                ),
                if (productModel.discount != 0)
                  Container(
                    color: Colors.red,
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    child: Text(
                      'DISCOUNT',
                      style: TextStyle(color: Colors.white, fontSize: 8),
                    ),
                  ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      productModel.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 14, height: 1.3),
                    ),
                    Row(
                      children: [
                        Text(
                          '${productModel.price.round()}',
                          style:
                              TextStyle(fontSize: 12, color: Colors.blueAccent),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        if (productModel.discount != 0)
                          Text(
                            '${productModel.old_price.round()}',
                            style: TextStyle(
                                fontSize: 10,
                                decoration: TextDecoration.lineThrough,
                                color: Colors.grey),
                          ),
                        Spacer(),
                        IconButton(
                          onPressed: () {
                            print(productModel.id);
                            ShopCubit.get(context)
                                .changFavorites(productModel.id);
                          },
                          icon: CircleAvatar(
                            radius: 15,
                            backgroundColor: ShopCubit.get(context)
                                        .favourites[productModel.id] ??
                                    true
                                ? Colors.orange.shade400
                                : Colors.grey,
                            child: Icon(
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
      );
}
