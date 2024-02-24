import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:self_employer/features/App/intent/place.dart';

class home extends StatefulWidget {
  const home({super.key});

  @override
  State<home> createState() => _State();

}

class _State extends State<home> {

  late Size mediasize=MediaQuery.of(context).size;
  bool issignout = false;
  Set<Marker> autoMarkers = {};
  List<Map<String, dynamic>> filteredCardData = [];
  List<Map<String, dynamic>> userData = [];
  String searchText = '';
  bool isBannerloaded=false;
  late BannerAd bannerAd;

  initializedBannerAD()async{
    bannerAd = BannerAd(size: AdSize.banner,
        adUnitId: 'ca-app-pub-8280404068654201/4880902330',
        listener: BannerAdListener(
          onAdLoaded: (ad){
            setState(() {
              isBannerloaded=true;
            });
          },
          onAdFailedToLoad: (ad,error){
            ad.dispose();
            isBannerloaded=false;
            print(error);
        }
        ),
        request: AdRequest());

    bannerAd.load();
  }

  @override
  void initState() {
    super.initState();
    initializedBannerAD();
    fetchAutoMarkersFromFirestore();
    fetchDataFromFirestore().then((data) {
      setState(() {
        userData = data;
        filteredCardData = data;
      });
    });
    // Call super.initState() first
    // Call your function directly
    // TODO: implement initState
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            SizedBox(
              height:50,
              child: isBannerloaded==true?AdWidget(ad: bannerAd):SizedBox(),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 50,
                      height: 50,
                      child: Image.asset("assets/images/10.png"),
                    ),
                    const SizedBox(width: 2,),
                    const Opacity(
                      opacity: 0.8,
                      child: Text("SL Hiker",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 25.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

          Opacity(
            opacity: 0.8,
            child: TextField(
              onChanged: (text) {
                filterCards(text);
              },
              style: const TextStyle(
                  color: Colors.black, fontWeight: FontWeight.bold),
              decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              ),
              hintText: "Search",
              prefixIcon: const Icon(Icons.search),
              prefixIconColor: Colors.black),
              ),
          ),

          const Padding(
          padding: EdgeInsets.fromLTRB(0,20,0,0),
          child: Center(
          child: Opacity(
            opacity: 0.8,
            child: Text("Best hiking routes in Sri Lanka",
            style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20.0,
            color: Colors.white,
            )),
          ),
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

            const SizedBox(
              height: 20,
            ),

            SizedBox(
            height: mediasize.height,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16.0),
              child: InteractiveViewer(
                maxScale: 5.0,
                child: GoogleMap(
                  myLocationButtonEnabled: true,
                  rotateGesturesEnabled: true,
                  trafficEnabled:true,
                  compassEnabled: true,
                  zoomGesturesEnabled: true,
                  zoomControlsEnabled: false,
                  scrollGesturesEnabled: true,
                  initialCameraPosition: const CameraPosition(
                    target: LatLng(7.8731, 80.7718),
                    zoom: 8,
                ),
                markers: autoMarkers,
                ),
              ),
            ),
            )
          ],
          ),
          ),
          );
  }

  void filterCards(String searchText) {

    setState(() {
      filteredCardData = userData.where((card) =>
          card['placeName'].toLowerCase().contains(searchText.toLowerCase()))
          .toList();
    });
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
              Opacity(
                opacity: 0.8,
                child: CircularProgressIndicator(color: Colors.white,
                ),
              ),
              SizedBox(height: 7),
              Opacity(
                opacity: 0.8,
                child: Text("Loading Data ...",
                style: TextStyle(fontSize:15, fontWeight: FontWeight.bold,color: Colors.white)),
              ),
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
        if(filteredCardData.isEmpty){
          return
              const Center(
                child: SizedBox(
                  height: 130,
                  child: Column(
                    children: [
                      Icon(Icons.location_off_outlined,color: Colors.red,size: 60),
                      Opacity(
                        opacity: 0.8,
                        child: Text("Unable to findour search location.",
                            style: TextStyle(fontSize:15, fontWeight: FontWeight.bold,color: Colors.white)),
                      ),
                    ],
                  ),
                ),
              );
        }
        else{
          return ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: filteredCardData?.length,
              itemBuilder: (context,index){
                return StreamBuilder<Object>(
                    stream: null,
                    builder: (context, snapshot) {
                      return
                        build_card(
                          filteredCardData[index]['placeName'],
                          filteredCardData[index]['location'],
                          filteredCardData[index]['placeImage'],
                          filteredCardData[index]['info'],
                          filteredCardData[index]['retrievedplaceIds'],
                          filteredCardData[index]['maplink'],
                        );
                    }
                );
              });
        }
          }
            });
  }


}

class build_card extends StatelessWidget{
  final String placeName;
  final String locationName;
  final String imageName;
  final String info;
  final String placeId;
  final String maplink;

  const build_card(this.placeName,this.locationName,this.imageName,this.info,this.placeId,this.maplink,{super.key});

  @override
  Widget build(BuildContext context){
    return
      Opacity(
        opacity: 0.8,
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
                            imageName,
                            fit: BoxFit.fill,
                            height: 130,
                            width: 200,
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
                    placeName,
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
                        locationName,
                        style: const TextStyle(fontSize: 13),
                      ),
                    ],
                  ),
                ],
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) =>place(placeName: placeName, image: imageName, info: info,placeId: placeId,maplink: maplink)));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black54,
                ),
                child: const Text(
                  'Read More',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
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



