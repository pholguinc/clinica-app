
import 'package:flutter/material.dart';
import 'package:frontend/screens/home_screen.dart';
import 'package:introduction_screen/introduction_screen.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({Key? key}) : super(key: key);

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}
  
class _IntroScreenState extends State<IntroScreen> {
  final pages = [
    PageViewModel(
       titleWidget: Transform.translate(
         offset: const Offset(0, -40),
         child: const Text(
          "Title of Page 3",
          style: TextStyle(
            fontSize: 35,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
             ),
       ),
      bodyWidget: Transform.translate(
        offset: const Offset(0, -40),
        child: const Text(
          "Description of Page 1",
          style: TextStyle(
            fontSize: 18,
            color: Colors.black,
          ),
        ),
      ),
      image: Image.asset(
          'assets/images/intro01.jpg',
          height: 800,
          width: 800,
        ),
      ),
    
    PageViewModel(
       titleWidget: Transform.translate(
         offset: const Offset(0, -40),
         child: const Text(
          "Title of Page 3",
          style: TextStyle(
            fontSize: 35,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
             ),
       ),
      bodyWidget: Transform.translate(
        offset: const Offset(0, -40),
        child: const Text(
          "Description of Page 1",
          style: TextStyle(
            fontSize: 18,
            color: Colors.black,
          ),
        ),
      ),
      image: Image.asset(
          'assets/images/intro01.jpg',
          height: 800,
          width: 800,
        ),
      ),
      PageViewModel(
       titleWidget: Transform.translate(
         offset: const Offset(0, -40),
         child: const Text(
          "Title of Page 3",
          style: TextStyle(
            fontSize: 35,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
             ),
       ),
      bodyWidget: Transform.translate(
        offset: const Offset(0, -40),
        child: const Text(
          "Description of Page 1",
          style: TextStyle(
            fontSize: 18,
            color: Colors.black,
          ),
        ),
      ),
      image: Image.asset(
          'assets/images/intro01.jpg',
          height: 800,
          width: 800,
        ),
      ),
  ];
  


@override
  void initState() {
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 150),
        child: IntroductionScreen(
          globalBackgroundColor: Colors.white,
          scrollPhysics: const BouncingScrollPhysics(),
          pages: pages,
          onDone: () {
            Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const HomeScreen(),
            ),
          );
          },
          onSkip: () {
            Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const HomeScreen(),
            ),
          );
          },
          showSkipButton: true,
          skip: const Text(
            'Skip',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: Color(0xFF6C63FF),
            ),
          ),
          next: const Icon(
            Icons.arrow_forward,
            color: Color(0xFF6C63FF),
          ),
          done: const Text(
            "Start",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: Color(0xFF6C63FF),
            ),
          ),
          dotsDecorator: DotsDecorator(
            size: const Size.square(10.0),
            activeSize: const Size(20.0, 10.0),
            color: Colors.black26,
            activeColor: const Color(0xFF6C63FF),
            spacing: const EdgeInsets.symmetric(horizontal: 3.0),
            activeShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25.0),
            ),
          ),
        ),
      ),
    );
  }
}
