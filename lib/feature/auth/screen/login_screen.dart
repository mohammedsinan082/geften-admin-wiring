import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gefmartwiringadmin/feature/home/home_page.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/constants/Appcolor.dart';
import '../../../main.dart';
import '../controller/auth_controller.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  bool masking=true;


  Future<void> adminLogin(String email, String password, BuildContext context) async {
    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection("admin")
          .where('email', isEqualTo: email)
          .where('password', isEqualTo: password)
          .get();

      if (snapshot.docs.isNotEmpty) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const HomePage()),
              (route) => false,
        );
      } else {
        _showAlertDialog(context, "Invalid Email/Password");
      }
    } on FirebaseException catch (e) {
      _showAlertDialog(context, e.message ?? "An error occurred");
    } catch (e) {
      _showAlertDialog(context, e.toString());
    }
  }

  void _showAlertDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            "ALERT !",
            style: GoogleFonts.ubuntu(
              fontWeight: FontWeight.w600,
              fontSize: 26,
              color: Color(0xff002859),
            ),
          ),
          content: Text(
            message,
            style: GoogleFonts.ubuntu(
              fontWeight: FontWeight.w400,
              fontSize: 17,
              color: Colors.black,
            ),
          ),
          actions: [
            TextButton(
              child: Text(
                "OK",
                style: GoogleFonts.ubuntu(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  color: Colors.blue,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }



  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: AppColors.grey200,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: h*0.65,
                  width: w*0.5,
                 // color: AppColors.black,
                  child: Container(
                    height: h*0.1,
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(18),
                      // image: DecorationImage(
                      //     image: AssetImage("assets/logo (2).svg"),
                      //     fit: BoxFit.cover),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          width: w * 0.075,  // width of the container
                          height: h * 0.15, // height of the container
                          decoration: BoxDecoration(
                            color: AppColors.black,
                            borderRadius: BorderRadius.circular(28),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.asset(
                              'assets/Geftenlogo.png',
                              fit: BoxFit.cover,  // adjust the image to cover the container
                            ),
                          ),
                        ),

                        Center(
                          child: Container(
                            child: Column(
                              children: [
                                SizedBox(height: 15),
                                Text(
                                  'Wiring App Admin',
                                  style: TextStyle(fontSize: w*0.015,color: AppColors.darkGreen),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Form(
                          key: _formkey,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              children: [
                                Container(
                                  width: w * 0.3,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                          blurRadius: 2,
                                          color: Colors.grey.shade300,
                                          offset: Offset(0, 1),
                                        ),
                                      ],
                                      borderRadius: BorderRadius.circular(15),
                                      border: Border.all(color: Colors.grey.shade300,)
                                  ),
                                  child: TextFormField(
                                    readOnly: false,
                                    autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                    // validator: (value) {
                                    //   if (value!.isEmpty) {
                                    //     return 'Please enter your email address';
                                    //   } else if (!RegExp(
                                    //       r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                    //       .hasMatch(value)) {
                                    //     return 'Please enter a valid email address';
                                    //   }
                                    //   return null;
                                    // },
                                    controller: email,
                                    decoration: InputDecoration(
                                        prefixIcon: Icon(
                                          Icons.email,
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(12))),

                                        enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(12))),
                                        hintText: "Email",
                                        fillColor: Colors.white,
                                        filled: true,
                                        border: InputBorder.none),
                                  ),
                                ),
                                SizedBox(
                                  height: h * 0.04,
                                ),
                                Center(
                                  child: Container(
                                    width: w * 0.3,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                            blurRadius: 3,
                                            color: Colors.grey.shade300,
                                            offset: Offset(0, 1),
                                          )
                                        ],
                                        borderRadius: BorderRadius.circular(15),
                                        border: Border.all(color: Colors.grey.shade300,)
                                    ),
                                    child:
                                        //  var masking=ref.watch(masking1);
                                     TextFormField(
                                            onTap: (){
                                           //   ref.read(masking1.notifier).update((state) => !state);
                                               masking=!masking;
                                                setState(() {

                                                });

                                            },
                                            obscureText: !masking,

                                            validator: (eee) {
                                              if (eee!.isEmpty) {
                                                return 'Please Enter Password';
                                              } else if (eee.length < 8) {
                                                return 'Please enter 8 characters';
                                              }
                                              return null;
                                            },
                                            autovalidateMode:
                                            AutovalidateMode.onUserInteraction,
                                            controller: password,
                                            decoration: InputDecoration(
                                                suffixIcon: Icon(masking?
                                                Icons.visibility:Icons.visibility_off),
                                                prefixIcon: Icon(
                                                  Icons.lock,
                                                ),
                                                enabledBorder: OutlineInputBorder(
                                                    borderRadius: BorderRadius.all(
                                                        Radius.circular(12))),
                                                hintText: "Password",
                                                filled: true,
                                                fillColor: Colors.white,
                                                border: InputBorder.none),
                                          )
                                  ),
                                ),
                                SizedBox(
                                  height: h * 0.05,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Center(
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.3,
                            height: MediaQuery.of(context).size.height * 0.05,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                            ),
                            child: TextButton(
                              onPressed: () async {
                                if (_formkey.currentState!.validate()) {
                                  ref.read(authControllerProvider.notifier).adminLogin(
                                    email: email.text.trim(),
                                    password: password.text.trim(),
                                    context: context,
                                    alertBox: (context, message) => showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: Text(
                                            "ALERT !",
                                            style: GoogleFonts.ubuntu(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 26,
                                              color: Color(0xff002859),
                                            ),
                                          ),
                                          content: Text(
                                            message,
                                            style: GoogleFonts.ubuntu(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 17,
                                              color: Colors.black,
                                            ),
                                          ),
                                          actions: [
                                            TextButton(
                                              child: Text(
                                                "OK",
                                                style: GoogleFonts.ubuntu(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 16,
                                                  color: Colors.blue,
                                                ),
                                              ),
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                            ),
                                          ],
                                        );
                                      },
                                    ),
                                  );
                                }
                              },
                              child: Text(
                                "Login",
                                style: TextStyle(fontSize: 16, color: Colors.white),
                              ),
                              style: TextButton.styleFrom(
                                backgroundColor: Colors.green.shade500,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                          ),
                        ),

                        SizedBox(
                          height: h * 0.04,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
