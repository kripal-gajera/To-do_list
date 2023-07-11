import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:to_do/screens/Homepage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: SpleshScreen(), debugShowCheckedModeBanner: false);
  }
}

class SpleshScreen extends StatelessWidget {
  const SpleshScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Padding(
        padding: EdgeInsets.only(top: 250),
        child: Column(
          children: [
            Image.asset(
              'assets/images/021120_NoteTaking-Blog.jpg',
              fit: BoxFit.fill,
            ),
          ],
        ),
      ),
      backgroundColor: Colors.white,
      nextScreen: Homepage(),
      splashIconSize: 1000,
      duration: 3000,
      splashTransition: SplashTransition.fadeTransition,
    );
  }
}
