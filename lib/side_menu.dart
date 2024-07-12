
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gefmartwiringadmin/color/Appcolor.dart';

import 'main.dart';
var myColor = const Color(0xff002859);
var fontWidth;


class SideMenu extends StatefulWidget {
  final TabController tabController;
  const SideMenu({Key? key, required this.tabController})
      :super(key: key);


  @override
  State<SideMenu> createState() => _SideMenuState();
}

// signout(BuildContext context) async {
//   Navigator.push(
//       context, MaterialPageRoute(builder: (context) => LoginPage()));
//   adminMail = '';
//   adminPass = '';
//   final prefence = await SharedPreferences.getInstance();
//   prefence.remove("userId");
//   prefence.remove("password");
// }

class _SideMenuState extends State<SideMenu> {
  int selectedTab = 0;
  int subTab = 0;

  @override
  Widget build(BuildContext context) {
    double fontWidth = MediaQuery.of(context).size.width;
    // width = MediaQuery.of(context).size.width;
    // height = MediaQuery.of(context).size.height;
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomLeft,
            colors: <Color>[
              Colors.blue.shade900,
              Colors.blue.shade700,
              Colors.blue.shade600,
              Colors.blue.shade500
            ]),
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
                    width: w * 0.055,  // width of the container
                    height: h * 0.11, // height of the container
                    decoration: BoxDecoration(
                     // color: AppColors.black,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.asset(
                        'assets/Gefmartlogo1.png',
                        fit: BoxFit.cover,  // adjust the image to cover the container
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    'Wiring App Admin',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 14),
                  ),
                  Container(),
                  const SizedBox(
                    height: 20,
                  ),
                  Divider(
                    color: Colors.blueGrey.shade800,
                  ),
                  // DASHBOARD
                  Container(
                    height: 30,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: selectedTab == 0 ? Colors.green : Colors.transparent,
                      border: selectedTab == 0
                          ? const Border(
                        left: BorderSide(color: Colors.green, width: 3),
                      )
                          : null,
                    ),
                    child: InkWell(
                      onHover: (value) {},
                      onTap: () {
                        setState(() {
                          widget.tabController.animateTo((0));
                          subTab = 0;
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
                            color: selectedTab == 0 ? Colors.white : AppColors.grey,
                            size: 18,
                          ),
                          const SizedBox(
                            width: 7,
                          ),
                          Text(
                            'Dashboard',
                            style: TextStyle(
                              color: selectedTab == 0 ? Colors.white : AppColors.grey,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Divider(
                    color: Colors.blueGrey.shade800,
                  ),
                  Container(
                    height: 30,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: selectedTab == 1 ? Colors.green : Colors.transparent,
                      border: selectedTab == 1
                          ? const Border(
                        left: BorderSide(color: Colors.green, width: 3),
                      )
                          : null,
                    ),
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          widget.tabController.animateTo((1));
                          // subTab = 0;
                          // selectedTab = 0;
                        });
                      },
                      child: Row(
                        children: [
                          const SizedBox(
                            width: 13,
                          ),
                          Icon(
                            Icons.view_in_ar_rounded,
                            size: 18,
                            color: selectedTab == 1 ? Colors.white : AppColors.grey,
                          ),
                          const SizedBox(width: 7),
                          Text(
                            'View Data',
                            style: TextStyle(
                              color: selectedTab == 1 ? Colors.white : AppColors.grey,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Divider(
                    color: Colors.blueGrey.shade800,
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






















// class _SideMenuState extends State<SideMenu> {
//
//   int selectedTab = 0;
//   int subTab = 0;
//
//   @override
//   Widget build(BuildContext context) {
//     fontWidth = MediaQuery.of(context).size.width;
//     // width = MediaQuery.of(context).size.width;
//     // height = MediaQuery.of(context).size.height;
//     return Container(
//       decoration: BoxDecoration(
//         gradient:LinearGradient(
//             begin: Alignment.topLeft,
//             end: Alignment.bottomLeft,
//             colors: <Color>[Colors.blue.shade900,Colors.blue.shade700,Colors.blue.shade600,Colors.blue.shade500]),
//
//       ),
//       width: 250,
//       child: Theme(
//         data: ThemeData(highlightColor: Colors.black),
//         child: Scrollbar(
//           child: ListView(
//             children: [
//               const SizedBox(
//                 height: 10,
//               ),
//               Column(
//                 children: [
//                   Container(
//                     width: w * 0.055,  // width of the container
//                     height: h * 0.11, // height of the container
//                     decoration: BoxDecoration(
//                      // color: AppColors.black,
//                       borderRadius: BorderRadius.circular(15),
//                     ),
//                     child: ClipRRect(
//                       borderRadius: BorderRadius.circular(15),
//                       child: Image.asset(
//                         'assets/Gefmartlogo1.png',
//                         fit: BoxFit.cover,  // adjust the image to cover the container
//                       ),
//                     ),
//                   ),
//                   const SizedBox(
//                     height: 10,
//                   ),
//
//
//                   Text(
//                     'Wiring App Admin',
//                     style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                         color: Colors.white,
//                         fontSize: 14),
//                   ),
//                   Container(),
//                   SizedBox(
//                     height: 20,
//                   ),
//                   Divider(
//                     color: Colors.blueGrey.shade800,
//                   ),
//
//                   //DASHBOARD
//                   Container(
//                     height: 30,
//                     width: double.infinity,
//                     decoration: BoxDecoration(
//                       border: selectedTab == 0
//                           ? const Border(
//                         left: BorderSide(color: Colors.blue, width: 3),
//                       )
//                           : null,
//                     ),
//                     child: InkWell(
//                       onHover: (value) {},
//                       onTap: () {
//                         setState(() {
//                           widget.tabController.animateTo((0));
//                           subTab = 0;
//                           selectedTab = 0;
//                         });
//                       },
//                       child: Row(
//                         children: const [
//                           SizedBox(
//                             width: 10,
//                           ),
//                           Icon(
//                             Icons.dashboard,
//                             color: AppColors.grey,
//                             size: 18,
//                           ),
//                           SizedBox(
//                             width: 7,
//                           ),
//                           Text(
//                             'Dashboard',
//                             style: TextStyle(color: AppColors.grey),
//                           )
//                         ],
//                       ),
//                     ),
//                   ),
//                   Divider(
//                     color: Colors.blueGrey.shade800,
//                   ),
//
//                   // ExpandablePanel(
//                   //   theme: const ExpandableThemeData(
//                   //       iconColor: Colors.white, iconSize: 14),
//                   //   header:
//                   Container(
//                     height: 30,
//                     width: double.infinity,
//                     decoration: BoxDecoration(
//                       border: selectedTab == 1
//                           ? const Border(
//                         left: BorderSide(color: Colors.blue, width: 3),
//                       )
//                           : null,
//                     ),
//                     child: InkWell(
//                       onTap: () {
//                         setState(() {
//                           widget.tabController.animateTo((1));
//                           // subTab = 0;
//                           // selectedTab = 0;
//                         });
//                       },
//                       child: const Row(
//                         children: [
//                           SizedBox(
//                             width: 13,
//                           ),
//                           Icon(
//                             Icons.view_in_ar_rounded,
//                             size: 18,
//                             color:AppColors.grey,
//                           ),
//                           SizedBox(width: 7),
//                           Text(
//                             'View Data',
//                             style: TextStyle(color: AppColors.grey),
//                           )
//                         ],
//                       ),
//                     ),
//                   ),
//                   // expanded: Column(
//                   //   children: [
//                   //
//                   //     InkWell(
//                   //       child: CollaspeItem(
//                   //         label: " Products List",
//                   //         icon: Icons.stop_rounded,
//                   //         style: TextStyle(
//                   //             color: subTab == 1
//                   //                 ? Colors.blue.shade300
//                   //                 : Colors.grey,
//                   //             fontWeight: subTab == 1
//                   //                 ? FontWeight.bold
//                   //                 : FontWeight.normal,
//                   //             fontSize: 12
//                   //         ),
//                   //       ),
//                   //       onTap: () {
//                   //         setState(() {
//                   //           widget.tabController.animateTo((1));
//                   //           selectedTab = 1;
//                   //           subTab = 1;
//                   //         });
//                   //       },
//                   //     ),
//                   //     InkWell(
//                   //       child: CollaspeItem(
//                   //         label: "Deleted Products",
//                   //         icon: Icons.stop_rounded,
//                   //         style: TextStyle(
//                   //             color: subTab == 2
//                   //                 ? Colors.blue.shade300
//                   //                 : Colors.grey,
//                   //             fontWeight: subTab == 2
//                   //                 ? FontWeight.bold
//                   //                 : FontWeight.normal,
//                   //             fontSize: 12
//                   //         ),
//                   //       ),
//                   //       onTap: () {
//                   //         setState(() {
//                   //           widget.tabController.animateTo((2));
//                   //           selectedTab = 1;
//                   //           subTab = 2;
//                   //         });
//                   //       },
//                   //     ),
//                   //   ],
//                   // ),
//                   //
//                   // collapsed: const SizedBox(),
//                   //   ),
//                   Divider(
//                     color: Colors.blueGrey.shade800,
//                   ),
//                   // ExpandablePanel(
//                   //   theme: const ExpandableThemeData(
//                   //       iconColor: Colors.white, iconSize: 14),
//                   //   header: Container(
//                   //     height: 30,
//                   //     width: double.infinity,
//                   //     decoration: BoxDecoration(
//                   //       border: selectedTab == 2
//                   //           ? const Border(
//                   //         left: BorderSide(color: Colors.blue, width: 3),
//                   //       )
//                   //           : null,
//                   //     ),
//                   //     child: Row(
//                   //       children: const [
//                   //         SizedBox(
//                   //           width: 13,
//                   //         ),
//                   //         Icon(
//                   //           Icons.person,
//                   //           size: 18,
//                   //           color: Colors.white,
//                   //         ),
//                   //         SizedBox(width: 7),
//                   //         Text(
//                   //           'Warranty',
//                   //           style: TextStyle(color: Colors.white),
//                   //         )
//                   //       ],
//                   //     ),
//                   //   ),
//                   //   expanded: Column(
//                   //     children: [
//                   //
//                   //       InkWell(
//                   //         child: CollaspeItem(
//                   //           label: "Warranty List",
//                   //           icon: Icons.stop_rounded,
//                   //           style: TextStyle(
//                   //               color: subTab == 3
//                   //                   ? Colors.blue.shade300
//                   //                   : Colors.grey,
//                   //               fontWeight: subTab == 3
//                   //                   ? FontWeight.bold
//                   //                   : FontWeight.normal,
//                   //               fontSize: 12
//                   //           ),
//                   //         ),
//                   //         onTap: () {
//                   //           setState(() {
//                   //             widget.tabController.animateTo((3));
//                   //             selectedTab = 2;
//                   //             subTab = 3;
//                   //           });
//                   //         },
//                   //       ),
//                   //     ],
//                   //   ),
//                   //
//                   //   collapsed: const SizedBox(),
//                   // ),
//                   // Divider(
//                   //   color: Colors.blueGrey.shade800,
//                   // ),
//                   //
//                   // InkWell(
//                   //   child: CollaspeItem(
//                   //     label: "Logout",
//                   //     icon: Icons.logout,
//                   //     style: TextStyle(
//                   //         color:
//                   //         subTab == 4 ? Colors.blue.shade300 : Colors.grey,
//                   //         fontWeight:
//                   //         subTab == 4 ? FontWeight.bold : FontWeight.normal,
//                   //         fontSize: 12),
//                   //   ),
//                   //   onTap: () async {
//                   //     subTab = 10;
//                   //     await showDialog(
//                   //       context: context,
//                   //       builder: (alertDialogContext) {
//                   //         return AlertDialog(
//                   //           title:  Text('Logout !',
//                   //               style: TextStyle(
//                   //                   fontWeight: FontWeight.w600,
//                   //                   color: Color(0xff002859))),
//                   //           content: const Text('Do you Want to Logout ?'),
//                   //           actions: [
//                   //             TextButton(
//                   //               onPressed: () =>
//                   //                   Navigator.pop(alertDialogContext),
//                   //               child: Container(
//                   //                   height: h*0.04,
//                   //                   width: w*0.05,
//                   //                   decoration: BoxDecoration(
//                   //                       color: Color(0xff002859),
//                   //                       borderRadius: BorderRadius.circular(5)
//                   //                   ),
//                   //                   child: Center(
//                   //                       child: const Text('Cancel',
//                   //                         style: TextStyle(color: Colors.white),))),
//                   //             ),
//                   //             TextButton(
//                   //               onPressed: () async {
//                   //                // signout(context);
//                   //               },
//                   //               child: Container(
//                   //                   height: h*0.04,
//                   //                   width: w*0.05,
//                   //                   decoration: BoxDecoration(
//                   //                       color: Color(0xff002859),
//                   //                       borderRadius: BorderRadius.circular(5)
//                   //                   ),
//                   //                   child: Center(
//                   //                       child: const Text('Confirm',
//                   //                         style: TextStyle(color: Colors.white),))),
//                   //             ),
//                   //           ],
//                   //         );
//                   //       },
//                   //     );
//                   //   },
//                   // )
//                 ],
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }