/*

import 'package:appfi/widgets/usercur.dart';
import 'package:appfi/widgets/my_button.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:appfi/Fragments/dashbord_of_fragment.dart';

class SignInScreen extends StatefulWidget {
  static const String screenRoute = 'Signin_screen';
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _auth = FirebaseAuth.instance;
  late String email;
  late String password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 399,
              decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.only(bottomLeft: Radius.circular(90)),
                color: Colors.red,
                gradient: LinearGradient(
                    colors: [(Colors.blue), (Colors.green)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter),
              ),
              child: Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 50),
                    child: Image.asset("images/logo.proj.png"),
                    height: 300,
                    width: 300,
                  ),
                  Container(
                    margin: EdgeInsets.only(right: 20, top: 20),
                    alignment: Alignment.bottomRight,
                    child: Text(
                      "Sign in",
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  )
                ],
              )
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 20, right: 20, top: 70),
              padding: EdgeInsets.only(
                left: 20,
                right: 20,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: Colors.grey[200],
                boxShadow: [
                  BoxShadow(
                      offset: Offset(0, 10),
                      blurRadius: 50,
                      color: Colors.purple)
                ],
              ),
              alignment: Alignment.center,
              //Email
              child: TextField(
                cursorColor: Colors.pink,
                keyboardType: TextInputType.emailAddress,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  email = value;
                },
                decoration: const InputDecoration(
                  icon: Icon(
                    Icons.email,
                    color: Colors.pink,
                  ),
                  hintText: 'Enter your email',
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none
                )
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 20, right: 20, top: 70),
              padding: EdgeInsets.only(
                left: 20,
                right: 20,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: Colors.grey[200],
                boxShadow: [
                  BoxShadow(
                      offset: Offset(0, 10),
                      blurRadius: 50,
                      color: Colors.purple)
                ],
              ),
              alignment: Alignment.center,
              //Password
              child: TextField(
                cursorColor: Colors.pink,
                obscureText: true,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  password = value;
                },
                decoration: const InputDecoration(
                  icon: Icon(
                    Icons.vpn_key_rounded,
                  ),
                  hintText: 'Enter your password',
                     enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none
                )
                  
                  ),
                 
                ),
              
            
            SizedBox(height: 10),
            MyButton(
              color: Colors.purpleAccent[700]!,
              title: 'Sign in',
              onPressed: () async {
                try {
                  final user = await _auth.signInWithEmailAndPassword(
                      email: email, password: password);
                  if (user != null) {
                    Navigator.pushNamed(
                        context, DashboardOfFragment.screenRoute);
                  }
                } catch (e) {
                  print(e);
                }
              },
            )
          ],
        ),
      ),
    );
  }
}


*/