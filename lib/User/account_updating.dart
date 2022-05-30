

import 'dart:io';

import 'package:between/User/db_account.dart';
import 'package:between/User/db_user.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';

class accountUpdating extends StatefulWidget {
  const accountUpdating({Key? key}) : super(key: key);

  @override
  _accountUpdatingState createState() => _accountUpdatingState();
}

class _accountUpdatingState extends State<accountUpdating> {
  final TextEditingController userNumber = TextEditingController();
  final TextEditingController userName = TextEditingController();
  final TextEditingController userBio = TextEditingController();

  final detailsForm = GlobalKey<FormState>();
    var path;
    var fileName;

  var uid =  Get.arguments["uid"];
  // late PickedFile  imageFile ;
  final ImagePicker picker= ImagePicker();
  var im;


  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    return Scaffold(
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              
              Text(user.uid.toString()),

              const SizedBox(
                height: 90,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text("Complete your Account details ! ",
                      style: TextStyle(
                          fontWeight: FontWeight.w400, fontSize: 17)),
                ],
              ),
              Container(
                padding: const EdgeInsets.all(45),
                child: Form(
                  key: detailsForm,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [

                          Stack(
                           children:[
                            CircleAvatar(

                              radius: 50,
                              backgroundColor: Colors.white,
                              backgroundImage:  im == null ? AssetImage("assets/images/user.png") : FileImage(File(im.path)) as ImageProvider ,
                            ),
                             Positioned(

                                 child:
                                 InkWell(
                                   onTap: (){
                                     takePhoto(ImageSource.gallery);
                                   },
                                     child: Icon(Icons.photo_camera_rounded,color: Colors.teal,)))
                      ]
                          ),

                          TextFormField(
                            controller: userName,
                            decoration: const InputDecoration(
                              labelText: 'Enter Name',
                              contentPadding: EdgeInsets.only(
                                  top: 10, left: 20, bottom: 10),
                            ),

                            validator: (String? value) {
                              if (value!.isEmpty) {
                                return 'Please enter your Name';
                              }
                              return null;
                            },
                          ),
                          TextFormField(
                            controller: userBio,
                            decoration: const InputDecoration(
                              labelText: 'Enter your Bio ',
                              contentPadding: EdgeInsets.only(
                                  top: 10, left: 20, bottom: 10),
                            ),

                          ),
                          TextFormField(
                            controller: userNumber,
                            decoration: const InputDecoration(
                              labelText: 'Contact Number',

                              contentPadding: EdgeInsets.only(
                                  top: 10, left: 20, bottom: 10),
                            ),

                          ),

                        ],
                      ),
                    )),
              ),
              Container(
                width: 330,
                height: 40,
                child: RaisedButton(
                  color: Colors.black,
                  onPressed: () async {

                    if (detailsForm.currentState!.validate()) {
                     // print(imageFile.path);
                     // db_user().uploadImage(filePath, fileName)
                      print("pattttthh");
                      print(path);
                      if (path != null)
                     {
                       await db_account().updateAccount(path, uid, userName.text, userBio.text, userNumber.text);
                       //Get.toNamed("/page1Home");
                     }
                      else
                        {
                          await db_account().updateAccount("null", uid, userName.text, userBio.text, userNumber.text);
                          Get.toNamed("/home");
                        }
                    }

                  },
                  child: const Text(
                    "Sign Up",
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ),
              Divider(height: 100,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/images/Black_Logo.png",
                    width: 40,
                    height: 40,
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Between",
                style: TextStyle(
                    fontWeight: FontWeight.w700, fontSize: 10),
              ),
            ],
          ),
        ),
      ),
    );
  }
    Future<void> takePhoto (ImageSource source) async {
      final pickedFile = await picker.pickImage(source: source);

       path = pickedFile?.path;
       print("path is ");
       print(path);
       //fileName = image.files.single.name;

      setState(() {
        im = pickedFile!;
      });
    }
}
