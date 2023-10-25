import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:self_employer/features/App/login/Login.dart';
import 'package:self_employer/features/App/login/home.dart';

late Size mediasize;

class Loading1 extends StatelessWidget {
  const Loading1({Key? key}) : super(key: key);

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
                      "Explore Vibrant Destinations",
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
                      "Uncover the beauty and culture of \n your chosen destination with our \n "
                      "expert insights and travel tips.",
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
              .push(MaterialPageRoute(builder: (context) => Login()));
        },
      ),

    );


  }
}
