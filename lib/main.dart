import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/constants/signOu.dart';
import 'package:social_app/social_app/Dio/dio_helper.dart';
import 'package:social_app/social_app/login/login_screen.dart';
import 'package:social_app/social_app/shared_prefernces/cashe_helper.dart';
import 'package:social_app/social_app/shop_cubit/cubit.dart';
import 'package:social_app/social_app/shop_cubit/states.dart';
import 'package:social_app/splash/splash_screen.dart';

import 'splash/splash_after_login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Widget widget;
  DioHelper.init();
  await Cashe_Helper.init();
  bool onBoarding = Cashe_Helper().getData(Key: 'OnBoarding');
   token = Cashe_Helper().getData(Key: 'token');

  if (onBoarding != null) {
    if (token != null) {
      widget = SplashScreenAfterLogin();
    } else {
      widget = ShopLoginScreen();
    }
  } else {
    widget = SplashScreen();
  }

  runApp(MyApp(
    startWidget: widget,
  ));

  print(onBoarding);
  print(token);
}

class MyApp extends StatelessWidget {
  final Widget startWidget;
  MyApp({
    required this.startWidget,
  });
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) => ShopCubit()..getHomeData()..getCategoriesData()..getUserData()..geFavData(),
        ),
      ],
      child: BlocConsumer<ShopCubit,ShopAppStates>(
       listener: (context,state){},
        builder: (context,state)
        {
         return  MaterialApp(
          debugShowCheckedModeBanner: false,
          home: startWidget,
          );
        },
      ),
    );
  }
}
