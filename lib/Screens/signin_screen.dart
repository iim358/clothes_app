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
       backgroundColor: const Color.fromARGB(255, 169, 126, 126),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 350,
              decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.only(bottomLeft: Radius.circular(90)),
                color: Colors.orange,
                gradient: LinearGradient(
                    colors: [(Colors.lightBlueAccent), (Colors.blueGrey)],
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
                      height: 250,
                      width: 500,
                    ),
                    Container(
                      margin: EdgeInsets.only(right: 20, top: 1),
                      alignment: Alignment.bottomRight,
                      child: Text(
                        "Sign in",
                        style: TextStyle(fontSize: 30, color: Colors.white),
                      ),
                    )
                  ],
                ),
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
                      color: Colors.black)
                ],
              ),
              alignment: Alignment.center,
              child: TextField(
                  cursorColor: Colors.black,
                  keyboardType: TextInputType.emailAddress,
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    email = value;
                  },
                  decoration: const InputDecoration(
                      icon: Icon(
                        Icons.email,
                        color: Colors.grey,
                      ),
                      hintText: 'Enter your email',
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none)),
            ),
            Container(
              margin: EdgeInsets.only(left: 20, right: 20, top: 20),
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
                      color: Colors.black)
                ],
              ),
              alignment: Alignment.center,
              child: TextField(
                  cursorColor: Colors.black,
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
                      focusedBorder: InputBorder.none)),
            ),
            SizedBox(height: 60),
            MyButton(
              color: Colors.cyan[900]!,
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
