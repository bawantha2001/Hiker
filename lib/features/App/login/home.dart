
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:self_employer/features/App/intent/place.dart';
import 'package:self_employer/features/App/login/Login.dart';

class home extends StatefulWidget {
  const home({super.key});

  @override
  State<home> createState() => _State();

}

class _State extends State<home> {

  late Size mediasize=MediaQuery.of(context).size;
  bool issignout = false;

  @override
  void initState() {
    super.initState(); // Call super.initState() first
    // Call your function directly
    // TODO: implement initState
  }


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async{
        _showAlertDialog(context);
        return true;
      },
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/p.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: SafeArea(
            child: build_body(context),
          ),
        ),
      ),
    );
  }


  Widget build_body(BuildContext context){
      return
        Padding(
          padding: EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 5.0,),
          child: SingleChildScrollView(
          child: Column(
          children: [
          Center(
          child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          const Padding(
          padding: EdgeInsets.all(8.0),
          child: Center(
          child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
          Icon(Icons.map,color: Color(0xFF5b7cff),size: 40,),
          Text(
          "Traveler",
          style: TextStyle(
          color: Color(0xFF5b7cff),
          fontSize: 38.0,
          fontWeight: FontWeight.bold,
          ),
          ),
          ],
          ),
          ),
          ),

          Opacity(
            opacity: 0.7,
            child: TextField(
            style: TextStyle(
            color: Colors.black, fontWeight: FontWeight.bold),
            decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            ),
            hintText: "Ex:Sigiriya ",
            prefixIcon: Icon(Icons.search),
            prefixIconColor: Colors.black),
            ),
          ),

          const Padding(
          padding: EdgeInsets.fromLTRB(0,20,0,0),
          child: Center(
          child: Text("Places To Visit In Sri Lanka.",
          style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 25.0,
          color: Colors.green,
          )),
          ),
          ),
          ],
          )),

          LayoutBuilder(
          builder: (Context,constraints) {
          return Wrap(
          children: [
          Container(
          height: 260,
            child: handleCard(context),
          ),
          ],
          );
          }
          ),

          Container(
          margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
          child: Text(
          "Locations.",
          style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 25.0,
          color: Colors.green,
          ),
          ),
          ),

          Container(
          height: mediasize.height,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16.0),
            child: GoogleMap(
            initialCameraPosition: const CameraPosition(
            target: LatLng(7.8731, 80.7718),
            zoom: 9,
            ),
            markers: {
            const Marker(
            markerId: MarkerId("Temple Of the Tooth"),
            position: LatLng(7.293627, 80.641350),
            icon: BitmapDescriptor.defaultMarker,
            infoWindow: InfoWindow(
            title: 'Temple Of the Tooth',
            snippet: 'Kandy'),
            ),
            const Marker(
            markerId: MarkerId("Sigiriya"),
            position: LatLng(7.956944, 80.759720),
            icon: BitmapDescriptor.defaultMarker,
            infoWindow: InfoWindow(
            title: 'Sigiriya', snippet: 'Polonnaruwa'),
            ),
            const Marker(
            markerId: MarkerId("Watadageya"),
            position: LatLng(8.1561, 80.9962),
            icon: BitmapDescriptor.defaultMarker,
            infoWindow: InfoWindow(
            title: 'Watadageya',
            snippet: 'Polonnaruwa',
            ),
            )
            },
            ),
          ),
          )
          ],
          ),
          ),
          );
  }

  Widget handleCard(BuildContext context){
    return FutureBuilder(future: fetchDataFromFirestore(),
        builder: (context,snapshots){
      if(snapshots.connectionState==ConnectionState.waiting){
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
              CircularProgressIndicator(color: Colors.white,
              ),
              SizedBox(height: 7),
              Text("Loading Data ...",
              style: TextStyle(fontSize:15, fontWeight: FontWeight.bold,color: Colors.white)),
          ],
        );
      }
      else if(snapshots.hasError){
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.network_check,color: Colors.black,size: 40,),
            SizedBox(height: 7,),
            Text("Network error",
                style: TextStyle(fontSize:15, fontWeight: FontWeight.bold,)),
          ],
        );
      }
      else{
        List<Map<String, dynamic>>?userdata = snapshots.data;
        return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: userdata?.length,
            itemBuilder: (context,index){
              return StreamBuilder<Object>(
                  stream: null,
                  builder: (context, snapshot) {
                    return
                      build_card(userdata?[index]['placeName'], userdata?[index]['location'], userdata?[index]['placeImage'],userdata?[index]['info'],userdata?[index]['accomodation'],userdata?[index]['retrievedplaceIds']);
                  }
              );
            });
          }
            });
  }

  void _showAlertDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Log out'),
          content: Text('Do you want to log out'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                signOut();
                Navigator.pop(context);// Close the dialog
              },
              child: Text('Yes'),
            ),
          ],
        );
      },
    );
  }

  void signOut() async {
    await FirebaseAuth.instance.signOut().then((value) => Navigator.push(
        context, MaterialPageRoute(builder: (context) => Login())));
    Navigator.pop(context);
  }
}

class build_card extends StatelessWidget{
  final String placeName;
  final String locationName;
  final String imageName;
  final String info;
  final String accom;
  final String placeId;

  build_card(this.placeName,this.locationName,this.imageName,this.info,this.accom,this.placeId);

  Widget build(BuildContext context){
    late Size mediasize=MediaQuery.of(context).size;

    return
      Opacity(
        opacity: 0.75,
        child: Container(
        margin: EdgeInsets.fromLTRB(5,0,5,0),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.black)),

        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Center(
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        imageName,
                        fit: BoxFit.fill,
                        height: 130,
                        width: 180,
                      ))),
              SizedBox(
                height: 4,
              ),

              Text(
                placeName,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 4,
              ),
              Row(
                children: [
                  Icon(Icons.location_on),
                  Text(
                    locationName,
                    style: TextStyle(fontSize: 13),
                  ),
                ],
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) =>place(placeName: placeName, image: imageName, info: info,accom: accom,placeId: placeId,)));
                },
                child: const Text(
                  'Read More',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF5b7cff)),
                ),
              ),
            ],
          ),
        ),
        ),
      );
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

Future<List<String>> getDocumentIDs() async {
  try {
    CollectionReference collection = FirebaseFirestore.instance.collection('places');
    QuerySnapshot querySnapshot = await collection.get();
    List<String> documentIds =querySnapshot.docs.map((doc) => doc.id).toList();
    return documentIds;
  } on Exception catch (e) {
    showToast("Network Errror");
    rethrow;
  }
}

Future<List<Map<String, dynamic>>> getDataFromFirestore(List<String> documentIds) async{
  try {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    QuerySnapshot querySnapshot=await firestore.collection('places')
        .where(FieldPath.documentId,whereIn: documentIds).get();

    List<Map<String,dynamic>> userData=querySnapshot.docs
        .map((doc) => {
      'retrievedplaceIds':doc['placeId'],
      'placeName':doc['name'],
      'location':doc['location'],
      'placeImage':doc['image'],
      'accomodation':doc['accom'],
      'info':doc['info'],
    }).toList();
    return userData;
  } on Exception catch (e) {
    showToast("Network Error");
    throw e;
  }
}

Future<List<Map<String, dynamic>>> fetchDataFromFirestore() async {
  try {
    List<String> documentIds = await getDocumentIDs();
    return await getDataFromFirestore(documentIds);
  } catch (e) {
    print('Error fetching data: $e');
    throw e;// Return an empty list or handle accordingly
  }
}



