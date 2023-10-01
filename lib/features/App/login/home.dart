import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:self_employer/features/App/login/Login.dart';

class home extends StatefulWidget {
  const home ({super.key});

  @override
  State<home> createState() => _State();
}

class _State extends State<home> {

  late Size mediasize;
  bool issignout=false;

  @override
  Widget build(BuildContext context) {
    mediasize = MediaQuery
        .of(context)
        .size;
    return Scaffold(
      backgroundColor: const Color(0xFF1E1F22),
      body:
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Container(
                child: buildBody()
            ),
          ),
        ],
      ),
    );
  }


  Widget buildBody() {
    return Column(
      children: [
        SizedBox(
          width: mediasize.width,
          child:
          Opacity(
            opacity: 0.8,
            child: Card(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  )
              ),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: buildForm(),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildForm(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Center(
          child: Text(
            "Reset Password",
            style: TextStyle(
                color: Colors.green,
                fontSize: 32,
                fontWeight: FontWeight.w500
            ),
          ),
        ),
        const SizedBox(height: 20,),
        ElevatedButton(onPressed: (){
          setState(() {
            issignout=true;
          });
          signOut();
        },
            child: issignout? const Row(mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Sign out....    "),
                CircularProgressIndicator(color: Colors.white,),
              ],
            ):const Text("Sign out")),
      ],
    );
  }

  void signOut() async{
    await FirebaseAuth.instance.signOut().then((value) => Navigator.push(context, MaterialPageRoute(builder: (context)=> const Login())));
  }

}
