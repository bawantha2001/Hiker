import 'package:flutter/material.dart';

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
            image: AssetImage("assets/images/p.jpg"),
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

                    const Text("SL Hiker.",
                      style: TextStyle(
                          fontSize: 40,
                          color: Colors.white,
                          fontWeight: FontWeight.w900),
                      textAlign: TextAlign.center,),

                    const Text(
                      "Let’s Find a Place to Explore.",
                      style: TextStyle(
                          fontSize: 15,
                          color: Colors.white,),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 30,),
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
