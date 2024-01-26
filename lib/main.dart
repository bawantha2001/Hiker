import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:self_employer/features/App/login/Loading_Page.dart';
import 'package:flutter/material.dart';
import 'package:self_employer/features/App/login/Login.dart';



Future main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: const FirebaseOptions(apiKey: "AIzaSyAbek30PIBq1FGR4U3OLeqRk8AkHiwo2ao", appId: "1:669801937866:android:6d315a7bb9b3d3b5432d33", messagingSenderId: "669801937866", projectId: "self-emp"));
  runApp(const MyApp());
  await Future.delayed(const Duration(seconds: 5));
  runApp(const MyAppnext());

}

class MyApp extends StatelessWidget{
  const MyApp({Key? key}):super(key: key);

  @override
  Widget build(BuildContext context){
    return  const MaterialApp(
      home:Loading(),
      debugShowCheckedModeBanner: false,
    );
  }

}

class MyAppnext extends StatelessWidget{
  const MyAppnext({Key? key}):super(key: key);

  @override
  Widget build(BuildContext context){
    return  const MaterialApp(
      home:Login(),
      debugShowCheckedModeBanner: false,
    );
  }

}
