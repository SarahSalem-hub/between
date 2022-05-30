import 'package:between/User/db_user.dart';
import 'package:between/User/sign_up.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class loginPage extends StatefulWidget {
  const loginPage({Key? key}) : super(key: key);

  @override
  _loginPageState createState() => _loginPageState();
}

class _loginPageState extends State<loginPage> {

  final formKey = GlobalKey<FormState>();
  final TextEditingController loginEmail = TextEditingController();
  final TextEditingController loginpass = TextEditingController();
  
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
                            Text("Log in  !",
                                style: TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 17,
                                )),
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                          controller: loginEmail,
                          decoration: const InputDecoration(

                            labelText: 'Email',

                            contentPadding: EdgeInsets.only(
                                top: 10, left: 20, bottom: 10),

                          ),

                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return 'Please enter your Email';
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          controller: loginpass,
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
                              var validate = await db_user().login(loginEmail.text.trim(), loginpass.text.trim());
                             //   print(validate.toString());
                              }

                            },
                            child: const Text(
                              "Log in ",
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),

                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        RichText(
                            text: TextSpan(
                                text: 'Want to Create Account? ',
                            style:  TextStyle(
                                color: Colors.black
                            ),

                            children: [
                              TextSpan(
                                recognizer: TapGestureRecognizer()..onTap = () =>
                                {
                                  Navigator.push(context, MaterialPageRoute(
                                      builder: (context) => userSignUp()),
                                  ),
                                },
                                text: 'Sign up',
                                style: TextStyle(
                                  color: Colors.black,
                                  decoration: TextDecoration.underline,
                                )
                              ),

                            ])),
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
