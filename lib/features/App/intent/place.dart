import 'package:flutter/material.dart';
import 'package:self_employer/features/App/login/home.dart';

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

    return WillPopScope(
      onWillPop: () async{
        Navigator.pop(context);
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const home()));
        return true;
      },
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/sigiriya.jpg"),
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
                        Image.asset('assets/images/sigiriya.jpg')
                      ),
                    ),
                  const SizedBox(height: 20),
                  const Text("SIGIRIYA",
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w500
                    )
                  ),
                  const SizedBox(height: 20),
                  const Text("Sigiriya Lion Rock is an ancient rock fortress known for its massive "
                      "column of rock that reaches nearly 200 meters high. The site dates back "
                      "to the reign of King Kasyapa (477-495 AD), who chose this site as his new capital. "
                      "He decorated the walls with frescoes, and built an impressive palace right on "
                      "top of the rock column, accessible only through the mouth of an enormous carved lion.",
                    textAlign: TextAlign.justify,
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w400
                  ),
                  ),
                  const SizedBox(height: 20),
                  const Text("Reservation Places", style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500
                  ),
                  ),
                  const SizedBox(height: 20),
                  const TextButton(onPressed: null,
                      child: Text("Place 01", style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500
                      ),
                      ),
                  ),
                  const TextButton(onPressed: null,
                    child: Text("Place 02", style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500
                    ),
                    ),
                  ),
                  const TextButton(onPressed: null,
                    child: Text("Place 03", style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500
                    ),
                    ),
                  ),
                  const TextButton(onPressed: null,
                    child: Text("Place 04", style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500
                    ),
                    ),
                  ),
                  const TextButton(onPressed: null,
                    child: Text("Place 05", style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500
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


  
}
