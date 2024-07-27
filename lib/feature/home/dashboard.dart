import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:gefmartwiringadmin/feature/home/side_menu.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/constants/Appcolor.dart';
import '../../main.dart';

class Dashboard extends StatefulWidget {
  final TabController tabController;

  const Dashboard({super.key, required this.tabController});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffebebf5),
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Dashboard',
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.bold,
                                fontSize: 45,
                                color: AppColors.black)
                        ),




                      ],
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.15,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            widget.tabController.animateTo(1);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.white, // Background color
                            minimumSize: Size(
                              MediaQuery.of(context).size.width * 0.15, // Width
                              MediaQuery.of(context).size.width * 0.11, // Height
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            elevation: 0, // Set elevation to 0 to match your design
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height * 0.03,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Image.asset(
                                  'assets/man.png',
                                  height: MediaQuery.of(context).size.width * 0.04,
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "44",
                                      style: GoogleFonts.oxygen(
                                        fontSize: MediaQuery.of(context).size.width * 0.015,
                                        color: Colors.grey,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                                    Text(
                                      'Users',
                                      style: GoogleFonts.josefinSans(
                                        fontSize: MediaQuery.of(context).size.width * 0.02,
                                        color: AppColors.grey,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),

                        ElevatedButton(
                          onPressed: () {
                            widget.tabController.animateTo(2);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.white, // Background color
                            minimumSize: Size(
                              MediaQuery.of(context).size.width * 0.15, // Width
                              MediaQuery.of(context).size.width * 0.11, // Height
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            elevation: 0, // Set elevation to 0 to match your design
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height * 0.03,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Image.asset(
                                  'assets/Silver.png',
                                  height: MediaQuery.of(context).size.width * 0.04,
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "24",
                                      style: GoogleFonts.oxygen(
                                        fontSize: MediaQuery.of(context).size.width * 0.015,
                                        color: Colors.grey,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                                    Text(
                                      'Silver Users',
                                      style: GoogleFonts.josefinSans(
                                        fontSize: MediaQuery.of(context).size.width * 0.02,
                                        color: AppColors.grey,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            widget.tabController.animateTo(3);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.white, // Background color
                            minimumSize: Size(
                              MediaQuery.of(context).size.width * 0.15, // Width
                              MediaQuery.of(context).size.width * 0.11, // Height
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            elevation: 0, // Set elevation to 0 to match your design
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height * 0.03,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Image.asset(
                                  'assets/Gold.png',
                                  height: MediaQuery.of(context).size.width * 0.04,
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "20",
                                      style: GoogleFonts.oxygen(
                                        fontSize: MediaQuery.of(context).size.width * 0.015,
                                        color: Colors.grey,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                                    Text(
                                      'Gold Users',
                                      style: GoogleFonts.josefinSans(
                                        fontSize: MediaQuery.of(context).size.width * 0.02,
                                        color: AppColors.grey,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
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
            ),
          ),
        ],
      ),
    );
  }


}












