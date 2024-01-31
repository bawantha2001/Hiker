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
  Set<Marker> autoMarkers = {};

  @override
  void initState() {
    super.initState();
    fetchAutoMarkersFromFirestore();// Call super.initState() first
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
          padding: const EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 5.0,),
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
          Icon(Icons.hiking_rounded,color: Color(0xFF5b7cff),size: 30,),
          SizedBox(width: 2,),
          Text(
          "Hiker",
          style: TextStyle(
          color: Color(0xFF5b7cff),
          fontSize: 25.0,
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
            style: const TextStyle(
            color: Colors.black, fontWeight: FontWeight.bold),
            decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            ),
            hintText: "Ex:Sigiriya ",
            prefixIcon: const Icon(Icons.search),
            prefixIconColor: Colors.black),
            ),
          ),

          const Padding(
          padding: EdgeInsets.fromLTRB(0,20,0,0),
          child: Center(
          child: Text("Best hiking routes in Sri Lanka.",
          style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20.0,
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
          SizedBox(
          height: 260,
            child: handleCard(context),
          ),
          ],
          );
          }
          ),
          SizedBox(
            height: 20,
          ),

          SizedBox(
          height: mediasize.height,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16.0),
            child: GoogleMap(
              myLocationButtonEnabled: true,
              rotateGesturesEnabled: true,
              trafficEnabled:true,
              compassEnabled: true,
              initialCameraPosition: const CameraPosition(
                target: LatLng(7.8731, 80.7718),
                zoom: 8,
            ),
            markers: autoMarkers,
            ),
          ),
          )
          ],
          ),
          ),
          );
  }

  Future<void> fetchAutoMarkersFromFirestore() async {
    try {
      List<Map<String, dynamic>> userData = await fetchlatlngDataFromFirestore();
      for (int index=0;index<userData.length;index++) {
        double latitude =  double.parse(userData[index]['lat']);
        double longitude = double.parse(userData[index]['long']);
        String title = userData[index]['placeName'];

        setState(() {
          autoMarkers.add(
            Marker(
              markerId: MarkerId(title),
              position: LatLng(latitude, longitude),
              icon: BitmapDescriptor.defaultMarker,
              infoWindow: InfoWindow(
                title: title,
                snippet: userData[index]['location'],
              ),
            ),
          );
        });
      }

      // Trigger a rebuild to update the markers on the map
    } catch (e) {
      print('Error fetching data: $e');
      showToast("$e");
    }
  }

  Widget handleCard(BuildContext context){
    return FutureBuilder(future: fetchDataFromFirestore(),
        builder: (context,snapshots){
      if(snapshots.connectionState==ConnectionState.waiting){
        return const Column(
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
        return const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.network_check,color: Colors.white,size: 40,),
            SizedBox(height: 7,),
            Text("Network error",
                style: TextStyle(fontSize:15, fontWeight: FontWeight.bold,color: Colors.white)),
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
                      build_card(userdata?[index]['placeName'], userdata?[index]['location'], userdata?[index]['placeImage'],userdata?[index]['info'],userdata?[index]['retrievedplaceIds'],userdata?[index]['maplink']);
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
          title: const Text('Log out'),
          content: const Text('Do you want to log out'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                _signOut(context);
              },
              child: const Text('Yes'),
            ),
          ],
        );
      },
    );
  }


  Future<void> _signOut(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut().then((value) => Navigator.push(
          context, MaterialPageRoute(builder: (context) => Login())));
      Navigator.pop(context);
    } catch (e) {
      print('Error signing out: $e');
      showToast("message");
    }
  }

}

class build_card extends StatefulWidget{
  final String placeName;
  final String locationName;
  final String imageName;
  final String info;
  final String placeId;
  final String maplink;

  const build_card(this.placeName,this.locationName,this.imageName,this.info,this.placeId,this.maplink,{super.key});

  @override
  State<build_card> createState() => _build_cardState();
}

class _build_cardState extends State<build_card> {
  @override
  Widget build(BuildContext context){
    return
      Opacity(
        opacity: 0.75,
        child: Container(
        margin: const EdgeInsets.fromLTRB(5,0,5,0),
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
                      child: Wrap(
                        children: [
                          Image.network(
                            widget.imageName,
                            fit: BoxFit.fill,
                            height: 130,
                            errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                              return const SizedBox(
                                height: 130,
                                child: Icon(
                                  Icons.error,
                                  size: 40,
                                  color: Colors.red,
                                ),
                              ); // Display an error icon on image load failure.
                            },
                            loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                              if (loadingProgress == null) {
                                return child; // Image is fully loaded, show it.
                              } else {
                                return const SizedBox(
                                    height: 130,
                                    width: 50,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        CircularProgressIndicator(backgroundColor: Colors.transparent,color: Colors.black,),
                                      ],
                                    )); // Display a loading indicator.
                              }
                            },
                          ),
                        ],
                      ))),
              const SizedBox(
                height: 4,
              ),

              Wrap(
                children: [
                  Text(
                    widget.placeName,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(
                height: 4,
              ),
              Wrap(
                children: [
                  Row(
                    children: [
                      const Icon(Icons.location_on),
                      Text(
                        widget.locationName,
                        style: const TextStyle(fontSize: 13),
                      ),
                    ],
                  ),
                ],
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) =>place(placeName: widget.placeName, image: widget.imageName, info: widget.info,placeId: widget.placeId,maplink: widget.maplink)));
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
  } on Exception {
    showToast("Network Errror2");
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
      'info':doc['info'],
      'maplink':doc['maplink'],
    }).toList();
    return userData;
  } on Exception {
    showToast("Network Error2");
    rethrow;
  }
}

Future<List<Map<String, dynamic>>> getlatlngDataFromFirestore(List<String> documentIds) async{
  try {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    QuerySnapshot querySnapshot=await firestore.collection('places')
        .where(FieldPath.documentId,whereIn: documentIds).get();

    List<Map<String,dynamic>> userData=querySnapshot.docs
        .map((doc) => {
      'lat':doc['lat'],
      'long':doc['long'],
      'placeName':doc['name'],
      'location':doc['location'],
    }).toList();
    return userData;
  } on Exception {
    showToast("Network Error2");
    rethrow;
  }
}

Future<List<Map<String, dynamic>>> fetchDataFromFirestore() async {
  try {
    List<String> documentIds = await getDocumentIDs();
    return await getDataFromFirestore(documentIds);
  } catch (e) {
    print('Error fetching data: $e');
    rethrow;// Return an empty list or handle accordingly
  }
}

Future<List<Map<String, dynamic>>> fetchlatlngDataFromFirestore() async {
  try {
    List<String> documentIds = await getDocumentIDs();
    return await getlatlngDataFromFirestore(documentIds);
  } catch (e) {
    print('Error fetching data: $e');
    rethrow;// Return an empty list or handle accordingly
  }
}



