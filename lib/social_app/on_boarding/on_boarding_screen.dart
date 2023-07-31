import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:social_app/social_app/login/login_screen.dart';
import 'package:social_app/social_app/shared_prefernces/cashe_helper.dart';

class BuildBording {
  final String image;
  final String title;
  final String body;

  BuildBording({required this.image, required this.title, required this.body});
}

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var pageController = PageController();

  bool isLast = false;

  List<BuildBording> PagesImages = [
    BuildBording(
        image: 'images/page11.png',
        title: 'Choose Your Product ',
        body:
            'Just 2 Clickes and You Can by Whatever You Want and add it to your chart '),
    BuildBording(
        image: 'images/page11.png',
        title: 'Add To Chart ',
        body:
            'Just 2 Clickes and You Can by Whatever You Want and add it to your chart '),
    BuildBording(
        image: 'images/page11.png',
        title: 'Pay By Card ',
        body:
            'Just 2 Clickes and You Can by Whatever You Want and add it to your chart '),
  ];

  void skipBoarding() {
    Cashe_Helper.saveData(Key: 'OnBoarding', Value: true)
        .then((value) => {
              if (value)
                {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ShopLoginScreen()))
                }
            })
        .catchError((e) {
      print(e.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: const Text(
          'Shop Boarding ',
          style: TextStyle(fontWeight: FontWeight.normal, color: Colors.black),
        ),
        actions: [
          TextButton(
              onPressed: () {
                skipBoarding();
              },
              child: const Text(
                'Skip',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                ),
              ))
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: pageController,
              onPageChanged: (int index) {
                if (index == PagesImages.length - 1) {
                  print('last');
                  setState(() {
                    isLast = true;
                  });
                } else {
                  print('not yet');
                  isLast = false;
                }
              },
              itemBuilder: (context, index) =>
                  buildBoardingItem(PagesImages[index]),
              itemCount: PagesImages.length,
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SmoothPageIndicator(
                  controller: pageController,
                  effect: const ExpandingDotsEffect(
                      dotHeight: 10,
                      activeDotColor: Colors.deepOrange,
                      expansionFactor: 4,
                      spacing: 5,
                      dotWidth: 10),
                  count: PagesImages.length,
                ),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: FloatingActionButton(
                  onPressed: () {
                    if (isLast) {
                      skipBoarding();
                    }
                    pageController.nextPage(
                        duration: const Duration(milliseconds: 750),
                        curve: Curves.fastLinearToSlowEaseIn);
                  },
                  child: Icon(
                    Icons.arrow_forward,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

Widget buildBoardingItem(BuildBording model) => Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Image(
            image: AssetImage(model.image),
          ),
        ),
        const SizedBox(
          height: 30.0,
        ),
        Text(model.title.toString(),
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24,
            )),
        const SizedBox(
          height: 14.0,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            model.body.toString(),
            style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w400,
                color: Colors.blueGrey),
          ),
        ),
      ],
    );
