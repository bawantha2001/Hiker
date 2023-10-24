import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:self_employer/features/App/login/Login.dart';

class home extends StatefulWidget {
  const home({super.key});

  @override
  State<home> createState() => _State();
}

class _State extends State<home> {
  late Size mediasize;
  bool issignout = false;

  @override
  Widget build(BuildContext context) {
    mediasize = MediaQuery.of(context).size;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(50.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  "Travelers",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ),
              SizedBox(
                height: 30.0,
              ),
              TextField(
                style:TextStyle(
                    color: Colors.black,
                  fontWeight: FontWeight.bold
                ),
                decoration: InputDecoration(
                  filled: true,
                  fillColor:Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  hintText: "Ex:Sigiriya ",
                  prefixIcon: Icon(Icons.search),
                  prefixIconColor: Colors.black
                ),

              )
            ],
          ),
        ),
      ),
    );

    void signOut() async {
      await FirebaseAuth.instance.signOut().then((value) => Navigator.push(
          context, MaterialPageRoute(builder: (context) => const Login())));
    }
  }
}
// class CustomerSearchDelegate extends  SearchDelegate{
//   @override
//   List<Widget> buildActions(BuildContext context){}
//
//   @override
//   List<Widget> buildActions(BuildContext context){}
//
//   @override
//   List<Widget> buildActions(BuildContext context){}
//
//   @override
//   List<Widget> buildActions(BuildContext context){}

// }
