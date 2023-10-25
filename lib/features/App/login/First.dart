import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:self_employer/features/App/login/Loading_Page.dart';

late Size mediasize;

class First extends StatelessWidget {
  const First({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body:Container( child: InkWell(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>Loading() ),);
          },
        ),
            decoration: const BoxDecoration(
              image:DecorationImage(image: AssetImage("assets/images/Splash Screen.png"),
              fit: BoxFit.cover,
              )
            ),
        )
      ),
    );
  }

}
