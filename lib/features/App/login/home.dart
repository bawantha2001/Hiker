
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

  late Size mediasize;
  bool issignout = false;
  List<String> placeIds=[];
  List<String> retrievedplaceIds=[];
  List<String> placeName=[];
  List<String> location=[];
  List<String> placeImage=[];
  List<String> accomodation=[];
  List<String> info=[];

  @override
  void initState() {
    getDocumentIDs();
    super.initState(); // Call super.initState() first
    // Call your function directly
    // TODO: implement initState
  }


  Future<void> getDocumentIDs() async {
    CollectionReference collection = FirebaseFirestore.instance.collection('places');
    QuerySnapshot querySnapshot = await collection.get();

    if (querySnapshot.docs.isNotEmpty) {
      for (QueryDocumentSnapshot document in querySnapshot.docs) {
          placeIds.add(document.id);
          getDataFromFirestore(document.id);
      }
    } else {
      showToast('No documents found in the collection.');
    }
  }

  Future<void> getDataFromFirestore(String userId) async{
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference users = firestore.collection('places');
    DocumentReference userDoc = users.doc(userId); // Replace 'user_id' with the actual document ID

    userDoc.get().then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        Map<String, dynamic> data = documentSnapshot.data() as Map<String, dynamic>;
        setState(() {
          retrievedplaceIds.add(data['placeId']);
          placeName.add(data['name']); // Replace 'value1' with the actual field name
          location.add(data['location']);
          placeImage.add(data['image']);
          accomodation.add(data['accom']);
          info.add(data['info']);// Replace 'value2' with the actual field name
        });


      } else {
        // The document doesn't exist
        print('Document does not exist in Firestore.');
      }
    }).catchError((error) {
      print('Error getting document: $error');
    });
  }



  @override
  Widget build(BuildContext context) {
    mediasize = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async{
        _showAlertDialog(context);
        return true;
      },
      child: Scaffold(
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 40.0, 20.0, 0),
              child: Center(
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
                  TextField(
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
                  const Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Center(
                      child: Text("Most Visited Palces",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 22.0,
                            color: Colors.green,
                          )),
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                ],
              )),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(5.0, 0, 5.0, 0),
              child: Container(
                height: 250,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: placeIds.length,
                    itemBuilder: (context,index){
                    return StreamBuilder<Object>(
                      stream: null,
                      builder: (context, snapshot) {
                        return
                          build_card(placeName[index], location[index], placeImage[index],info[index],accomodation[index],retrievedplaceIds[index]);
                      }
                    );
                    }),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                child: const SizedBox(
                    child: Text(
                  "Place Nearby",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22.0,
                    color: Colors.green,
                  ),
                )),
              ),
            ),
            Container(
              width: mediasize.width,
              height: mediasize.height-532,
              decoration: const BoxDecoration(
                color: Colors.cyan,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                ),
              ),
              child: GoogleMap(
                initialCameraPosition: const CameraPosition(
                  target: LatLng(7.8731, 80.7718),
                  zoom: 8,
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
            )
          ],
        ),
      ),
    );
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
    return
      Container(
          width: 180,
          margin: EdgeInsets.fromLTRB(5,0,5,0),
          decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.black)),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
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
                      style: TextStyle(fontSize: 12),
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
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.green),
                  ),
                ),
              ],
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
