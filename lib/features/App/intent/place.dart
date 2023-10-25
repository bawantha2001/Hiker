import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:self_employer/features/App/login/home.dart';

class place extends StatefulWidget {

  String placeName;
  place({required this.placeName});
  @override
  State<place> createState() => _placeState(placeName);
}

class _placeState extends State<place> {

  String info="";
  String accomadationName="";
  String placeName;
  String imagename="";
  _placeState(this.placeName);
  late Size mediasize;
  late Color myColor;
  bool showForm = true;
  final _db=FirebaseFirestore.instance;
  late Future<List<String>> documentIds;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(placeName=="Sigiriya"){
      imagename="sigiriya.jpg";
    }
    else if(placeName=="Watadage"){
      imagename="watadage.jpg";
    }
    else if(placeName=="Temple of the Tooth"){
      imagename="templeof.jpg";
    }
    getNameFromFirestore();
    getaccomNameFromFirestore();
  }

  void toggle_form() {
    setState(() {
      showForm = !showForm;
    });


  }

  Future<void> getNameFromFirestore() async {
    final DocumentReference documentReference =
    FirebaseFirestore.instance.collection("places").doc(placeName);

    try {
      DocumentSnapshot documentSnapshot = await documentReference.get();
      if (documentSnapshot.exists) {
        final data = documentSnapshot.data() as Map<String, dynamic>?;

        if (data != null && data.containsKey("info")) {
           setState(() {
             info = data['info'] as String;
           });
        } else {
          print("'info' key not found in the document");
        }

      } else {
        print("Document does not exist");
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  Future<void> getaccomNameFromFirestore() async {
    final DocumentReference documentReference =
    FirebaseFirestore.instance.collection("places").doc(placeName);

    try {
      DocumentSnapshot documentSnapshot = await documentReference.get();
      if (documentSnapshot.exists) {
        final data = documentSnapshot.data() as Map<String, dynamic>?;

        if (data != null && data.containsKey("accom")) {
          setState(() {
            accomadationName = data['accom'] as String;
          });
        } else {
          print("'info' key not found in the document");
        }

      } else {
        print("Document does not exist");
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    myColor = Theme
        .of(context)
        .primaryColor;
    mediasize = MediaQuery
        .of(context)
        .size;

    return WillPopScope(
      onWillPop: () async{
        Navigator.pop(context);
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const home()));
        return true;
      },
      child: Scaffold(
        body: Container(
          decoration:  BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/"+imagename),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            children: [
              const SizedBox(height: 250,),
              buildbottom(),
            ],
          )
           /* add child content here */,
        ),
      ),
    );
  }

  Widget buildbottom() {
    return SizedBox(
      width: mediasize.width,
      height: mediasize.height-250,
      child: Opacity(
        opacity: 1,
        child: Card(
          color: Color(0xFFffffff),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              )
          ),
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 330,
                    margin: EdgeInsets.all(10),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child:
                        Image.asset("assets/images/"+imagename)
                      ),
                    ),
                  const SizedBox(height: 20),
                   Text(placeName,
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w500
                    )
                  ),
                  const SizedBox(height: 20),
                  Text(info,
                    textAlign: TextAlign.justify,
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w400
                  ),
                  ),
                  const SizedBox(height: 20),
                  Text("Accomodation Places nearby "+placeName, style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    color: Colors.green,
                  ),
                  ),
                   TextButton(onPressed: null,
                      child: Text(accomadationName, style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                      ),
                  ),
                ],
              ),
            )
          ),
        ),
      ),
    );
  }

  Widget imgCard() {
    return const SizedBox(
      width: 100,
      height: 50,
      child: Text("data")
    );
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



}
