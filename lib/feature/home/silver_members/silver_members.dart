import 'dart:io';

import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/constants/Appcolor.dart';
import '../../../core/widgets/app_text.dart';
import '../../../core/widgets/text_field_with_label.dart';
import '../../../main.dart';


class SilverMembers extends StatefulWidget {
  const SilverMembers({super.key});

  @override
  State<SilverMembers> createState() => _SilverMembersState();
}

class _SilverMembersState extends State<SilverMembers> {


  GlobalKey<FormState> formkey = GlobalKey();

  String? district;  // Allowing null to properly initialize
  final List<String> districts = [
    "Kasargod",
    "Kannur",
    "Wayanad",
    "Kozhikode",
    "Malappuram",
    "Palakkad",
    "Thrissur",
    "Ernakulam",
    "Idukki",
    "Alappuzha",
    "Kottayam",
    "Pathanamthitta",
    "Kollam",
    "Thiruvananthapuram"
  ];




  TextEditingController nameController = TextEditingController();
  TextEditingController phonecontroller = TextEditingController();
  TextEditingController placeController = TextEditingController();
  TextEditingController pinCodeController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController aadharController = TextEditingController();




  TextEditingController points = TextEditingController();
  TextEditingController radeempoints = TextEditingController();




  TextEditingController search=TextEditingController();

  final List<Map<String, dynamic>> data = [
    {
      "Name": "Mia Clark",
      "Phone": "3123456789",
      "Place": "Fort Worth",
      "Insurance": "ABC1122",
      "Status": true,
      "Radeem": "1300",
      "Add Point": "Add",
      "Action": "Edit",
      "Delete": "Delete",
    },
    {
      "Name": "Noah King",
      "Phone": "4123456789",
      "Place": "Columbus",
      "Insurance": "ABC1122",
      "Status": true,
      "Radeem": "1400",
      "Add Point": "Add",
      "Action": "Edit",
      "Delete": "Delete",
    },
    {
      "Name": "Olivia Scott",
      "Phone": "5123456789",
      "Place": "San Francisco",
      "Insurance": "ABC1122",
      "Status": true,
      "Radeem": "1500",
      "Add Point": "Add",
      "Action": "Edit",
      "Delete": "Delete",
    },
    {
      "Name": "Paul Adams",
      "Phone": "6123456789",
      "Place": "Charlotte",
      "Insurance": "ABC1122",
      "Status": true,
      "Radeem": "1600",
      "Add Point": "Add",
      "Action": "Edit",
      "Delete": "Delete",
    },
    {
      "Name": "Quinn Baker",
      "Phone": "7123456789",
      "Place": "Indianapolis",
      "Insurance": "ABC1122",
      "Status": true,
      "Radeem": "1700",
      "Add Point": "Add",
      "Action": "Edit",
      "Delete": "Delete",
    },
    {
      "Name": "Ryan Green",
      "Phone": "8123456789",
      "Place": "Seattle",
      "Insurance": "ABC1122",
      "Status": true,
      "Radeem": "1800",
      "Add Point": "Add",
      "Action": "Edit",
      "Delete": "Delete",
    },
    {
      "Name": "Sophia Young",
      "Phone": "9123456789",
      "Place": "Denver",
      "Insurance": "ABC1122",
      "Status": true,
      "Radeem": "1900",
      "Add Point": "Add",
      "Action": "Edit",
      "Delete": "Delete",
    },
    {
      "Name": "Tom Hall",
      "Phone": "1012345678",
      "Place": "Washington",
      "Insurance": "ABC1122",
      "Status": true,
      "Radeem": "2000",
      "Add Point": "Add",
      "Action": "Edit",
      "Delete": "Delete",
    },
    {
      "Name": "Uma Evans",
      "Phone": "1112345678",
      "Place": "Boston",
      "Insurance": "ABC1122",
      "Status": true,
      "Radeem": "2100",
      "Add Point": "Add",
      "Action": "Edit",
      "Delete": "Delete",
    },
    {
      "Name": "Victor Nelson",
      "Phone": "1212345678",
      "Place": "El Paso",
      "Insurance": "ABC1122",
      "Status": true,
      "Radeem": "2200",
      "Add Point": "Add",
      "Action": "Edit",
      "Delete": "Delete",
    },
    {
      "Name": "Wendy Carter",
      "Phone": "1312345678",
      "Place": "Detroit",
      "Insurance": "ABC1122",
      "Status": true,
      "Radeem": "2300",
      "Add Point": "Add",
      "Action": "Edit",
      "Delete": "Delete",
    },
  ];


  List<Map<String, dynamic>> _filteredData = [];

  bool toggle = false;

  @override
  void initState() {
    super.initState();
    _filteredData = List.from(data); // Initialize with the full data
  }

  void _searchQuery(String query) {
    final filtered = data.where((user) {
      final userName = user['Name']!.toLowerCase();
      final userPhone = user['Phone']!;
      final searchQuery = query.toLowerCase();

      return userName.contains(searchQuery) || userPhone.contains(searchQuery);
    }).toList();

    setState(() {
      _filteredData = filtered;
    });
  }











  @override
  Widget build(BuildContext context) {
    return Container(
      child:
      // categoryList.isEmpty
      //     ? Center(
      //         child: Text(
      //           'No Product Categories found',
      //           style: GoogleFonts.outfit(color: myColor),
      //         ),
      //       )
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child:
              Column(mainAxisAlignment: MainAxisAlignment.start, children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Silver Member',
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                            color: AppColors.black)
                    ),
                    SizedBox(width: w*0.1,),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 20),
                      child: Container(
                        width: 600,
                        height: 60,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 3,
                              color: Colors.grey.shade300,
                              offset: Offset(0, 1),
                            )
                          ],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(4, 4, 0, 4),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      4, 0, 4, 0),
                                  child: TextFormField(
                                    controller: search,
                                    validator: (planSearch) {
                                      if (planSearch!.isEmpty) {
                                        return 'Search not found';
                                      } else {
                                        return 'Please enter a valid search';
                                      }
                                    },
                                    obscureText: false,
                                    onChanged: (text) {
                                      _searchQuery(text);
                                      //     ref.read(searchProvider.notifier).update((state) => text.trim());
                                    },
                                    //   if (text == "") {
                                    //     userStream = FirebaseFirestore.instance
                                    //         .collection('products')
                                    //         .where('delete', isEqualTo: false)
                                    //         .where('brandId', isEqualTo: currentBrand)
                                    //         .limit(limit)
                                    //         .orderBy('date', descending: true)
                                    //         .snapshots();
                                    //   }  else {
                                    //     userStream = FirebaseFirestore.instance
                                    //         .collection('products')
                                    //         .where('brandId', isEqualTo: currentBrand)
                                    //         .where('delete', isEqualTo: false)
                                    //         .where("search", arrayContains: planSearch.text.toUpperCase())
                                    //         .limit(limit)
                                    //         .orderBy('date', descending: true)
                                    //         .snapshots();
                                    //   }
                                    //
                                    //   setState(() {});
                                    // },
                                    decoration: InputDecoration(
                                      labelText: 'Search User',
                                      hintText: 'Search by Name/Phone',
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0x00000000),
                                          width: 2,
                                        ),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0x00000000),
                                          width: 2,
                                        ),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      filled: true,
                                      fillColor: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              // Padding(
                              //   padding:
                              //   EdgeInsetsDirectional.fromSTEB(0, 0, 8, 0),
                              //   child: FFButtonWidget(
                              //     onPressed: () {
                              //       planSearch.clear();
                              //       planSearch.text='';
                              //
                              //
                              //       ref.read(searchProvider.notifier).update((state) => '');
                              //       // userStream = FirebaseFirestore.instance
                              //       //     .collection('products')
                              //       //     .where('delete', isEqualTo: false)
                              //       //     .where('brandId', isEqualTo: currentBrand)
                              //       //     .orderBy('date', descending: true)
                              //       //     .limit(limit)
                              //       //     .snapshots();
                              //       // setState(() {});
                              //     },
                              //     text: 'Clear',
                              //     options: FFButtonOptions(
                              //       width: width * 0.070,
                              //       height: height * 0.050,
                              //       color:Colors.black,
                              //       textStyle:
                              //       FlutterFlowTheme.subtitle2.override(
                              //         fontFamily: 'Poppins',
                              //         color: Colors.white,
                              //         fontSize: 10,
                              //         fontWeight: FontWeight.normal,
                              //       ),
                              //       elevation: 2,
                              //       borderSide: BorderSide(
                              //         color: Colors.transparent,
                              //         width: 1,
                              //       ),
                              //       borderRadius: 50,
                              //     ),
                              //   ),
                              // ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    InkWell(
                      onTap: () {
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => AddBrandProduct()));
                      },
                      child: Container(
                          width: w * 0.070,
                          height: h * 0.050,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: AppColors.dakLightGreen),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Search",
                                style: GoogleFonts.ubuntu(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          )),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child:Column(
                      children: [
                        _filteredData.isEmpty
                            ? Container(
                          child: Center(
                            child: Text("No Users Found"),
                          ),
                        )
                            : Container(
                          width: MediaQuery.of(context).size.width,
                          child: PaginatedDataTable(
                            rowsPerPage: _filteredData.length <= 10 ? _filteredData.length : 10,
                            arrowHeadColor: Colors.red,
                            columns: [
                              DataColumn(
                                label: Text(
                                  "Name ",
                                  style: GoogleFonts.workSans(
                                    fontSize: MediaQuery.of(context).size.width * 0.0082,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  "Approved",
                                  style: GoogleFonts.workSans(
                                    fontSize: MediaQuery.of(context).size.width * 0.0082,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  "Phone",
                                  style: GoogleFonts.workSans(
                                    fontSize: MediaQuery.of(context).size.width * 0.0082,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  "Place",
                                  style: GoogleFonts.workSans(
                                    fontSize: MediaQuery.of(context).size.width * 0.0082,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  "Insurance",
                                  style: GoogleFonts.workSans(
                                    fontSize: MediaQuery.of(context).size.width * 0.0082,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  "Status",
                                  style: GoogleFonts.workSans(
                                    fontSize: MediaQuery.of(context).size.width * 0.0085,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  "Add Point",
                                  style: GoogleFonts.workSans(
                                    fontSize: MediaQuery.of(context).size.width * 0.0085,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  "Action",
                                  style: GoogleFonts.workSans(
                                    fontSize: MediaQuery.of(context).size.width * 0.0085,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  "Delete",
                                  style: GoogleFonts.workSans(
                                    fontSize: MediaQuery.of(context).size.width * 0.0085,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ],
                            source: _DataTableSource(data: _filteredData,context: context,addPoints: addPoint,showPopup: showPopup,toggle: false, pickPdfFile: pickPdfFile),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(
                  height: 20,
                )
              ]),
            ),
          ),
        ],
      ),
    );
  }


  void showPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        double w = MediaQuery.of(context).size.width;
        return AlertDialog(
          title: Text('Edit User',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
          content: SingleChildScrollView(
            child: Form(
              key: formkey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  TextFormField(
                    controller: nameController,
                    validator: (value) {
                      if (nameController.text.trim().isEmpty) {
                        return "Enter your name";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey[200],
                      labelText: "Enter your Name",  // Use labelText for the hint
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),


                  SizedBox(height: 15), // Added spacing
                  TextFormField(
                    controller: phonecontroller,
                    readOnly: true,
                    decoration: InputDecoration(
                      filled: true,

                      fillColor: Colors.grey[200],
                      labelText: "Mobile Number",  // Use labelText for the hint
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  SizedBox(height: 15), // Added spacing
                  TextFormField(
                    controller:  aadharController,
                    decoration: InputDecoration(
                      filled: true,

                      fillColor: Colors.grey[200],
                      labelText: "Enter your Aadhar (Optional)",  // Use labelText for the hint
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  SizedBox(height: 15), // Added spacing
                  TextFormField(
                    controller:  placeController,
                    validator: (value) {
                      if (placeController.text.trim().isEmpty) {
                        return "Enter your place";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      filled: true,

                      fillColor: Colors.grey[200],
                      labelText: "Enter your place",  // Use labelText for the hint
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  SizedBox(height: 15), // Added spacing
                  TextFormField(
                    controller:  addressController,
                    keyboardType: TextInputType.multiline,
                    maxLines: 5,
                    validator: (value) {
                      if (addressController.text.trim().isEmpty) {
                        return "Enter your Address";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      filled: true,

                      fillColor: Colors.grey[200],
                      labelText: "Enter your full Address",  // Use labelText for the hint
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  SizedBox(height: 15), // Added spacing
                  TextFormField(
                    controller:  pinCodeController,
                    validator: (value) {
                      if (pinCodeController.text.trim().isEmpty) {
                        return "Enter your pin";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      filled: true,

                      fillColor: Colors.grey[200],
                      labelText: "Enter your pin",  // Use labelText for the hint
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  SizedBox(height: 15), // Added spacing
                  LabelAndForm(
                    height: w * .18,
                    title: "District *",
                    widget: DropdownButtonFormField<String>(
                      validator: (value) {
                        if (district == null || district!.isEmpty) {
                          return "Select your district";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey[200],
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: Colors.transparent),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: Colors.transparent),
                        ),
                        errorBorder: OutlineInputBorder(
                          gapPadding: 20,
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                            color: Colors.black,
                          ),
                        ),
                      ),
                      hint: AppText("-District-"),
                      value: districts.isNotEmpty ? district : null,
                      items: districts.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem(
                          value: value,
                          child: AppText(value),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          district = newValue!;
                        });
                      },
                    ),
                    label: 'Select Your District',
                  ),
                  SizedBox(height: 15),
                  TextFormField(
                    controller:  stateController,
                    decoration: InputDecoration(
                      filled: true,

                      fillColor: Colors.grey[200],
                      labelText: "Enter your State",  // Use labelText for the hint
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),// Added spacing
                  SizedBox(height: h*0.07), // Added spacing before button

                  SizedBox(
                    height: h*0.1,
                    width: w*0.7,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.darkGreen,
                        //  padding: EdgeInsets.all(w! * .03),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        //  elevation: 1,
                      ),
                      onPressed: () {
                        if (formkey.currentState!.validate()) {
                          // Perform the edit operation
                        }else{
                          // Navigator.pop(context);
                        }

                      },
                      child: Center(
                        child: Text(
                          "Edit User",
                          style: TextStyle(
                              color: AppColors.white,
                              fontSize: 20,
                              letterSpacing: 1,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ),

                  // AppButton(
                  //   text: "Edit",
                  //   height: w * .03,
                  //   width: w * .6,
                  //   cornerRadius: w * .1,
                  //   onTap: () {
                  //     if (formkey.currentState!.validate()) {
                  //       // Perform the edit operation
                  //     }
                  //   },
                  // ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void addPoint(BuildContext context){
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              content: SizedBox(
                height: MediaQuery.of(context).size.height * .4,
                width: MediaQuery.of(context).size.width * 0.07,
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: AppText(
                          'Points',
                          size: MediaQuery.of(context).size.width * .015
                      ),
                    ),
                    TextFormField(
                      controller: points,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey[200],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: AppText(
                          'Redeem Points',
                          size: MediaQuery.of(context).size.width * .015
                      ),
                    ),
                    TextFormField(
                      controller: radeempoints,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey[200],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),

                    SizedBox(
                      height: h*0.1,
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text("Loyalty Points: 25",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 25),),
                        Text("Radeem Points : 100",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 25))
                      ],
                    )
                  ],
                ),
              ),
              actions: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.1,
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.darkGreen,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () {
                      if (formkey.currentState!.validate()) {
                        // Perform the edit operation
                      }

                      Navigator.pop(context);
                    },
                    child: Center(
                      child: Text(
                        "Add",
                        style: TextStyle(
                            color: AppColors.white,
                            fontSize: 20,
                            letterSpacing: 1,
                            fontWeight: FontWeight.w600
                        ),
                      ),
                    ),
                  ),
                ),
              ],
              actionsAlignment: MainAxisAlignment.center,
            );
          },
        );
      },
    );
  }


  Future<void> pickPdfFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      File file = File(result.files.single.path!);
      print('Picked file: ${file.path}');
    } else {
      // User canceled the picker
    }
  }




}


class _DataTableSource extends DataTableSource {
  final List<Map<String, dynamic>> data;
  final BuildContext context;
  final Function showPopup;
  final Function addPoints;
  final Function pickPdfFile;
  final bool toggle;

  _DataTableSource({
    required this.data,
    required this.context,
    required this.showPopup,
    required this.addPoints,
    required this.toggle,
    required this.pickPdfFile
  });

  @override
  DataRow? getRow(int index) {
    if (index >= data.length) return null;

    final user = data[index];

    return DataRow.byIndex(index: index, cells: [
      DataCell(
        Text(user['Name']!),
      ),
      DataCell(
        ApproveToggleButton(
          initialToggle: toggle,
          onToggle: (newToggle) {
            // Handle the toggle state change here
            print("Toggle state is now: $newToggle");
          },
        ),
      ),
      DataCell(Text(user['Phone']!)),
      DataCell(Text(user['Place']!)),
      DataCell(
        InkWell(
          onTap: () {
            pickPdfFile();
            //  print('Edit ${details["S.No"]}');
          },
          child: Container(
            height: h*0.045,
            width: w*0.05,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: AppColors.dakLightGreen,
            ),
            child: Center(
              child: Text(
                'Insurance',
                style: GoogleFonts.workSans(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ),
      ),
      DataCell(
        ToggleButton(
          initialToggle: toggle,
          onToggle: (newToggle) {
            // Handle the toggle state change here
            print("Toggle state is now: $newToggle");
          },
        ),
      ),
      DataCell(
        InkWell(
          onTap: () {
            addPoints(context);
            //  print('Points ${data["S.No"]}');
          },
          child: Container(
            height: h*0.045,
            width: w*0.06,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: AppColors.dakLightGreen,
            ),
            child: Center(
              child: Text(
                'Add Point',
                style: GoogleFonts.workSans(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ),
      ),
      DataCell(
        InkWell(
          onTap: () {
            showPopup(context);
            //  print('Edit ${details["S.No"]}');
          },
          child: Container(
            height: h*0.045,
            width: w*0.05,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: AppColors.dakLightGreen,
            ),
            child: Center(
              child: Text(
                'Edit',
                style: GoogleFonts.workSans(
                  color: Colors.white,
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ),
      ),
      DataCell(
        InkWell(
          onTap: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('Are you sure?'),
                  content: Text('Are you sure you want to remove this user?'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        // Add your save for later logic here
                      },
                      child: Text('OK'),
                    ),
                  ],
                );
              },
            );
            //  print('Delete ${details["S.No"]}');
          },
          child: Icon(
            Icons.delete,
            color: Colors.red,
          ),
        ),
      ),
    ]);
  }

  @override
  int get rowCount => data.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => 0;
}




class ApproveToggleButton extends StatefulWidget {
  final bool initialToggle;
  final Function(bool) onToggle;

  ApproveToggleButton({required this.initialToggle, required this.onToggle});

  @override
  _ApproveToggleButtonState createState() => _ApproveToggleButtonState();
}

class _ApproveToggleButtonState extends State<ApproveToggleButton> {
  late bool toggle;

  @override
  void initState() {
    super.initState();
    toggle = widget.initialToggle;
  }

  @override
  Widget build(BuildContext context) {

    return InkWell(
      onTap: () {
        setState(() {
          toggle = !toggle;
        });
        widget.onToggle(toggle);
      },
      child: Container(
        height: w * 0.016,
        width: w * 0.032,
        decoration: BoxDecoration(
          color: toggle ? Colors.green : Colors.black12,
          borderRadius: BorderRadius.circular(w * 0.2),
          border: Border.all(color: Colors.black45),
        ),
        child: Stack(
          children: [
            AnimatedPositioned(
              curve: Curves.easeInOut,
              right: toggle ? 0 : w * 0.016,
              left: toggle ? w * 0.016 : 0,
              duration: Duration(milliseconds: 300),
              child: AnimatedContainer(
                curve: Curves.easeInOut,
                height: w * 0.0145,
                width: w * 0.0145,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                duration: Duration(milliseconds: 300),
              ),
            ),
          ],
        ),
      ),
    );


  }
}






class ToggleButton extends StatefulWidget {
  final bool initialToggle;
  final Function(bool) onToggle;

  ToggleButton({required this.initialToggle, required this.onToggle});

  @override
  _ToggleButtonState createState() => _ToggleButtonState();
}

class _ToggleButtonState extends State<ToggleButton> {
  late bool toggle;

  @override
  void initState() {
    super.initState();
    toggle = widget.initialToggle;
  }

  @override
  Widget build(BuildContext context) {

    return InkWell(
      onTap: () {
        setState(() {
          toggle = !toggle;
        });
        widget.onToggle(toggle);
      },
      child: Container(
        height: w * 0.016,
        width: w * 0.032,
        decoration: BoxDecoration(
          color: toggle ? Colors.yellow.shade600 : Colors.black12,
          borderRadius: BorderRadius.circular(w * 0.2),
          border: Border.all(color: Colors.black45),
        ),
        child: Stack(
          children: [
            AnimatedPositioned(
              curve: Curves.easeInOut,
              right: toggle ? 0 : w * 0.016,
              left: toggle ? w * 0.016 : 0,
              duration: Duration(milliseconds: 300),
              child: AnimatedContainer(
                curve: Curves.easeInOut,
                height: w * 0.0145,
                width: w * 0.0145,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                duration: Duration(milliseconds: 300),
              ),
            ),
            AnimatedPositioned(
              curve: Curves.easeInOut,
              left: toggle ? null : w * 0.015,
              right: toggle ? w * 0.015 : null,
              top: 0,
              bottom: 0,
              duration: Duration(milliseconds: 300),
              child: Center(
                child: Text(
                  toggle ? "Gold " : "Silver",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: w * 0.006, // Adjust the font size as needed
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );


  }
}







