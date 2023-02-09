import 'package:appfi/Screens/welcome_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:appfi/widgets/my_button.dart';
import 'package:get/get.dart';

class ProfileFragmentScreen extends StatefulWidget {
  const ProfileFragmentScreen({super.key});

  @override
  State<ProfileFragmentScreen> createState() => _ProfileFragmentscreenState();
}

class _ProfileFragmentscreenState extends State<ProfileFragmentScreen> {
  final firestore = FirebaseFirestore.instance;
  Map<String, dynamic> userData = {};
  @override
  void initState() {
    getUserData();
    super.initState();
  }

  getUserData() async {
    final userUid = FirebaseAuth.instance.currentUser!.uid;
    final result = await firestore.collection('users').doc(userUid).get();
    userData = result.data() ?? {};
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
               colors:[Color.fromARGB(255, 83, 106, 118), Color.fromARGB(255, 202, 223, 240)] 
                ),
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  Center(
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage: NetworkImage(
                        userData['photoUrl'] ??
                            'https://toppng.com/uploads/preview/instagram-default-profile-picture-11562973083brycehrmyv.png',
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      const Text(
                        'Name',
                      ),
                      const Spacer(),
                      Text(
                        userData['fullName'] ?? '',
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      const Text(
                        'Email',
                      ),
                      const Spacer(),
                      Text(
                        userData['email'] ?? '',
                      ),

                       SizedBox(height: 60),
              
                    ],
                    
                  ),
                  SizedBox(height: 70),
                   MyButton(
              color: Colors.cyan[900]!,
              title: 'Sign out',
              onPressed: () async {
               await FirebaseAuth.instance.signOut();
               if (User != null){
                Navigator.pushNamed(
                  context,WelcomeScreen.screenRoute
                   );

               }
               
              
              }
            ),
                 
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
