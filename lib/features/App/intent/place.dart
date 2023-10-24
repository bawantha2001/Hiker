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
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/6.jpg"),
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
    );
  }

  Widget buildbottom() {
    return SizedBox(
      width: mediasize.width,
      height: 600,
      child:
      Opacity(
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
            padding: EdgeInsets.all(10.0),
            child: Column(
              children: [
                Container(
                  width: 330,
                  margin: EdgeInsets.all(10),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child:
                      Image.asset('assets/images/6.jpg')
                    ),
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
