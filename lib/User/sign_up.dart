import 'package:between/User/db_user.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class userSignUp extends StatefulWidget {
  const userSignUp({Key? key}) : super(key: key);

  @override
  _userSignUpState createState() => _userSignUpState();
}

class _userSignUpState extends State<userSignUp> {

  final formKey = GlobalKey<FormState>();
  final TextEditingController userEmail = TextEditingController();
  final TextEditingController userpass = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(45),
                child: Form(

                  key: formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Image.asset(
                          "assets/images/Black_Logo.png",
                          width: 70,
                          height: 70,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        const Text(
                          "Between",
                          style: TextStyle(
                              fontWeight: FontWeight.w700, fontSize: 20),
                        ),
                        const SizedBox(
                          height: 90,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text("Create yout Account",
                                style: TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 17)),
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                          controller: userEmail,
                          decoration: const InputDecoration(

                            labelText: 'Email',

                            contentPadding: EdgeInsets.only(
                                top: 10, left: 20, bottom: 10),

                          ),

                          validator: (String? value) {
                           return EmailValidator.validate(value!)
                                ?  null
                                :    "Please enter a valid email" ;
                          },
                        ),
                        TextFormField(
                          controller: userpass,
                          decoration: const InputDecoration(
                            labelText: 'Password',

                            contentPadding: EdgeInsets.only(
                                top: 10, left: 20, bottom: 10),

                          ),

                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return 'Please enter your Password';
                            }
                            return null;
                          },
                        ),



                        const SizedBox(
                          height: 35,
                        ),

                        Container(
                          width: 330,
                          height: 40,
                          child: RaisedButton(
                            color: Colors.black,
                            onPressed: () async {

                            if (formKey.currentState!.validate()) {
                             var messHere=  await db_user().addUser( userEmail.text.trim(), userpass.text.trim());
                            if (messHere != null)
                              {
                                Fluttertoast.showToast(msg: messHere);
                              }
                               //Get.toNamed("/account_updating");

                            }

                            },
                            child: const Text(
                              "Sign Up",
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        Divider()
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
