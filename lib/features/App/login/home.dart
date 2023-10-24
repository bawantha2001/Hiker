import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:self_employer/features/App/intent/place.dart';
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
                        "Traveler",
                        style: TextStyle(
                            color: Colors.blue,
                            fontSize: 38.0,
                            fontWeight: FontWeight.bold,
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
                        fontSize: 22.0,color: Colors.green,
                      )),
                    ),
                  ),

                  SizedBox(
                    height: 10.0,
                  ),
                    ],
                  )
              ),
            ),

          Padding(padding: EdgeInsets.fromLTRB(5.0,0,5.0,0),
            child: Container(
              height:250,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  buildCard("Sigiriya","Polonnaruwa,Sri Lanka",'assets/images/sigiriya.jpg'),
                  SizedBox(width: 12,),
                  buildCard("Watadage","Polonnaruwa,Sri Lanka",'assets/images/watadage.jpg'),
                  SizedBox(width: 12,),
                  buildCard("Temple of the Tooth","Kandy,Sri Lanka",'assets/images/templeof.jpg'),
                ],
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              child: SizedBox(
                  child: Text("Place Nearby",style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22.0,color: Colors.green,
                  ),)),
            ),
          ),

          Container(
            width: mediasize.width,
            height: mediasize.height-532,
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

  Widget buildCard(String placeName,String locationName,String imageName)=> Container(
    width: 180,
    decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(20),
      border: Border.all(color: Colors.black)
    ),
    child:
    Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                  child: Image.asset(imageName,fit: BoxFit.fill,height: 130,width: 180,))
              ),
          SizedBox(height: 4,),
          Text(
            placeName,
            style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 4,),
          Row(
            children: [
              Icon(Icons.location_on),
              Text(
                locationName,
                style: TextStyle(fontSize: 12),
              ),
            ],
          ),
          TextButton(onPressed: (){
            showToast(placeName);
            Navigator.pop(context);
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => const place()));
          }, child:
          Text(
            'Read More',
            style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold,color: Colors.green),
          ),
          ),
        ],
      ),
    ),
  );

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
}

