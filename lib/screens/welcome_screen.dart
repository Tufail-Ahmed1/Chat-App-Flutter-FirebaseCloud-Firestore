import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:chat_app/screens/login_screen.dart';
import 'package:chat_app/screens/registration_screen.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/components/rounded_button.dart';


class WelcomeScreen extends StatefulWidget {
  static const String id = 'welcome_screen';
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}
class _WelcomeScreenState extends State<WelcomeScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Hero(
                  tag: 'logo3',
                  child:Container(
                    child: Image.asset('images/logo3.png'),
                    height: 60.0,
                  ),
                ),
                AnimatedTextKit(
                  animatedTexts: [
                  TyperAnimatedText('Chat App',
                  textStyle: TextStyle(
                    fontSize: 45.0,
                    fontWeight: FontWeight.w900,
                  ),
                  ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 48.0,
            ),
            RoundedButton(colour: Color(0xFF0073E6),text: 'Log in',OnPressed: () {
              Navigator.pushNamed(context, LoginScreen.id);
            }),
            RoundedButton(colour: Color(0xFF0073E6),text: 'Register' ,OnPressed: () {
              Navigator.pushNamed(context, RegistrationScreen.id);
            })
          ],
        ),
      ),
    );
  }
}

class MyColors {
  static const Color lightBlue = Color(0xFF003366);
  static const Color darkBlue = Color(0xFF004080);
  static const Color lightNavy = Color(0xFF0059B3);
  static const Color navyBlue = Color(0xFF0073E6);
  static const Color selectionBackground = Color(0xFF1A75FF);
}
