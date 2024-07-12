import 'package:flutter/material.dart';
import 'package:gefmartwiringadmin/color/Appcolor.dart';
import 'package:gefmartwiringadmin/side_menu.dart';
import 'package:google_fonts/google_fonts.dart';

import 'main.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffebebf5),
      body:
      Column(
        children: [

          Container(
            height: h,
            width: w,
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Material(
                borderRadius: BorderRadius.circular(20),
                color: Color(0xfff4f4fc),
                elevation: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 50,),
                    Text('Dashboard',
                        style: GoogleFonts.ubuntu(
                            fontWeight: FontWeight.bold,
                            fontSize: 45,
                            color: AppColors.black)
                    ),

                    SizedBox(height: h*0.15,),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          height:w*0.11,
                          width :w*0.15,
                          child: Stack(
                            clipBehavior: Clip.none,
                            children: [
                              Positioned(
                                child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20)),
                                        // color: Colors.grey.withOpacity(0.1)
                                        color: AppColors.white
                                    ),
                                    height:w*0.08,
                                    width :w*0.18,
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          top: h*0.03),
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                                            children: [
                                              Image.asset('assets/man.png',height: w*0.04,),
                                              Column(
                                                children: [
                                                  Text("44",
                                                                                             //     total.toString(),
                                                    // institutionCount.toString(),
                                                    style: GoogleFonts.oxygen(
                                                        fontSize: 25,
                                                        color: Colors.grey,
                                                        fontWeight:
                                                        FontWeight.bold),
                                                  ),
                                                  SizedBox(height: h*0.01,),
                                                  Text('Users',
                                                      style: GoogleFonts
                                                          .josefinSans(
                                                          fontSize: 25,
                                                          color:AppColors.grey,
                                                          fontWeight:
                                                          FontWeight
                                                              .bold)),
                                                ],
                                              ),

                                            ],
                                          ),
                                          SizedBox(height: h*0.02,),

                                        ],
                                      ),
                                    )),
                              ),
                              // Positioned(
                              //   top: height*0.03,
                              //   left: width*0.1,
                              //   child: Container(
                              //     width: width*0.08,
                              //     height: height*0.13,
                              //     color: Colors.red,
                              //     // decoration: BoxDecoration(
                              //     //     image: DecorationImage(
                              //     //         image: AssetImage('assets/images/plan2.png',),fit: BoxFit.fill
                              //     //     )
                              //     // ),
                              //   ),
                              //   // child: Lottie.asset(
                              //   //   'assets/images/plan.png',
                              //   //   width: w*0.08,
                              //   //   animate: true,
                              //   //   repeat: true,
                              //   // )
                              // ),
                            ],
                          ),
                        ),
                     //   SizedBox(width: 20,),
                        Container(
                          height:w*0.11,
                          width :w*0.15,
                          child: Stack(
                            clipBehavior: Clip.none,
                            children: [
                              Positioned(
                                child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20)),
                                        // color: Colors.grey.withOpacity(0.1)
                                        color: AppColors.white
                                    ),
                                    height:w*0.08,
                                    width :w*0.18,
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          top: h*0.03),
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                                            children: [
                                              Image.asset('assets/coin.jpeg',height: w*0.04,),
                                              Column(
                                                children: [
                                                  Text("44",
                                                    //     total.toString(),
                                                    // institutionCount.toString(),
                                                    style: GoogleFonts.oxygen(
                                                        fontSize: 25,
                                                        color: Colors.grey,
                                                        fontWeight:
                                                        FontWeight.bold),
                                                  ),
                                                  SizedBox(height: h*0.01,),
                                                  Text('Coins',
                                                      style: GoogleFonts
                                                          .josefinSans(
                                                          fontSize: 25,
                                                          color:AppColors.grey,
                                                          fontWeight:
                                                          FontWeight
                                                              .bold)),
                                                ],
                                              ),

                                            ],
                                          ),
                                          SizedBox(height: h*0.02,),

                                        ],
                                      ),
                                    )),
                              ),
                              // Positioned(
                              //   top: height*0.03,
                              //   left: width*0.1,
                              //   child: Container(
                              //     width: width*0.08,
                              //     height: height*0.13,
                              //     color: Colors.red,
                              //     // decoration: BoxDecoration(
                              //     //     image: DecorationImage(
                              //     //         image: AssetImage('assets/images/plan2.png',),fit: BoxFit.fill
                              //     //     )
                              //     // ),
                              //   ),
                              //   // child: Lottie.asset(
                              //   //   'assets/images/plan.png',
                              //   //   width: w*0.08,
                              //   //   animate: true,
                              //   //   repeat: true,
                              //   // )
                              // ),
                            ],
                          ),
                        ),

                      ],
                    ),



                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
