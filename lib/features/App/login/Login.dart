// ignore: avoid_web_libraries_in_flutter
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:self_employer/features/App/login/ForgotPasswordPage.dart';
import 'package:self_employer/features/App/login/home.dart';
import 'package:self_employer/features/userAuth/firebase_auth_implementation/firebase_auth_services.dart';
import 'package:fluttertoast/fluttertoast.dart';


class Login extends StatefulWidget {
  const Login ({super.key});

  @override
  State<Login> createState() => _Login();
}

class _Login extends State<Login> {
  final FirebaseAuthService _auth = FirebaseAuthService();
  final FirebaseAuth firebaseAuth=FirebaseAuth.instance;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    firebaseAuth.authStateChanges().listen((User? user) {
      if (user != null) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const home()));
      }
    });
  }

  bool isLoading = false;
  late Color myColor;
  late Size mediasize;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmpasswordController = TextEditingController();
  bool remember = false;
  bool showForm = true;

  void toggle_form() {
    setState(() {
      showForm = !showForm;
    });
  }


  @override
  Widget build(BuildContext context) {
    myColor = Theme
        .of(context)
        .primaryColor;
    mediasize = MediaQuery
        .of(context)
        .size;

    return Scaffold(
      backgroundColor: const Color(0xFF5b7cff),
      body: Stack(children: [
        Positioned(top: 0,
            left: 50,
            height: 280,
            width: 280,
            child: buildtop()),
        buildAnimatedsingup(),
      ],),
    );
  }

  Widget buildbottom() {
    return SizedBox(
      width: mediasize.width,
      child:
      Opacity(
        opacity: 1,
        child: Card(
          color: Color(0xFFffffff),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              )
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: buildForm(),
          ),
        ),
      ),
    );
  }

  Widget buildtop() {
    return Column(
      children: <Widget>[
        Image.asset('assets/images/5.png', // Replace with your image asset
            fit: BoxFit.fill),
      ],
    );
  }

  Widget buildbottom2() {
    return SizedBox(
        width: mediasize.width,
        child:
        Opacity(
          opacity: 1,
          child: Card(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),

            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: buildsignupForm(),
            ),
          ),
        )

    );
  }

  Widget buildForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Center(
          child: Text(
            "LOGIN",
            style: TextStyle(
                color: Color(0xFF5b7cff),
                fontSize: 32,
                fontWeight: FontWeight.w500
            ),
          ),
        ),
        Center(
          child: buildGreyText("Please login with your information"),
        ),
        const SizedBox(height: 30,),
        buildGreyText("Email address"),
        buildInputField(emailController),
        buildGreyText("Password"),
        buildInputField(passwordController, isPassword: true),
        buildRemember(),
        const SizedBox(height: 10),
        buildLoginButton(),
        const SizedBox(height: 10),
        const Center(
          child: Text("OR"),
        ),
        buildGoogle(),
        buildsignup(),
      ],
    );
  }

  Widget buildGreyText(String text) {
    return Text(text, style: const TextStyle(
        color: Colors.black
    ),);
  }

  Widget buildInputField(TextEditingController controller,
      {isPassword = false}) {
    return SizedBox(
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
                color: Colors.black,
              )
          ),
        ),
        obscureText: isPassword,
      ),
    );
  }

  Widget buildRemember() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton(onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(
                  builder: (context) => const ForgotPasswordPage()));
        },
          style: TextButton.styleFrom(
              foregroundColor: Color(0xFF5b7cff)
          ),
          child: const Text(" Forgot password"),
        ),
      ],
    );
  }

  Widget buildLoginButton() {
    return ElevatedButton(onPressed: () {
      checksignin();
    },
      style: ElevatedButton.styleFrom(
        elevation: 5,
        backgroundColor: Color(0xFF5b7cff),
        shadowColor: Color(0xFF5b7cff),
        minimumSize: const Size.fromHeight(50),
      ),
      child: isLoading ? const Row(mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Login....    "),
          CircularProgressIndicator(color: Colors.white,),
        ],
      ) : const Text("LOGIN"),

    );
  }

  Widget buildsignupButton() {
    return ElevatedButton(onPressed: () {
      checkSignup();
    },
      style: ElevatedButton.styleFrom(
        elevation: 5,
        backgroundColor: Color(0xFF5b7cff),
        shadowColor: Color(0xFF5b7cff),
        minimumSize: const Size.fromHeight(50),
      ),
      child: isLoading ? const Row(mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Creating account....    "),
          CircularProgressIndicator(color: Colors.white,),
        ],
      ) : const Text("SIGNUP"),
    );
  }

  Widget buildsignup() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        buildGreyText("Don't you have an account? "),
        TextButton(onPressed: () {
          toggle_form();
        },
            style: TextButton.styleFrom(
              foregroundColor: Color(0xFF5b7cff),
            ),
            child: const Text("Create an account")),
      ],
    );
  }

  Widget buildlogin() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        buildGreyText("Do you have an account? "),
        TextButton(onPressed: () {
          toggle_form();
        },
            style: TextButton.styleFrom(
              foregroundColor: Color(0xFF5b7cff),
            ),
            child: const Text("LOGIN")),
      ],
    );
  }

  Widget buildsignupForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Center(
          child: Text("Signup", style: TextStyle(
              color: Color(0xFF5b7cff),
              fontSize: 32,
              fontWeight: FontWeight.w500
          ),
          ),
        ),
        Center(
          child:
          buildGreyText("Please enter your information"),
        ),
        const SizedBox(height: 30,),
        buildGreyText("Email address"),
        buildInputField(emailController),
        buildGreyText("Password"),
        buildInputField(passwordController, isPassword: true),
        buildGreyText("Confirm Password"),
        buildInputField(confirmpasswordController, isPassword: true),
        const SizedBox(height: 30),
        buildsignupButton(),
        const SizedBox(height: 20),
        buildlogin(),
      ],
    );
  }

  Widget buildAnimatedsingup() {
    return Stack(
      children: [
        AnimatedPositioned(
          bottom: showForm ? 0 : -mediasize.height,
          duration: const Duration(seconds: 1),
          child: buildbottom(),
        ),
        AnimatedPositioned(
          bottom: !showForm ? 0 : -mediasize.height,
          duration: const Duration(seconds: 1),
          child: buildbottom2(),
        )
      ],
    );
  }

  void signup(String email, String password) async {
    User? user = await _auth.signUpWithEmailAndPassword(email, password);
    if (user != null) {
      setState(() {
        isLoading = false;
      });
      showToast("Account Created Successfully");
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const home()));
      toggle_form();
      clear();
    }
    else {
      setState(() {
        isLoading = false;
      });
      clear();
      showToast("Process Failed!");
    }
  }

  void checkSignup() {
    String email = emailController.text;
    String password = passwordController.text;
    String confirmPw = confirmpasswordController.text;

    if (password == confirmPw && password != "" && confirmPw != "") {
      if (password.length >= 6) {
        setState(() {
          isLoading = true;
        });

        signup(email, password);
      } else {
        showToast("Please Enter Maximum 6 Characters For The Password!");
      }
    } else {
      showToast(
          "Please Check The Both Passwords Are Equal and Passwords Are Cannot Be Null!");
    }
  }

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

  void clear() {
    emailController.text = "";
    passwordController.text = "";
    confirmpasswordController.text = "";
  }

  void checksignin() {
    String email = emailController.text;
    String password = passwordController.text;

    if (email != "" && password != "") {
      setState(() {
        isLoading = true;
      });
      signin(email, password);
    }
    else {
      setState(() {
        isLoading = false;
      });
      showToast("User error");
    }
  }

  Widget buildGoogle() {
    return GestureDetector(
      onTap: () {
        connectGoogle();
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 35,
            height: 35,
            child: Image.asset("assets/images/2.png"),
          ),
        ],
      ),
    );
  }

  void connectGoogle() async {
    try {
      GoogleSignInAccount? googleuser = await GoogleSignIn().signIn();
      GoogleSignInAuthentication? googleAuth = await googleuser?.authentication;

      AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth?.accessToken,
          idToken: googleAuth?.idToken);
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithCredential(credential);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const home()));
    } catch (e) {
      print(e.toString() + " error");
    }
  }

  void signin(String email, String password) async {
    User? user = await _auth.signInWithEmailAndPassword(email, password);
    if (user != null) {
      setState(() {
        isLoading = false;
      });
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const home()));
      toggle_form();
      clear();
    }
    else {
      setState(() {
        isLoading = false;
      });
      clear();
      showToast("Login Failed!");
    }
  }
}
