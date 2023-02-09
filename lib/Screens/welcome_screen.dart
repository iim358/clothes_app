import 'package:appfi/Screens/registration_screen.dart';
import 'package:appfi/Screens/signin_screen.dart';
import 'package:flutter/material.dart';
import 'package:appfi/widgets/my_button.dart';

class WelcomeScreen extends StatefulWidget {
  static const String screenRoute = 'welcome_screen';

  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      body: Container(
          padding: EdgeInsets.all(10),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image.asset('images/logo.proj.png', height: height * 0.6),
              
                Column(
                  children: [
                    Text(
                      "Clothes app",
                      
                      style: Theme.of(context).textTheme.headline2,
                      
                      
                    ),
                    Text(
                      "Let's get starting shooping clothes",
                      style: Theme.of(context).textTheme.headline6,
                      textAlign: TextAlign.center,
                      
                    ),
                  ],
                ),
                Column(
                  children: [
                    MyButton(
                      color: const Color.fromARGB(222, 74, 20, 140),
                      title: 'Sign in',
                      onPressed: () {
                        Navigator.pushNamed(context, SignInScreen.screenRoute);
                      },
                    ),
                    SizedBox(width: 12),
                    MyButton(
                      color: const Color.fromARGB(222, 74, 20, 140),
                      title: 'Register',
                      onPressed: () {
                        Navigator.pushNamed(
                            context, RegistrationScreen.screenRoute);
                      },
                    ),
                  ],
                ),
              ])),
    );
  }
}
