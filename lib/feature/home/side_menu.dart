import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/constants/Appcolor.dart';



class SideMenu extends StatefulWidget {
  final TabController tabController;
  const SideMenu({Key? key, required this.tabController,}) : super(key: key,);

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  int selectedTab = 0;


  @override
  Widget build(BuildContext context) {
    double fontWidth = MediaQuery.of(context).size.width;
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    return Container(
      decoration: BoxDecoration(
        // gradient: LinearGradient(
        //   begin: Alignment.topLeft,
        //   end: Alignment.bottomLeft,
        //   colors: [
        //     Colors.blue.shade900,
        //     Colors.blue.shade700,
        //     Colors.blue.shade600,
        //     Colors.blue.shade500
        //   ],
        // ),
      ),
      width: 250,
      child: Theme(
        data: ThemeData(highlightColor: Colors.black),
        child: Scrollbar(
          child: ListView(
            children: [
              const SizedBox(
                height: 10,
              ),
              Column(
                children: [
                  Container(
                    width: w * 0.055,
                    height: h * 0.11,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(18),
                      child: Image.asset(
                        'assets/Geftenlogo.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Wiring App Admin',
                    style: GoogleFonts.poppins(
                      color: AppColors.dakLightGreen,
                      fontSize: w * 0.01,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  // DASHBOARD
                  Container(
                    height: 30,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: selectedTab == 0 ? Colors.green : Colors.transparent,
                      border: selectedTab == 0
                          ? const Border(
                        left: BorderSide(color: Colors.white, width: 3),
                      )
                          : null,
                    ),
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          widget.tabController.animateTo(0);
                          selectedTab = 0;
                        });
                      },
                      child: Row(
                        children: [
                          const SizedBox(
                            width: 10,
                          ),
                          Icon(
                            Icons.dashboard,
                            color: selectedTab == 0 ? Colors.white : Colors.grey,
                            size: 18,
                          ),
                          const SizedBox(
                            width: 7,
                          ),
                          Text(
                            'Dashboard',
                            style: GoogleFonts.poppins(
                              color: selectedTab == 0 ? Colors.white : Colors.grey,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: h * 0.01),
                  Container(
                    height: 30,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: selectedTab == 1 ? Colors.green : Colors.transparent,
                      border: selectedTab == 1
                          ? const Border(
                        left: BorderSide(color: Colors.white, width: 3),
                      )
                          : null,
                    ),
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          widget.tabController.animateTo(1);
                          selectedTab = 1;
                        });
                      },
                      child: Row(
                        children: [
                          const SizedBox(
                            width: 10,
                          ),
                          Icon(
                            Icons.person,
                            size: 18,
                            color: selectedTab == 1 ? Colors.white : Colors.grey,
                          ),
                          const SizedBox(
                            width: 7,
                          ),
                          Text(
                            'Users',
                            style: GoogleFonts.poppins(
                              color: selectedTab == 1 ? Colors.white : Colors.grey,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: h * 0.01),
                  Container(
                    height: 30,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: selectedTab == 2 ? Colors.green : Colors.transparent,
                      border: selectedTab == 2
                          ? const Border(
                        left: BorderSide(color: Colors.white, width: 3),
                      )
                          : null,
                    ),
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          widget.tabController.animateTo(2);
                          selectedTab = 2;
                        });
                      },
                      child: Row(
                        children: [
                          const SizedBox(
                            width: 10,
                          ),
                          Image.asset("assets/Silver.png"),
                          // Icon(
                          //   Icons.person,
                          //   size: 18,
                          //   color: selectedTab == 2 ? Colors.white : Colors.grey,
                          // ),
                          const SizedBox(
                            width: 7,
                          ),
                          Text(
                            'Silver',
                            style: GoogleFonts.poppins(
                              color: selectedTab == 2 ? Colors.white : Colors.grey,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: h * 0.01),
                  Container(
                    height: 30,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: selectedTab == 3 ? Colors.green : Colors.transparent,
                      border: selectedTab == 3
                          ? const Border(
                        left: BorderSide(color: Colors.white, width: 3),
                      )
                          : null,
                    ),
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          widget.tabController.animateTo(3);
                          selectedTab = 3;
                        });
                      },
                      child: Row(
                        children: [
                          const SizedBox(
                            width: 10,
                          ),
                          Image.asset("assets/Gold.png"),
                          const SizedBox(
                            width: 7,
                          ),
                          Text(
                            'Gold',
                            style: GoogleFonts.poppins(
                              color: selectedTab == 3 ? Colors.white : Colors.grey,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: h * 0.01),
                  Container(
                    height: 30,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: selectedTab == 4 ? Colors.green : Colors.transparent,
                      border: selectedTab == 4
                          ? const Border(
                        left: BorderSide(color: Colors.white, width: 3),
                      )
                          : null,
                    ),
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          widget.tabController.animateTo(4);
                          selectedTab = 4;
                        });
                      },
                      child: Row(
                        children: [
                          const SizedBox(
                            width: 10,
                          ),
                          Image.asset("assets/imageqr.png"),
                          const SizedBox(
                            width: 7,
                          ),
                          Text(
                            'Qr Code Generate',
                            style: GoogleFonts.poppins(
                              color: selectedTab == 4 ? Colors.white : Colors.grey,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: h * 0.01),
                  Container(
                    height: 30,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: selectedTab == 5 ? Colors.green : Colors.transparent,
                      border: selectedTab == 5
                          ? const Border(
                        left: BorderSide(color: Colors.white, width: 3),
                      )
                          : null,
                    ),
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          widget.tabController.animateTo(5);
                          selectedTab = 5;
                        });
                      },
                      child: Row(
                        children: [
                          const SizedBox(
                            width: 10,
                          ),
                          Image.asset("assets/imageqr.png"),
                          const SizedBox(
                            width: 7,
                          ),
                          Text(
                            'Qr View',
                            style: GoogleFonts.poppins(
                              color: selectedTab == 5 ? Colors.white : Colors.grey,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
