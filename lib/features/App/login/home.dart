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
      body: Column(

        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20.0, 40.0, 20.0, 0),

            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Text(
                        "Travelers",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 22.0,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
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
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Center(
                      child: Text("Most Visited Palces",style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22.0,
                      )),
                    ),
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                    ],
                  )
              ),
            ),

          Padding(padding: EdgeInsets.fromLTRB(5.0,0,5.0,0),
            child: Container(
              height:140,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  buildCard(),
                  SizedBox(width: 12,),
                  buildCard(),
                  SizedBox(width: 12,),
                  buildCard(),
                  SizedBox(width: 12,),
                  buildCard(),
                  SizedBox(width: 12,),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              child: SizedBox(
                  child: Text("Place Nearby",style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22.0,
                  ),)),
            ),
          ),
          Container(
            width: 400,
            height: 420,
            decoration: BoxDecoration(
              color: Colors.cyan,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25),
                topRight: Radius.circular(25),
              ),
            ),

          )
        ],
      ),
    );

    void signOut() async {
      await FirebaseAuth.instance.signOut().then((value) => Navigator.push(
          context, MaterialPageRoute(builder: (context) => const Login())));
    }
  }
  Widget buildCard()=> Container(
    width: 200,
    decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(20),
      border: Border.all(color: Colors.black)
    ),
  );
}

