import 'package:appfi/Fragments/dashbord_of_fragment.dart';
import 'package:appfi/widgets/my_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegistrationScreen extends StatefulWidget {
  static const String screenRoute = 'registration_screen';
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _auth = FirebaseAuth.instance;

  late String email;
  late String password;
  late String name;

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
                      child: Image.asset("images/regi.png"),
                      height: 250,
                      width: 500,
                    ),
                    Container(
                      margin: EdgeInsets.only(right: 20, top: 1),
                      alignment: Alignment.bottomRight,
                      child: Text(
                        "Sign up",
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
                  keyboardType: TextInputType.name,
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    name = value;
                  },
                  decoration: const InputDecoration(
                      icon: Icon(
                        Icons.person,
                        color: Colors.grey,
                      ),
                      hintText: 'Enter your name',
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none)
                      ),
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
              color: Colors.blue[900]!,
              title: 'Register',
              onPressed: () async {
                try {
                  final newUser = await _auth
                      .createUserWithEmailAndPassword(
                    email: email,
                    password: password,
                  )
                      .then(
                    (value) {
                      FirebaseFirestore.instance
                          .collection('users')
                          .doc(value.user!.uid)
                          .set(
                        {
                          'fullName': name,
                          'email': email,
                          'password': password,
                        },
                      );
                    },
                  );

                  Navigator.pushNamed(
                    context,
                    DashboardOfFragment.screenRoute,
                  );
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
