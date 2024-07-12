import 'package:flutter/material.dart';
import 'package:gefmartwiringadmin/color/Appcolor.dart';
import 'package:gefmartwiringadmin/home_page.dart';

import 'main.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  bool masking=true;


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
                            borderRadius: BorderRadius.circular(12),
                            child: Image.asset(
                              'assets/Gefmartlogo1.png',
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
                            width: w * 0.3,
                            height: h * 0.050,
                            decoration: BoxDecoration(
                                color: Colors.green.shade500,
                                borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                            child: TextButton(
                                onPressed: () async {
                                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => HomePage(),),(route) => false,);
                                  // if (_formkey.currentState!.validate()) {
                                  //   ref.read(authControllerProvider.notifier).adminlogin(
                                  //     email: email.text.trim(),
                                  //     password: password.text.trim(),
                                  //     context: context,
                                  //     alertBox: (context) => showDialog(
                                  //       context: context,
                                  //       builder: (BuildContext context) {
                                  //         return AlertDialog(
                                  //           title: Text("ALERT !",style: GoogleFonts.ubuntu(
                                  //             fontWeight: FontWeight.w600,
                                  //             fontSize: 26,
                                  //             color: Color(0xff002859),
                                  //           ),),
                                  //
                                  //           content: Text(
                                  //             "No User details Exist ",style: GoogleFonts.ubuntu(
                                  //               fontWeight: FontWeight.w400,
                                  //               fontSize: 17,
                                  //               color: Colors.black
                                  //           ),),
                                  //           actions: [
                                  //             TextButton(
                                  //               child: Text("OK",style: GoogleFonts.ubuntu(
                                  //                   fontWeight: FontWeight.w600,
                                  //                   fontSize: 16,
                                  //                   color: Colors.blue
                                  //               ),),
                                  //               onPressed: () {
                                  //                 Navigator.of(context).pop();
                                  //               },
                                  //             ),
                                  //           ],
                                  //         );
                                  //       },
                                  //     ),
                                  //   );
                                  //   // await FirebaseFirestore.instance
                                  //   //     .collection("brands")
                                  //   //     .where('email', isEqualTo: email.text)
                                  //   //     .where('password', isEqualTo: password.text)
                                  //   //     .get()
                                  //   //     .then((snapshot) async {
                                  //   //   final brands = snapshot.docs;
                                  //   //   bool accountFound = false;
                                  //   //
                                  //   //   for (var brand in brands) {
                                  //   //     if (brand.get("email") == email.text &&
                                  //   //         brand.get("password") == password.text) {
                                  //   //       accountFound = true;
                                  //   //       currentBrand = brand.id;
                                  //   //       currentBrandName = brand.get('name');
                                  //   //       break;
                                  //   //     }
                                  //   //   }
                                  //   //
                                  //   //   if (accountFound) {
                                  //   //     final prefs = await SharedPreferences.getInstance();
                                  //   //     prefs.setString('userId', email.text);
                                  //   //     prefs.setString("password", password.text);
                                  //   //
                                  //   //     showUploadMessage(context, 'Login Successfull');
                                  //   //
                                  //   //
                                  //   //     Navigator.pushAndRemoveUntil(
                                  //   //       context,
                                  //   //       MaterialPageRoute(
                                  //   //         builder: (context) => Home(),
                                  //   //       ),
                                  //   //           (route) => false,
                                  //   //     );
                                  //   //   }
                                  //   //   else {
                                  //   //     showDialog(
                                  //   //       context: context,
                                  //   //       builder: (BuildContext context) {
                                  //   //         return AlertDialog(
                                  //   //           title: Text("ALERT !",style: GoogleFonts.ubuntu(
                                  //   //             fontWeight: FontWeight.w600,
                                  //   //             fontSize: 26,
                                  //   //             color: Color(0xff002859),
                                  //   //           ),),
                                  //   //
                                  //   //           content: Text(
                                  //   //             "No User details Exist ",style: GoogleFonts.ubuntu(
                                  //   //               fontWeight: FontWeight.w400,
                                  //   //               fontSize: 17,
                                  //   //               color: Colors.black
                                  //   //           ),),
                                  //   //           actions: [
                                  //   //             TextButton(
                                  //   //               child: Text("OK",style: GoogleFonts.ubuntu(
                                  //   //                   fontWeight: FontWeight.w600,
                                  //   //                   fontSize: 16,
                                  //   //                   color: Colors.blue
                                  //   //               ),),
                                  //   //               onPressed: () {
                                  //   //                 Navigator.of(context).pop();
                                  //   //               },
                                  //   //             ),
                                  //   //           ],
                                  //   //         );
                                  //   //       },
                                  //   //     );
                                  //   //   }
                                  //   // });
                                  // }
                                },
                                child: Text(
                                  "Login",
                                  style:
                                  TextStyle(fontSize: 16, color: Colors.white),
                                )),
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
