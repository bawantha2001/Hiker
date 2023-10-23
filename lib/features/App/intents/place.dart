// ignore: avoid_web_libraries_in_flutter
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:self_employer/features/App/login/ForgotPasswordPage.dart';
import 'package:self_employer/features/App/login/home.dart';
import 'package:self_employer/features/userAuth/firebase_auth_implementation/firebase_auth_services.dart';
import 'package:fluttertoast/fluttertoast.dart';


class Login extends StatefulWidget {
  const Login ({super.key});

  @override
  State<Login> createState() => _Login();
}

class _Login extends State<Login> {
  final FirebaseAuthService _auth=FirebaseAuthService();

  bool isLoading=false;
  late Color myColor;
  late Size mediasize;

  @override
  Widget build(BuildContext context) {
    myColor=Theme.of(context).primaryColor;
    mediasize=MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xFF5b7cff),
      body: Stack(children: [
        Positioned(top: 0,
            left: 50,
            height: 280,
            width: 280,
            child: buildtop()),
        buildbottom(),
      ],),
    );
  }

  Widget buildbottom(){
    return SizedBox(
      width: mediasize.width,
      child:
      Opacity(
        opacity: 1,
        child: Card(
          color: Color(0xFFffffff),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              )
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: buildForm(),
          ),
        ),
      ),
    );
  }

  Widget buildtop(){
    return Column(
      children: <Widget>[
        Image.asset('assets/images/5.png', // Replace with your image asset
            fit: BoxFit.fill),
      ],
    );
  }

  Widget buildForm(){
    return Column();
  }

  Widget buildGreyText(String text){
    return Text(text,style: const TextStyle(
        color: Colors.black
    ),);
  }


  void showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.black,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }


  void connectGoogle()async {
    try {
      GoogleSignInAccount? googleuser = await GoogleSignIn().signIn();
      GoogleSignInAuthentication? googleAuth = await googleuser?.authentication;

      AuthCredential credential=GoogleAuthProvider.credential(
          accessToken: googleAuth?.accessToken,
          idToken:googleAuth?.idToken);
      UserCredential userCredential= await FirebaseAuth.instance.signInWithCredential(credential);
      Navigator.push(context,MaterialPageRoute(builder: (context)=> const home()));
    } catch (e) {
      print(e.toString() + " error");
    }
  }

}

