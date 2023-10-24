import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class place extends StatefulWidget {
  const place({super.key});

  @override
  State<place> createState() => _placeState();
}

class _placeState extends State<place> {

  late Size mediasize;
  late Color myColor;

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
      body: Center(
        child: Stack(
          children: [
          Positioned(top: 0,
              left: 50,
              height: 280,
              width: 280,
              child: buildtop()),
          Positioned(
              bottom: 0,
              height: 550,
              child: buildbottom())
        ],
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
            padding: EdgeInsets.all(20.0),
            child: Column(
              children: [
                Container(
                  child: Image.asset('assets/images/sigiriya.jpg')
                ),
                const SizedBox(height: 20),
                const Text("TITLE",
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w500
                  ),
                ),
                const SizedBox(height: 20),
                const Text("Bla BlaBla Bla Bla Bla Bla Bla Bla BlaBla BlaBla BlaBla Bla Bla Bla "
                    "Bla BlaBla Bla Bla Bla Bla Bla Bla BlaBla BlaBla BlaBla Bla Bla Bla "
                    "Bla BlaBla Bla Bla Bla Bla Bla Bla BlaBla BlaBla BlaBla Bla Bla Bla "
                    "Bla BlaBla Bla Bla Bla Bla Bla Bla BlaBla BlaBla BlaBla Bla Bla Bla ",
                  textAlign: TextAlign.justify,)
              ],
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
  
}
