import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/screens/welcome_screen.dart';
import 'package:chat_app/screens/login_screen.dart';
import 'package:chat_app/screens/registration_screen.dart';
import 'package:chat_app/screens/chat_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Ensure Flutter is initialized
  await Firebase.initializeApp( // Initialize Firebase
  options:FirebaseOptions(
    apiKey: "AIzaSyDo-zkk2qxqX-uWlfAp0LzmhN_JiyyF3VU",
    appId: "1:188493865215:android:8cc37bb8b2ccfafec52cca",
    messagingSenderId: "188493865215",
    projectId: "chat-app-1d236",
  ),
  );

  runApp(MyApp()); // Run your app
}


//void main() => runApp(ChatApp());
// void main() async{
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   runApp(ChatApp());
// }
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      initialRoute: WelcomeScreen.id,
      routes: {
        WelcomeScreen.id:(context) => WelcomeScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        RegistrationScreen.id: (context) => RegistrationScreen(),
        ChatScreen.id: (context) => ChatScreen(),
      }
    );
  }
}
