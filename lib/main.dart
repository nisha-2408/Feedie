// ignore_for_file: prefer_const_constructors, depend_on_referenced_packages

import 'package:feedie/providers/auth.dart';
import 'package:feedie/providers/food_request_process.dart';
import 'package:feedie/providers/hunger_spot.dart';
import 'package:feedie/providers/ngo_food_request.dart';
import 'package:feedie/providers/user_data.dart';
import 'package:feedie/screens/accepted_request_screen.dart';
import 'package:feedie/screens/admin_screen.dart';
import 'package:feedie/screens/all_hunger_spots.dart';
import 'package:feedie/screens/choose_role_screen.dart';
import 'package:feedie/screens/donation_screen.dart';
import 'package:feedie/screens/forgot_password_screen.dart';
import 'package:feedie/screens/home_screen.dart';
import 'package:feedie/screens/hunger_spot_donate.dart';
import 'package:feedie/screens/hunger_spot_form_screen.dart';
import 'package:feedie/screens/hunger_spot_map_screen.dart';
import 'package:feedie/screens/hunger_spot_screen.dart';
import 'package:feedie/screens/login_screen.dart';
import 'package:feedie/screens/ngo_donate_screen.dart';
import 'package:feedie/screens/ngo_food_request.dart';
import 'package:feedie/screens/onboarding_screen.dart';
import 'package:feedie/screens/signup_screen.dart';
import 'package:feedie/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (ctx) => Auth()),
          ChangeNotifierProxyProvider<Auth, UserData>(
            update: (context, auth, previous) =>
                UserData(token: auth.token, userId: auth.userId),
            create: (context) => UserData(token: '', userId: ''),
          ),
          ChangeNotifierProxyProvider<Auth, HungerSpot>(
            update: (context, auth, previous) =>
                HungerSpot(token: auth.token, userId: auth.userId),
            create: (context) => HungerSpot(token: '', userId: ''),
          ),
          ChangeNotifierProxyProvider<Auth, FoodRequestProcess>(
            create: (context) => FoodRequestProcess(userId: ''),
            update: (context, value, previous) =>
                FoodRequestProcess(userId: value.userId),
          ),
          ChangeNotifierProxyProvider<UserData, NGORequest>(
            create: (context) => NGORequest(
                userId: '',
                ngoName: '',
                address: '',
                contact: '',
                imageUrl: ''),
            update: (context, value, previous) => NGORequest(
                userId: value.getDetails['userId'],
                ngoName: value.getDetails['name'],
                address: value.getDetails['address'],
                imageUrl: value.getDetails['imageUrl'],
                contact: value.getDetails['contact']),
          )
        ],
        child: Consumer<Auth>(
          builder: (ctx, auth, _) => MaterialApp(
            title: 'Feedie',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
                colorScheme: ThemeData()
                    .colorScheme
                    .copyWith(primary: Colors.orange, secondary: Colors.blue),
                fontFamily: 'Poppins',
                textTheme: ThemeData.light().textTheme.copyWith(
                    bodyText1: TextStyle(
                      color: Color.fromARGB(221, 138, 137, 137),
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                    ),
                    caption: TextStyle(
                        color: Colors.orange,
                        fontWeight: FontWeight.w900,
                        fontSize: 32),
                    bodyText2: TextStyle(
                        color: Colors.orange,
                        fontSize: 12,
                        fontWeight: FontWeight.bold)),
                elevatedButtonTheme: ElevatedButtonThemeData(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange))),
            home: auth.isAuth
                ? auth.newUser
                    ? ChooseRole()
                    : Home()
                : FutureBuilder(
                    future: auth.tryAutoLogin(),
                    builder: (context, snapshot) =>
                        snapshot.connectionState == ConnectionState.waiting
                            ? SplashScreen()
                            : OnBoardingScreen(),
                  ),
            routes: {
              '/login': (context) => LoginScreen(),
              '/signup': (context) => SignUpScreen(),
              '/forgot_password': (context) => ForgotPassword(),
              '/home': (context) => Home(),
              '/onnboarding': (context) => OnBoardingScreen(),
              HungerSpotForm.routeName: (context) => HungerSpotForm(),
              HungerSpotMap.routeName: (context) => HungerSpotMap(),
              HungerSpotScreen.routeName: (context) => HungerSpotScreen(),
              AdminScreen.routeName: (context) => AdminScreen(),
              AllHungerSpots.routeName: (context) => AllHungerSpots(),
              HungerSpotDonate.routeName: (context) => HungerSpotDonate(),
              DonationScreen.routeName: (context) => DonationScreen(),
              NGOFoodRequest.routeName: (context) => NGOFoodRequest(),
              NGODonate.routeName:(context) => NGODonate(),
              FoodAcepted.routeName:(context) => FoodAcepted()
            },
          ),
        ));
  }
}
