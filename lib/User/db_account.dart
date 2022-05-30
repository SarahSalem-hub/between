

import 'package:between/User/db_imageUploading.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class db_account{


  var userObject;
  CollectionReference usersColl = FirebaseFirestore.instance.collection("Users");


  Future<void> updateAccount (String filePath,String uid, String name,String bio ,String number)async {
    String imagePath;

    if(filePath != "null") {
      imagePath = await db_imageUpload().uploadImage(filePath);
    }
    else
      imagePath = "UsersProfile/user.png";

    try {

      userObject ={
        "Uid":uid,
        'UserName':name,
        "UserNumber":number,
        'UserBio':bio,
        "ProfilePath":imagePath
      };


      usersColl.add(userObject);
    }
    catch(e){
      print(e);
    }
  }
}