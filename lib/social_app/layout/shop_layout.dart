import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/social_app/login/login_screen.dart';
import 'package:social_app/social_app/search/search_screen.dart';
import 'package:social_app/social_app/shared_prefernces/cashe_helper.dart';
import 'package:social_app/social_app/shop_cubit/cubit.dart';
import 'package:social_app/social_app/shop_cubit/states.dart';

class ShopLayout extends StatelessWidget {
  const ShopLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopAppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var AppCubit = ShopCubit.get(context);
        return Scaffold(
          appBar: AppBar(

            backgroundColor: Colors.orange.shade50,
            elevation: 0.0,
            title: Text(
              'Souq',
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
            actions: [
              IconButton(onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=> SearchScreen()));
              }, icon: Icon(Icons.search),color: Colors.orange.shade500,)
            ],
          ),
          body: AppCubit.bottomNavScreens[AppCubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            backgroundColor: Colors.orange.shade100,
            elevation: 0.0,
            unselectedItemColor: Colors.grey,
            selectedItemColor: Colors.blue,
            type: BottomNavigationBarType.fixed,
            selectedLabelStyle: TextStyle(color: Colors.red),
            currentIndex: AppCubit.currentIndex,
            showSelectedLabels: true,
            showUnselectedLabels: true,
            onTap: (index) {
              AppCubit.changeBottomScreen(index);
            },
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.apps_outlined),
                label: 'Categories',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite),
                label: 'Favorite',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: 'Settings',
              ),
            ],
          ),
        );
      },
    );
  }
}




