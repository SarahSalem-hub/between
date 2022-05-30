
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:get/get.dart';
import 'dart:io';
import 'package:path/path.dart' as p;

class db_imageUpload{



  final firebase_storage.FirebaseStorage storage =firebase_storage.FirebaseStorage.instance;

  Future<String> uploadImage(String filePath) async{
    File file = File(filePath);
    String basename = p.basename(file.path);


    try{
      print ("name is sss:");print (basename);
      var imagePath =  await storage.ref('UsersProfile/$basename').putFile(file);

      print ("image path");
      print(imagePath.ref.fullPath);
      return imagePath.ref.fullPath.toString();

    } on firebase_core.FirebaseException catch(e){
      print(e);
      return e.toString();
    }
  }

}