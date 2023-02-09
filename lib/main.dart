//import 'package:appfi/widget_tree.dart';
import 'package:appfi/Fragments/dashbord_of_fragment.dart';
import 'package:appfi/Screens/registration_screen.dart';
import 'package:appfi/Screens/signin_screen.dart';
import 'package:appfi/Screens/welcome_screen.dart';
import 'package:appfi/widgets/usercur.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized(); 
 await Firebase.initializeApp();  
  runApp( MyApp());
}

class MyApp extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ClothesApp',
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),

   //home: SignInScreen(),
   initialRoute: WelcomeScreen.screenRoute,
   routes: {
    WelcomeScreen.screenRoute: (context)=> WelcomeScreen(),
    SignInScreen.screenRoute: (context)=> SignInScreen(),
    RegistrationScreen.screenRoute: (context)=> RegistrationScreen(),
    DashboardOfFragment.screenRoute:(context) => DashboardOfFragment(),
   },

  
    );
  }
}
