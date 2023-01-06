// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_constructors, duplicate_ignore, sort_child_properties_last, unused_import

import 'package:flutter/material.dart';
import 'package:intl/number_symbols_data.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'login_screen.dart';

class OnBoardingScreen extends StatelessWidget {
  OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 55),
        child: IntroductionScreen(
          pages: [
          PageViewModel(
            title: 'Donate Effortlessly',
            body:
                'Donate from your comfort zone and choose the service that suits you!',
            image: Padding(
              padding: const EdgeInsets.only(top: 12),
              child: Image.asset('assets/images/donate.png'),
            ),
            decoration: const PageDecoration(
            titleTextStyle: TextStyle(
                color: Colors.black,
                fontSize: 25.0,
                fontWeight: FontWeight.bold,
              ),
            bodyTextStyle: TextStyle(
                color: Colors.black,
                fontSize: 16.0,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          PageViewModel(
            title: 'Hunger Spots',
            body:
                'These are the places where the needy people live and you can be the one to identify it by adding one!',
            image: Padding(
              padding: const EdgeInsets.only(top: 12),
              child: Image.asset('assets/images/hunger_spot_onboard.png'),
            ),
            decoration: const PageDecoration(
            titleTextStyle: TextStyle(
                color: Colors.black,
                fontSize: 25.0,
                fontWeight: FontWeight.bold,
              ),
            bodyTextStyle: TextStyle(
                color: Colors.black,
                fontSize: 16.0,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          PageViewModel(
            title: 'So , What\'s backing you?',
            body: 'Help needy as much as you can!',
            image: Padding(
              padding: const EdgeInsets.only(top: 12),
              child: Image.asset('assets/images/help_needy.png'),
            ),
            decoration: const PageDecoration(
            titleTextStyle: TextStyle(
                color: Colors.black,
                fontSize: 25.0,
                fontWeight: FontWeight.bold,
            ),
            bodyTextStyle: TextStyle(
                color: Colors.black,
                fontSize: 16.0,
                fontWeight: FontWeight.w400,
            ),
            ),
            footer: SizedBox(
              width: 200,
              height: 50,
              child: ElevatedButton(
                onPressed: () => Navigator.of(context).pushNamed('/login'),
                // ignore: prefer_const_constructors
                child: Text(
                  'Get Started',
                  style: TextStyle(
                    color: Colors.white, 
                    fontSize: 16,
                    fontFamily: 'Poppins',
                    ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  shape: const StadiumBorder(),
                ),
              ),
            ),
          ),
        ],
          dotsDecorator: DotsDecorator(
            size: Size(10, 10),
            activeSize: Size(22, 10),
            color: Colors.orange,
            activeShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24.0),
            ),
            activeColor: Colors.orange,
          ),
          showDoneButton: true,
          done: const Text(
            'Done',
            style: TextStyle(
              fontSize: 18,
              fontFamily: 'Poppins',
              ),
          ),
          showSkipButton: true,
          skip: const Text(
            'Skip',
            style: TextStyle(
              fontSize: 18,
              fontFamily: 'Poppins',
              ),
          ),
          showNextButton: true,
          next: const Icon(Icons.arrow_forward, size: 20),
          onDone: () => Navigator.of(context).pushNamed('/login'),
          //globalBackgroundColor: Colors.orange,
        ),
      ),
    );
  }
}
