import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);


  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  TextEditingController emailController=TextEditingController();
  late Size mediasize;

  @override
  void dispose(){
    emailController.dispose();
    super.dispose();
  }

Future <void> passwordReset() async{
  try {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: emailController.text.trim());
    showDialog(
        context: context,
        builder: (context){
          return AlertDialog(content:Text("Password reset link was sent to the email :- "+emailController.text));
        });
  }
  on FirebaseAuthException catch (e) {
    print(e);
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(content: Text(e.message.toString()),
          );
        });
  }
}

  @override
  Widget build(BuildContext context) {
    mediasize=MediaQuery.of(context).size;
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

  Widget buildBody(){
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
        buildGreyText("Enter Email"),
        buildInputField(emailController),
        const SizedBox(height: 40,),
        buildResetButton(),
      ],
    );
  }

  Widget buildResetButton(){
    return ElevatedButton(onPressed: passwordReset,
      style: ElevatedButton.styleFrom(
        shape: const StadiumBorder(),
        elevation: 10,
        backgroundColor: Colors.green,
        minimumSize: Size.fromHeight(50),
      ),
      child: const Text("Reset"),
    );
  }

  Widget buildInputField(TextEditingController controller,
      {isPassword=false}){
    return Container(
      height: 50,
      child: TextField(
        controller: controller,
        style: TextField.materialMisspelledTextStyle,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
              borderSide: const BorderSide(
                color: Colors.blue,
              )
          ),
        ),
        obscureText: isPassword,
      ),
    );
  }


  Widget buildGreyText(String text){
    return Text(text,style: const TextStyle(
        color: Colors.black
    ),);
  }
}
