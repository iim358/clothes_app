import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:appfi/widgets/my_button.dart';

class ClothesScreen extends StatefulWidget {
  static const String screenRoute = 'clothes_screen';
  const ClothesScreen({super.key});

  @override
  State<ClothesScreen> createState() => _ClothesScreenState();
}


class _ClothesScreenState extends State<ClothesScreen> {



final _auth =FirebaseAuth.instance;
late User signedInUser;

 @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

void getCurrentUser() {
  
  try {
  final user = _auth.currentUser;
  if(user != null) {
  signedInUser = user;
  print(signedInUser.email);
  }
  } 
  catch(e) {
    print(e);
  }
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
      ),
    );
  }
  
}