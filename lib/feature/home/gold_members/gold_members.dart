import 'dart:html' as html;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/constants/Appcolor.dart';
import '../../../core/widgets/app_text.dart';
import '../../../core/widgets/text_field_with_label.dart';
import '../../../main.dart';
import '../../../model/User_model.dart';
// Import your AppColors file

class GoldMembers extends StatefulWidget {
  const GoldMembers({super.key});

  @override
  State<GoldMembers> createState() => _UserPageState();
}

class _UserPageState extends State<GoldMembers> {
  GlobalKey<FormState> formkey = GlobalKey();
  String? district;
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
  TextEditingController insuranceController = TextEditingController();
  TextEditingController points = TextEditingController();
  TextEditingController radeempoints = TextEditingController();
  TextEditingController searchController = TextEditingController();

  List<UserModel> users = [];
  List<UserModel> _filteredUsers = [];
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _filteredUsers = users;
  }

  Future<void> pickAndUploadPDF(BuildContext context, UserModel user) async {
    try {
      // Check if the user already has a PDF uploaded
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.mobileNumber)
          .get();
      if (userDoc.exists &&
          userDoc['pdfUrl'] != null &&
          userDoc['pdfUrl'].isNotEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('User already has a PDF uploaded.')),
        );
        return;
      }

      // Web platform
      html.FileUploadInputElement uploadInput = html.FileUploadInputElement();
      uploadInput.accept = '.pdf';
      uploadInput.click();

      uploadInput.onChange.listen((event) {
        final files = uploadInput.files;
        if (files!.isEmpty) return;

        final reader = html.FileReader();
        reader.readAsDataUrl(files[0]);
        reader.onLoadEnd.listen((event) async {
          try {
            String fileName = files[0].name;
            html.File file = files[0];

            // Upload the file to Firebase Storage
            Reference storageReference = FirebaseStorage.instance
                .ref()
                .child('pdfs/${user.mobileNumber}/$fileName');
            UploadTask uploadTask = storageReference.putBlob(file);

            // Wait for the upload to complete
            await uploadTask.whenComplete(() => null);

            // Get the download URL
            String downloadURL = await storageReference.getDownloadURL();

            // Save the URL to the user's pdfUrl field in Firestore
            await FirebaseFirestore.instance
                .collection('users')
                .doc(user.mobileNumber)
                .update({
              'pdfUrl': downloadURL,
            });

            // Update the local user object to reflect the change
            setState(() {
              user = user.copyWith(pdfUrl: downloadURL);
            });

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('PDF uploaded successfully!')),
            );

            print('File uploaded successfully. Download URL: $downloadURL');
          } catch (e) {
            print('Error occurred while uploading the file: $e');
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Error uploading PDF: $e')),
            );
          }
        });
      });
    } catch (e) {
      print('Error occurred while picking or uploading the file: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error uploading PDF: $e')),
      );
    }
  }

  void _onSearch() {
    setState(() {
      _searchQuery = searchController.text.toLowerCase();
    });
  }

  void _onClear() {
    setState(() {
      searchController.clear();
      _searchQuery = '';
    });
  }

  Stream<List<UserModel>> streamUsers() {
    return FirebaseFirestore.instance
        .collection('users')
        .snapshots()
        .map((snapshot) => snapshot.docs
        .map((doc) => UserModel.fromMap(doc.data()))
        .where((user) => !user.isdeleted && user.isGoldMember)
        .toList());
  }

  void showPopup(BuildContext context, UserModel user) {
    nameController.text = user.name;
    phonecontroller.text = user.mobileNumber;
    aadharController.text = user.aadharNumber ?? '';
    insuranceController.text = user.insuranceNumber ?? '';
    placeController.text = user.place;
    addressController.text = user.address;
    pinCodeController.text = user.pinCode;
    district = user.district;
    stateController.text = user.state;

    bool isChannelPartnerRecommended = user.isChannelPartnrReccommended ?? false;
    bool isSupportGeften = user.isSupportGeften ?? false;
    bool isLoyaltyPointAchieved = user.isLoyaltyPointAchieved ?? false;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        double w = MediaQuery.of(context).size.width;
        double h = MediaQuery.of(context).size.height;
        return AlertDialog(
          title: Text('Edit User',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
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
                      labelText: "Enter your Name",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  SizedBox(height: 15),
                  TextFormField(
                    controller: phonecontroller,
                    readOnly: true,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey[200],
                      labelText: "Mobile Number",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  SizedBox(height: 15),
                  TextFormField(
                    controller: aadharController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey[200],
                      labelText: "Enter your Aadhar (Optional)",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  SizedBox(height: 15),
                  TextFormField(
                    controller: insuranceController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey[200],
                      labelText: "Enter your Insurance (Optional)",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  SizedBox(height: 15),
                  TextFormField(
                    controller: placeController,
                    validator: (value) {
                      if (placeController.text.trim().isEmpty) {
                        return "Enter your place";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey[200],
                      labelText: "Enter your place",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  SizedBox(height: 15),
                  TextFormField(
                    controller: addressController,
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
                      labelText: "Enter your full Address",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  SizedBox(height: 15),
                  TextFormField(
                    controller: pinCodeController,
                    validator: (value) {
                      if (pinCodeController.text.trim().isEmpty) {
                        return "Enter your pin";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey[200],
                      labelText: "Enter your pin",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  SizedBox(height: 15),
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
                      items: districts
                          .map<DropdownMenuItem<String>>((String value) {
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
                    controller: stateController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey[200],
                      labelText: "Enter your State",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  SizedBox(height: 15),
                  if (isLoyaltyPointAchieved)
                    Container(
                      height: h * 0.1,
                      width: w,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text("Is Channel Partner Recommended "),
                              SizedBox(width: w * 0.01),
                              IsChannelPartnrReccommended(
                                initialToggle: isChannelPartnerRecommended,
                                onToggle: (newToggle) {
                                  FirebaseFirestore.instance
                                      .collection('users')
                                      .doc(user.mobileNumber)
                                      .update({'isChannelPartnrReccommended': newToggle});
                                },
                              ),
                            ],
                          ),
                          SizedBox(height: h * 0.02),
                          Row(
                            children: [
                              Text("Is Geften Supporter"),
                              SizedBox(width: w * 0.07),
                              IsSupportGeften(
                                initialToggle: isSupportGeften,
                                onToggle: (newToggle) {
                                  FirebaseFirestore.instance
                                      .collection('users')
                                      .doc(user.mobileNumber)
                                      .update({'isSupportGeften': newToggle});
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  SizedBox(height: h * 0.07),
                  SizedBox(
                    height: h * 0.1,
                    width: w * 0.7,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.darkGreen,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () {
                        if (formkey.currentState!.validate()) {
                          final updatedUser = user.copyWith(
                            name: nameController.text,
                            mobileNumber: phonecontroller.text,
                            aadharNumber: aadharController.text,
                            insuranceNumber: insuranceController.text,
                            place: placeController.text,
                            address: addressController.text,
                            pinCode: pinCodeController.text,
                            district: district,
                            state: stateController.text,
                            isSupportGeften: isSupportGeften,
                            isChannelPartnrReccommended:
                            isChannelPartnerRecommended,
                            isLoyaltyPointAchieved: isLoyaltyPointAchieved,
                          );

                          FirebaseFirestore.instance
                              .collection('users')
                              .doc(user.mobileNumber)
                              .update(updatedUser.toJson());

                          Navigator.of(context).pop();
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
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void addPoint(BuildContext context, UserModel user) {
    // Initialize the controllers with the current points
    TextEditingController pointsController =
    TextEditingController(text: user.loyaltyPoints?.toString() ?? '0');
    TextEditingController rewardPointsController =
    TextEditingController(text: user.rewardPOints?.toString() ?? '0');

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
                        'Loyalty Point',
                        size: MediaQuery.of(context).size.width * .015,
                      ),
                    ),
                    TextFormField(
                      controller: pointsController,
                      keyboardType: TextInputType.number, // Allow only numbers
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
                        'Reward Points',
                        size: MediaQuery.of(context).size.width * .015,
                      ),
                    ),
                    TextFormField(
                      controller: rewardPointsController,
                      keyboardType: TextInputType.number, // Allow only numbers
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
                      height: MediaQuery.of(context).size.height * 0.1,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          "Loyalty Points: ${user.loyaltyPoints ?? 0}",
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 25),
                        ),
                        Text(
                          "Reward Points: ${user.rewardPOints ?? 0}",
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 25),
                        ),
                      ],
                    ),
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
                    onPressed: () async {
                      if (pointsController.text.isNotEmpty ||
                          rewardPointsController.text.isNotEmpty) {
                        // Parse new values from the TextFormFields
                        int newLoyaltyPoints =
                            int.tryParse(pointsController.text) ?? 0;
                        int newRewardPoints =
                            int.tryParse(rewardPointsController.text) ?? 0;

                        // Update the points in Firestore with the new values
                        await FirebaseFirestore.instance
                            .collection('users')
                            .doc(user.mobileNumber)
                            .update({
                          'loyaltyPoints': newLoyaltyPoints,
                          'rewardPoints': newRewardPoints,
                        });

                        // Update the local user object
                        user.loyaltyPoints = newLoyaltyPoints;
                        user.rewardPOints = newRewardPoints;

                        Navigator.pop(context);

                        // Show success message
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Points updated successfully!')),
                        );
                      }
                    },
                    child: Center(
                      child: Text(
                        "Add",
                        style: TextStyle(
                            color: AppColors.white,
                            fontSize: 20,
                            letterSpacing: 1,
                            fontWeight: FontWeight.w600),
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

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<UserModel>>(
      stream: streamUsers(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }
        if (!snapshot.hasData) {
          return Center(child: Text('No data found'));
        }

        users = snapshot.data!;
        _filteredUsers = users.where((user) {
          return user.name.toLowerCase().contains(_searchQuery) ||
              user.mobileNumber.contains(_searchQuery);
        }).toList();

        return Container(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('All Users',
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 25,
                                  color: AppColors.black)),
                          SizedBox(
                              width: MediaQuery.of(context).size.width * 0.1),
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
                                        padding:
                                        EdgeInsetsDirectional.fromSTEB(
                                            4, 0, 4, 0),
                                        child: TextFormField(
                                          controller: searchController,
                                          obscureText: false,
                                          decoration: InputDecoration(
                                            labelText: 'Search User',
                                            hintText: 'Search by Name/Phone',
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Color(0x00000000),
                                                width: 2,
                                              ),
                                              borderRadius:
                                              BorderRadius.circular(8),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Color(0x00000000),
                                                width: 2,
                                              ),
                                              borderRadius:
                                              BorderRadius.circular(8),
                                            ),
                                            filled: true,
                                            fillColor: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 20),
                          InkWell(
                            onTap: () {
                              _onSearch();
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.07,
                              height: MediaQuery.of(context).size.height * 0.05,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: AppColors.dakLightGreen,
                              ),
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
                              ),
                            ),
                          ),
                          SizedBox(width: 20),
                          InkWell(
                            onTap: () {
                              _onClear();
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.07,
                              height: MediaQuery.of(context).size.height * 0.05,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: Colors.redAccent,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Clear",
                                    style: GoogleFonts.ubuntu(
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: Column(
                            children: [
                              _filteredUsers.isEmpty
                                  ? Container(
                                child: Center(
                                  child: Text("No Users Found"),
                                ),
                              )
                                  : Container(
                                width: MediaQuery.of(context).size.width,
                                child: PaginatedDataTable(
                                  rowsPerPage: _filteredUsers.length <= 10
                                      ? _filteredUsers.length
                                      : 10,
                                  arrowHeadColor: Colors.red,
                                  columns: [
                                    DataColumn(label: Text("Name")),
                                    DataColumn(label: Text("Approved")),
                                    DataColumn(
                                        label: Text("Achieved")),
                                    DataColumn(label: Text("Phone")),
                                    DataColumn(label: Text("Place")),
                                    DataColumn(
                                        label: Text("Insurance")),
                                    DataColumn(label: Text("Status")),
                                    DataColumn(label: Text("Add Point")),
                                    DataColumn(label: Text("Action")),
                                    DataColumn(label: Text("Delete")),
                                  ],
                                  source: _DataTableSource(
                                    data: _filteredUsers,
                                    context: context,
                                    addPoints: addPoint,
                                    showPopup: showPopup,
                                    toggle: false,
                                    pickPdfFile: pickAndUploadPDF,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _DataTableSource extends DataTableSource {
  final List<UserModel> data;
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
    required this.pickPdfFile,
  });

  @override
  DataRow? getRow(int index) {
    if (index >= data.length) return null;

    final user = data[index];

    return DataRow.byIndex(index: index, cells: [
      DataCell(Text(user.name)),
      DataCell(
        ApproveToggleButton(
          initialToggle: user.isApproved,
          onToggle: (newToggle) {
            FirebaseFirestore.instance
                .collection('users')
                .doc(user.mobileNumber)
                .update({'isApproved': newToggle});
          },
        ),
      ),
      DataCell(
        IsLoyaltyPointAchieved(
          initialToggle: user.isLoyaltyPointAchieved ?? false,
          loyaltyPoints: user.loyaltyPoints ?? 0, // Pass loyaltyPoints
          onToggle: (newToggle) {
            FirebaseFirestore.instance
                .collection('users')
                .doc(user.mobileNumber)
                .update({'isLoyaltyPointAchieved': newToggle});
          },
        ),
      ),
      DataCell(Text(user.mobileNumber)),
      DataCell(Text(user.place)),
      DataCell(
        InkWell(
          onTap: () {
            pickPdfFile(context, user);
          },
          child: Container(
            height: h * 0.04,
            width: w * 0.05,
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
          initialToggle: user.isGoldMember,
          onToggle: (newToggle) {
            FirebaseFirestore.instance
                .collection('users')
                .doc(user.mobileNumber)
                .update({'isGoldMember': newToggle});
          },
        ),
      ),
      DataCell(
        InkWell(
          onTap: () {
            addPoints(context, user);
          },
          child: Container(
            height: h * 0.04,
            width: w * 0.055,
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
            showPopup(context, user);
          },
          child: Container(
            height: h * 0.04,
            width: w * 0.045,
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
                        FirebaseFirestore.instance
                            .collection('users')
                            .doc(user.mobileNumber)
                            .update({'isdeleted': true, 'isApproved': false});
                        Navigator.of(context).pop();
                      },
                      child: Text('OK'),
                    ),
                  ],
                );
              },
            );
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
        height: 20,
        width: 40,
        decoration: BoxDecoration(
          color: toggle ? Colors.green : Colors.black12,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.black45),
        ),
        child: Stack(
          children: [
            AnimatedPositioned(
              curve: Curves.easeInOut,
              right: toggle ? 0 : 20,
              left: toggle ? 20 : 0,
              duration: Duration(milliseconds: 300),
              child: AnimatedContainer(
                curve: Curves.easeInOut,
                height: 18,
                width: 18,
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

class IsLoyaltyPointAchieved extends StatefulWidget {
  final bool initialToggle;
  final int loyaltyPoints; // Add loyaltyPoints parameter
  final Function(bool) onToggle;

  IsLoyaltyPointAchieved({
    required this.initialToggle,
    required this.loyaltyPoints, // Initialize loyaltyPoints
    required this.onToggle,
  });

  @override
  _IsLoyaltyPointAchieved createState() => _IsLoyaltyPointAchieved();
}

class _IsLoyaltyPointAchieved extends State<IsLoyaltyPointAchieved> {
  late bool toggle;

  @override
  void initState() {
    super.initState();
    toggle = widget.initialToggle || widget.loyaltyPoints >= 120;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        setState(() {
          toggle = !toggle;
        });

        // Check if loyaltyPoints is 120 or more
        if (widget.loyaltyPoints >= 120) {
          // Update the isGoldMember field in the database
          await FirebaseFirestore.instance
              .collection('users')
              .doc('your-user-id') // Replace with actual user ID
              .update({'isGoldMember': true});
        }

        widget.onToggle(toggle);
      },
      child: Container(
        height: 20,
        width: 40,
        decoration: BoxDecoration(
          color: toggle ? Colors.green : Colors.black12,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.black45),
        ),
        child: Stack(
          children: [
            AnimatedPositioned(
              curve: Curves.easeInOut,
              right: toggle ? 0 : 20,
              left: toggle ? 20 : 0,
              duration: Duration(milliseconds: 300),
              child: AnimatedContainer(
                curve: Curves.easeInOut,
                height: 18,
                width: 18,
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

class IsChannelPartnrReccommended extends StatefulWidget {
  final bool initialToggle;
  final Function(bool) onToggle;

  IsChannelPartnrReccommended(
      {required this.initialToggle, required this.onToggle});

  @override
  _IsChannelPartnrReccommended createState() => _IsChannelPartnrReccommended();
}

class _IsChannelPartnrReccommended
    extends State<IsChannelPartnrReccommended> {
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
        height: 20,
        width: 40,
        decoration: BoxDecoration(
          color: toggle ? Colors.green : Colors.black12,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.black45),
        ),
        child: Stack(
          children: [
            AnimatedPositioned(
              curve: Curves.easeInOut,
              right: toggle ? 0 : 20,
              left: toggle ? 20 : 0,
              duration: Duration(milliseconds: 300),
              child: AnimatedContainer(
                curve: Curves.easeInOut,
                height: 18,
                width: 18,
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

class IsSupportGeften extends StatefulWidget {
  final bool initialToggle;
  final Function(bool) onToggle;

  IsSupportGeften({required this.initialToggle, required this.onToggle});

  @override
  _IsSupportGeften createState() => _IsSupportGeften();
}

class _IsSupportGeften extends State<IsSupportGeften> {
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
        height: 20,
        width: 40,
        decoration: BoxDecoration(
          color: toggle ? Colors.green : Colors.black12,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.black45),
        ),
        child: Stack(
          children: [
            AnimatedPositioned(
              curve: Curves.easeInOut,
              right: toggle ? 0 : 20,
              left: toggle ? 20 : 0,
              duration: Duration(milliseconds: 300),
              child: AnimatedContainer(
                curve: Curves.easeInOut,
                height: 18,
                width: 18,
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
              duration: Duration(milliseconds: 400),
              child: Center(
                child: Text(
                  toggle ? "Gold " : "Silver",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: w * 0.006,
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

