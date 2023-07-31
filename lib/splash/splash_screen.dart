import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:social_app/social_app/on_boarding/on_boarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void initState() {
    // TODO: implement initState
    Future.delayed(const Duration(seconds: 4),(){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
        return const OnBoardingScreen();
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
              const Image(
                image: AssetImage('images/appLogo.png'),
              ),
              SizedBox(height:20),
              AnimatedTextKit(
                animatedTexts: [
                  ScaleAnimatedText('SOUQ',textStyle: const TextStyle(
                    letterSpacing: 8,
                    color: Colors.black,
                    fontSize: 28,
                  ))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}