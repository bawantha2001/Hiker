import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:self_employer/features/App/login/home.dart';

class place extends StatefulWidget {

  String placeName;
  String image;
  String info;
  place({required this.placeName,required this.image,required this.info});
  @override
  State<place> createState() => _placeState(placeName,image,info);
}

class _placeState extends State<place> {

  String placeName;
  String image;
  String info;
  _placeState(this.placeName, this.image,this.info);

  late Size mediasize;
  late Color myColor;
  bool showForm = true;
  final _db=FirebaseFirestore.instance;
  late Future<List<String>> documentIds;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

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

    return WillPopScope(
      onWillPop: () async{
        Navigator.pop(context);
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => home()));
        return true;
      },
      child: Scaffold(
        body: Container(
          decoration:  BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(image),
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
                        Image.network(image),
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
                  Text("Accomodation Places Nearby "+placeName, style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    color: Colors.green,
                  ),
                  ),
                   TextButton(onPressed: null,
                      child: Text("accomadationName", style: TextStyle(
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
