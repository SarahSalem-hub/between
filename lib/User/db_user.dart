
//import 'package:firebase_core/firebase_core.dart';

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_core/firebase_core.dart' as firebase_core;

class db_user{

  FirebaseAuth auth = FirebaseAuth.instance;
  var mess;
  Future<String> addUser(String email,String password ) async {


    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password,

      );
      print ("user");
      print(userCredential.user!.uid.toString());

      if(userCredential == null)
        {
          print("sth");
        }
      else
        {
          Get.toNamed("/account_updating",arguments: {"uid":userCredential.user!.uid.toString()});
        }


      // usersColl.add(userObject);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print(e.toString());
        mess = '( Weak Password ) The password should be at least 6 characters ';

      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
        mess = 'The account already exists for that email.';
      }
    } catch (e) {
      print(e);
    }

    return mess;

  }
  Future<void> login (String email, String pass) async {

    final  user = (await auth.signInWithEmailAndPassword(
    email: email,
    password:pass,
    )).user;

    if (user != null) {
      print ("not null");
      Get.toNamed("/home",arguments: {"userId":user.uid,"userEmail":user.email});
       // print (user.email);
    } else
      print("null");
      //return "Wrong Email or password";

  }

  Future<void> logOut () async {

    await auth.signOut();


  }


}
