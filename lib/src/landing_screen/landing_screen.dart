import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../main_menu/main_menu_screen.dart';
import '../signin/sign_in_screen.dart';
class LandingScreen extends StatefulWidget {
  const LandingScreen({Key? key}) : super(key: key);
  @override
  State<LandingScreen> createState() => _LandingScreenState();
}
class _LandingScreenState extends State<LandingScreen> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context,snap){
        if (snap.data == null) {
          print('User is currently signed out!');
          return SignInScreen();
        } else {
          print('User is signed in!');
          return MainMenuScreen();
        }
      },
    );
  }
}
