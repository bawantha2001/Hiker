import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class guide extends StatefulWidget {
  String placeId;
  guide({super.key, required this.placeId});
  @override
  State<guide> createState() => _guideState(placeId);
}

class _guideState extends State<guide> {
  String placeid;
  _guideState(this.placeid);

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
    // TODO: implement initState
    super.initState();
    initializedBannerAD();
  }

  final _firestore = FirebaseFirestore.instance;
  late Size mediasize=MediaQuery.of(context).size;

  Future<List<Widget>> fetchData() async {
    QuerySnapshot snapshot = await _firestore.collection('places/'+placeid+'/Guides').get();
    List<Widget> items = [];

    for (var document in snapshot.docs) {
      String itemName = document['Name'];
      String imageUrl = document['image_url'];

      items.add(
        Column(
          children: [
            Container(
              height: 80,
              width: mediasize.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  width: 1,
                  color: Colors.blue,
                ),
              ),
              child: Center(
                child: ListTile(
                  title: Text(
                    itemName,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      imageUrl,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            )
          ],
        ),
      );
    }
    return items;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Scaffold(
        body: Container(
          width: mediasize.width,
          height: mediasize.height,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/p.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  isBannerloaded==true?SizedBox(
                      height: 50,
                      child: AdWidget(ad: bannerAd)):SizedBox(),
                  Expanded(
                    child: FutureBuilder(
                      future: fetchData(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return  const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircularProgressIndicator(
                                color: Colors.white,
                              ),
                              Text("Loading Data ...",
                                  style: TextStyle(fontSize:15, fontWeight: FontWeight.bold,color: Colors.white)),
                            ],
                          );
                        }

                        else{
                          List<Widget> items = snapshot.data as List<Widget>;
                          if(items.isEmpty){
                            return  Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  "Available Guides",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                      height: mediasize.height,
                                      width: mediasize.width,
                                      child: const Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Icon(Icons.error_sharp,color: Colors.red,size: 50),
                                          Text("No available guides found",
                                              style: TextStyle(fontSize:15, fontWeight: FontWeight.bold,color: Colors.white)),
                                        ],
                                      )),
                                ),
                              ],
                            );
                          }
                          else{
                            return Column(
                              children: [
                                const Text(
                                  "Available Guides",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    height: mediasize.height,
                                    width: mediasize.width,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(
                                        width: 1,
                                        color: Colors.transparent,
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: ListView(
                                        children: items,
                                      ),

                                    ),
                                  ),
                                ),
                              ],
                            );
                          }
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
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


