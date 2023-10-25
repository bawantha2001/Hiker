import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:self_employer/features/App/login/Loading1.dart';
import 'package:self_employer/features/App/login/Login.dart';
import 'package:self_employer/features/App/login/home.dart';

late Size mediasize;

class Loading extends StatelessWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    mediasize = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/b2.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            SizedBox(
              width: mediasize.width,
              child: const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 350,
                    ),
                    Text(
                      "Let’s Find a  \n Place to Visit",
                      style: TextStyle(
                          fontSize: 50,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Let’s start here!",
                      style: TextStyle(fontSize: 20, color: Colors.white),
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
              ),
            )
          ],
        ) /* add child content here */,
      ),
      floatingActionButton: FloatingActionButton.extended(
        // elevation: 20.0,
        backgroundColor: Colors.transparent,
        // child: const Icon(Icons.arrow_forward),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(color: Colors.white,width: 2),
        ),
        label: const Text("Next",style: TextStyle(
          fontWeight: FontWeight.bold,
         fontSize: 15,
        color: Colors.white,
        ),
        ),
        onPressed: (){
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => Loading1()));
        },
      ),
    );
  }

}
