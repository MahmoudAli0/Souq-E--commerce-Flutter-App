import 'package:flutter/material.dart';
import 'package:social_app/social_app/layout/shop_layout.dart';
import 'package:lottie/lottie.dart';


class SplashScreenAfterLogin extends StatefulWidget {
  const SplashScreenAfterLogin({Key? key}) : super(key: key);

  @override
  State<SplashScreenAfterLogin> createState() => _SplashScreenAfterLogin();
}

class _SplashScreenAfterLogin extends State<SplashScreenAfterLogin> {
  void initState() {
    // TODO: implement initState
    Future.delayed(const Duration(seconds: 4),(){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
        return const ShopLayout();
      }));
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Lottie.network (
                  'https://assets7.lottiefiles.com/packages/lf20_uqs1ib9v.json'
              ),
            ],
          ),
        ),
      ),
    );
  }
}