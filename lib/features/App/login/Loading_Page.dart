import 'package:flutter/material.dart';
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
            image: AssetImage("assets/images/b1.jpg"),
            fit: BoxFit.cover,
          ),
        ),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: mediasize.width,
              child: Center(
                child: Column(

                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 100,
                      height: 100,
                      child: Image.asset("assets/images/10.png"),
                    ),

                    const Text("Traveler.",
                      style: TextStyle(
                          fontSize: 60,
                          color: Colors.white,
                          fontWeight: FontWeight.w900),
                      textAlign: TextAlign.center,),

                    const Text(
                      "Let’s Find a Place to Visit.",
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 30,),
                    const CircularProgressIndicator(
                      color: Colors.white,
                    ),


                  ],
                ),
              ),
            )
          ],
        ) /* add child content here */,
      ),
    );
  }

}
