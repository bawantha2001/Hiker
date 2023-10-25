
import 'package:cloud_firestore/cloud_firestore.dart';

class userModel {
  final String? id;
  final String name;
  final String info;


  const userModel({
    this.id,
    required this.name,
    required this.info
  });

  toJson() {
    return {"Name": name,
      "Info": info
    };
  }

  factory userModel.fromSnapshot(DocumentSnapshot<Map<String,dynamic>> document){
    final data=document.data()!;
    return userModel(
      id:document.id,
        name: data["name"],
        info: data["info"]);
  }
}