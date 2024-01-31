import 'package:flutter/material.dart';
import 'package:self_employer/features/App/login/Loading_Page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:self_employer/features/App/login/home.dart';

late Size mediasize;

class First extends StatefulWidget {
  const First({Key? key}) : super(key: key);

  @override
  State<First> createState() => _FirstState();
}

class _FirstState extends State<First> {
  final FirebaseAuth firebaseAuth=FirebaseAuth.instance;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    firebaseAuth.authStateChanges().listen((User? user) {
      if (user != null) {
        Navigator.pop(context);
        Navigator.push(
            context, MaterialPageRoute(builder: (context) =>const home()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body:Container(
          decoration: const BoxDecoration(
              image:DecorationImage(image: AssetImage("assets/images/Splash Screen.png"),
              fit: BoxFit.cover,
              )
            ),
          child: InkWell(
          onTap: (){
            Navigator.pop(context);
            Navigator.push(context, MaterialPageRoute(builder: (context)=>const Loading() ),);
          },
        ),
        )
      ),
    );
  }
}
