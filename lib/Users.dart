import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'main.dart';

class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {

  TextEditingController search=TextEditingController();




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
                                      labelText: 'Search Product',
                                      hintText: 'Please Enter Name',
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
                              borderRadius: BorderRadius.circular(25),
                              color: Color(0xff002859)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Create",
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
                    child:
                       Column(
                          children: [

                            Container(
                              width: w,
                              child:
                              PaginatedDataTable(
                                rowsPerPage: data.length <= 10
                                    ? data.length
                                    : 10,
                                arrowHeadColor: Colors.red,

                                columns: [
                                  DataColumn(
                                    label: Text(
                                      "S.No ",
                                      style: GoogleFonts.workSans(
                                        fontSize: w * 0.010,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                  DataColumn(
                                    label: Text(
                                      "Date ",
                                      style: GoogleFonts.workSans(
                                        fontSize: w * 0.010,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                  DataColumn(
                                    label: Text(
                                      "Brand",
                                      style: GoogleFonts.workSans(
                                        fontSize: w * 0.010,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                  DataColumn(
                                    label: Text(
                                      "Product Name",
                                      style: GoogleFonts.workSans(
                                        fontSize: w * 0.010,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                  DataColumn(
                                    label: Text(
                                      "Action",
                                      style: GoogleFonts.workSans(
                                        fontSize: w * 0.010,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                  DataColumn(
                                    label: Text(
                                      "Delete",
                                      style: GoogleFonts.workSans(
                                        fontSize: w * 0.010,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ],
                                source: ProductView(
                                    productModel: data,
                                    context: context,
                                    ref: ref),
                              ),

                              //   DataTable(
                              //     horizontalMargin: 10,
                              //     columnSpacing: 10,
                              //     headingRowColor: MaterialStateProperty.all(
                              //         Color(0xff002859)),
                              //     columns: [
                              //       DataColumn(
                              //         label: Text(
                              //           "S.No ",
                              //           style: GoogleFonts.workSans(
                              //             fontSize: width * 0.010,
                              //             fontWeight: FontWeight.w700,
                              //             color: Colors.white,
                              //           ),
                              //         ),
                              //       ),
                              //       DataColumn(
                              //         label: Text(
                              //           "Date ",
                              //           style: GoogleFonts.workSans(
                              //             fontSize: width * 0.010,
                              //             fontWeight: FontWeight.w700,
                              //             color: Colors.white,
                              //           ),
                              //         ),
                              //       ),
                              //       DataColumn(
                              //         label: Text(
                              //           "Brand",
                              //           style: GoogleFonts.workSans(
                              //             fontSize: width * 0.010,
                              //             fontWeight: FontWeight.w700,
                              //             color: Colors.white,
                              //           ),
                              //         ),
                              //       ),
                              //       DataColumn(
                              //         label: Text(
                              //           "Product Name",
                              //           style: GoogleFonts.workSans(
                              //             fontSize: width * 0.010,
                              //             fontWeight: FontWeight.w700,
                              //             color: Colors.white,
                              //           ),
                              //         ),
                              //       ),
                              //       DataColumn(
                              //         label: Text(
                              //           "Action",
                              //           style: GoogleFonts.workSans(
                              //             fontSize: width * 0.010,
                              //             fontWeight: FontWeight.w700,
                              //             color: Colors.white,
                              //           ),
                              //         ),
                              //       ),
                              //       DataColumn(
                              //         label: Text(
                              //           "Delete",
                              //           style: GoogleFonts.workSans(
                              //             fontSize: width * 0.010,
                              //             fontWeight: FontWeight.w700,
                              //             color: Colors.white,
                              //           ),
                              //         ),
                              //       ),
                              //     ],
                              //     rows: List.generate(
                              //       data!.length,
                              //           (index) {
                              //         var details = data![index];
                              //         //  String? pdt;
                              //         // try{
                              //         //        pdt=details['productName'];
                              //         //
                              //         // }catch(e){
                              //         //   pdt='';
                              //         // }
                              //
                              //         return DataRow(
                              //           color: index.isOdd ? MaterialStateProperty.all(Colors.blueGrey.shade50.withOpacity(0.7)) : MaterialStateProperty.all(Colors.blueGrey.shade50),
                              //           cells: [
                              //             DataCell(Container(
                              //               width: MediaQuery.of(context).size.width * 0.03,
                              //               child: SelectableText(
                              //                 (ind == 0 ? index + 1 : ind + index + 1).toString(),
                              //                 style: FlutterFlowTheme.bodyText2.override(
                              //                   fontFamily: 'Lexend Deca',
                              //                   color: Colors.black,
                              //                   fontSize: 10,
                              //                   fontWeight: FontWeight.bold,
                              //                 ),
                              //               ),
                              //             )),
                              //             DataCell(Container(
                              //               width: MediaQuery.of(context).size.width * 0.05,
                              //               child: SelectableText(
                              //                 dateTimeFormat('dd-MM-yyyy', details.date!),
                              //                 style: FlutterFlowTheme.bodyText2.override(
                              //                   fontFamily: 'Lexend Deca',
                              //                   color: Colors.black,
                              //                   fontSize: 10,
                              //                   fontWeight: FontWeight.bold,
                              //                 ),
                              //               ),
                              //             )),
                              //             DataCell(
                              //                 SelectableText(
                              //                   details.brandName ?? '',
                              //                   style: FlutterFlowTheme.bodyText2
                              //                       .override(
                              //                     fontFamily: 'Lexend Deca',
                              //                     color: Colors.black,
                              //                     fontSize: 10,
                              //                     fontWeight: FontWeight.bold,
                              //                   ),
                              //                 )),
                              //             //     DataCell(Container(
                              //             //       height: 45,
                              //             //       width: 100,
                              //             //       decoration: BoxDecoration(
                              //             //           image: DecorationImage(
                              //             //               image:
                              //             //                   CachedNetworkImageProvider(
                              //             //                       data['image']
                              //             //                           .toString()),
                              //             //               fit: BoxFit.fill)
                              //             // ),
                              //             //     )),
                              //             DataCell(SelectableText(
                              //               details.productName ?? '',
                              //               style: FlutterFlowTheme.bodyText2.override(
                              //                 fontFamily: 'Lexend Deca',
                              //                 color: Colors.black,
                              //                 fontSize: 11,
                              //                 fontWeight: FontWeight.bold,
                              //               ),
                              //             )),
                              //             DataCell(InkWell(
                              //               onTap: () {
                              //                 Navigator.push(context, MaterialPageRoute(builder: (context) => EditProductCategory(data: details)));
                              //
                              //                 print(details.id);
                              //                 // print(data.shopName);
                              //                 print(
                              //                     '000000000000000000000000000000');
                              //
                              //               },
                              //               child: Container(
                              //                 height: 45,
                              //                 width: 100,
                              //                 decoration: BoxDecoration(
                              //                   borderRadius:
                              //                   BorderRadius.circular(15),
                              //                   color: Color(0xff002859),
                              //                 ),
                              //                 child: Center(
                              //                   child: Text('Edit',
                              //                     style: FlutterFlowTheme.bodyText2.override(
                              //                       fontFamily: 'Lexend Deca',
                              //                       color: Colors.white,
                              //                       fontSize: 14,
                              //                       fontWeight:
                              //                       FontWeight.bold,
                              //                     ),
                              //                   ),
                              //                 ),
                              //               ),
                              //             )),
                              //             DataCell(
                              //               InkWell(
                              //                 onTap: () {
                              //                   showDialog(
                              //                       context: context,
                              //                       builder: (buildcontext) {
                              //                         return AlertDialog(
                              //                           title: Text(
                              //                               'Delete Product',
                              //                               style: GoogleFonts.outfit(
                              //                                   fontWeight:
                              //                                   FontWeight
                              //                                       .w600)),
                              //                           content: const Text(
                              //                               'Do you want to delete?'),
                              //                           actions: [
                              //                             TextButton(
                              //                                 onPressed: () {
                              //                                   Navigator.pop(
                              //                                       context);
                              //                                 },
                              //                                 child: Text(
                              //                                   'Cancel',
                              //                                   style: TextStyle(
                              //                                       color: Colors
                              //                                           .black),
                              //                                 )),
                              //                             TextButton(
                              //                                 onPressed: () {
                              //                                   // FirebaseFirestore
                              //                                   //     .instance
                              //                                   //     .collection(
                              //                                   //     'products')
                              //                                   //     .doc(details
                              //                                   //     .id)
                              //                                   //     .update({
                              //                                   //   'delete':
                              //                                   //   true
                              //                                   // });
                              //
                              //                                   ref.watch(productControllerProvider.notifier).deleteViewProduct(details: details.id!);
                              //                                   showUploadMessage(
                              //                                       context,
                              //                                       'Product Deleted Successfully');
                              //                                   Navigator.pop(
                              //                                       context);
                              //                                 },
                              //                                 child: Text(
                              //                                   'Delete',
                              //                                   style: TextStyle(
                              //                                       color: Colors
                              //                                           .red),
                              //                                 )),
                              //                           ],
                              //                         );
                              //                       });
                              //                   setState(() {});
                              //                 },
                              //                 child: Icon(
                              //                   Icons.delete,
                              //                   color: Colors.red,
                              //                 ),
                              //               ),
                              //             ),
                              //           ],
                              //         );
                              //       },
                              //     ),
                              //   ),
                              // ),
                              // Padding(
                              //   padding: const EdgeInsets.only(top: 10),
                              //   child: Row(
                              //     mainAxisAlignment:
                              //     MainAxisAlignment.spaceAround,
                              //     children: [
                              //       pageIndex == 0
                              //           ? SizedBox()
                              //           : InkWell(
                              //           onTap: () {
                              //             prev();
                              //           },
                              //           child: Row(
                              //             children: [
                              //               Icon(Icons.chevron_left,
                              //                   color: Colors.blue),
                              //               Text(
                              //                 'Prev',
                              //                 style: GoogleFonts.ubuntu(
                              //                     color: Colors.blue),
                              //               )
                              //             ],
                              //           )),
                              //       (lastDoc == null && pageIndex != 0) ||
                              //           data!.length! < limit
                              //           ? SizedBox()
                              //           : InkWell(
                              //         onTap: () {
                              //           next();
                              //         },
                              //         child: Row(
                              //           children: [
                              //             Text('Next',
                              //                 style: GoogleFonts.ubuntu(
                              //                     color: Colors.blue)),
                              //             Icon(
                              //               Icons.chevron_right,
                              //               color: Colors.blue,
                              //             )
                              //           ],
                              //         ),
                              //       )
                              //     ],
                              //   ),
                              // )
                            )
                          ]
                      )

                    // child: StreamBuilder<QuerySnapshot>(
                    //   stream: userStream,
                    //   builder: (context, snapshot) {
                    //     print(snapshot.error);
                    //     if (!snapshot.hasData) {
                    //       return Center(
                    //         child: CircularProgressIndicator(),
                    //       );
                    //     }
                    //
                    //     data = snapshot.data!.docs;
                    //     if (data!.isNotEmpty) {
                    //       lastDoc = snapshot.data?.docs[data!.length - 1];
                    //       lastDocuments[pageIndex] = lastDoc;
                    //       firstDoc = snapshot.data?.docs[0];
                    //       print(data.length.toString());
                    //       print('length');
                    //     }
                    //
                    //     var document = snapshot.data?.docs;
                    //     return Column(
                    //         children: [
                    //       data!.isEmpty
                    //           ? Container(
                    //         child: Center(
                    //           child: Text("No Products Founded"),
                    //         ),
                    //       )
                    //           :
                    //       Container(
                    //         width: width,
                    //         child: DataTable(
                    //           horizontalMargin: 10,
                    //           columnSpacing: 10,
                    //           headingRowColor: MaterialStateProperty.all(
                    //               Color(0xff002859)),
                    //           columns: [
                    //             DataColumn(
                    //               label: Text(
                    //                 "S.No ",
                    //                 style: GoogleFonts.workSans(
                    //                   fontSize: width * 0.010,
                    //                   fontWeight: FontWeight.w700,
                    //                   color: Colors.white,
                    //                 ),
                    //               ),
                    //             ),
                    //             DataColumn(
                    //               label: Text(
                    //                 "Date ",
                    //                 style: GoogleFonts.workSans(
                    //                   fontSize: width * 0.010,
                    //                   fontWeight: FontWeight.w700,
                    //                   color: Colors.white,
                    //                 ),
                    //               ),
                    //             ),
                    //             DataColumn(
                    //               label: Text(
                    //                 "Brand",
                    //                 style: GoogleFonts.workSans(
                    //                   fontSize: width * 0.010,
                    //                   fontWeight: FontWeight.w700,
                    //                   color: Colors.white,
                    //                 ),
                    //               ),
                    //             ),
                    //             DataColumn(
                    //               label: Text(
                    //                 "Product Name",
                    //                 style: GoogleFonts.workSans(
                    //                   fontSize: width * 0.010,
                    //                   fontWeight: FontWeight.w700,
                    //                   color: Colors.white,
                    //                 ),
                    //               ),
                    //             ),
                    //             DataColumn(
                    //               label: Text(
                    //                 "Action",
                    //                 style: GoogleFonts.workSans(
                    //                   fontSize: width * 0.010,
                    //                   fontWeight: FontWeight.w700,
                    //                   color: Colors.white,
                    //                 ),
                    //               ),
                    //             ),
                    //             DataColumn(
                    //               label: Text(
                    //                 "Delete",
                    //                 style: GoogleFonts.workSans(
                    //                   fontSize: width * 0.010,
                    //                   fontWeight: FontWeight.w700,
                    //                   color: Colors.white,
                    //                 ),
                    //               ),
                    //             ),
                    //           ],
                    //           rows: List.generate(
                    //             data!.length,
                    //                 (index) {
                    //               var details = data![index];
                    //               //  String? pdt;
                    //               // try{
                    //               //        pdt=details['productName'];
                    //               //
                    //               // }catch(e){
                    //               //   pdt='';
                    //               // }
                    //
                    //               return DataRow(
                    //                 color: index.isOdd
                    //                     ? MaterialStateProperty.all(Colors
                    //                     .blueGrey.shade50
                    //                     .withOpacity(0.7))
                    //                     : MaterialStateProperty.all(
                    //                     Colors.blueGrey.shade50),
                    //                 cells: [
                    //                   DataCell(Container(
                    //                     width: MediaQuery.of(context)
                    //                         .size
                    //                         .width *
                    //                         0.03,
                    //                     child: SelectableText(
                    //                       (ind == 0
                    //                           ? index + 1
                    //                           : ind + index + 1)
                    //                           .toString(),
                    //                       style: FlutterFlowTheme
                    //                           .bodyText2
                    //                           .override(
                    //                         fontFamily: 'Lexend Deca',
                    //                         color: Colors.black,
                    //                         fontSize: 10,
                    //                         fontWeight: FontWeight.bold,
                    //                       ),
                    //                     ),
                    //                   )),
                    //                   DataCell(Container(
                    //                     width: MediaQuery.of(context)
                    //                         .size
                    //                         .width *
                    //                         0.05,
                    //                     child: SelectableText(
                    //                       dateTimeFormat('dd-MM-yyyy',
                    //                           details['date'].toDate()),
                    //                       style: FlutterFlowTheme
                    //                           .bodyText2
                    //                           .override(
                    //                         fontFamily: 'Lexend Deca',
                    //                         color: Colors.black,
                    //                         fontSize: 10,
                    //                         fontWeight: FontWeight.bold,
                    //                       ),
                    //                     ),
                    //                   )),
                    //                   DataCell(
                    //                       SelectableText(
                    //                     details['brandName'],
                    //                     style: FlutterFlowTheme.bodyText2
                    //                         .override(
                    //                       fontFamily: 'Lexend Deca',
                    //                       color: Colors.black,
                    //                       fontSize: 10,
                    //                       fontWeight: FontWeight.bold,
                    //                     ),
                    //                   )),
                    //                   //     DataCell(Container(
                    //                   //       height: 45,
                    //                   //       width: 100,
                    //                   //       decoration: BoxDecoration(
                    //                   //           image: DecorationImage(
                    //                   //               image:
                    //                   //                   CachedNetworkImageProvider(
                    //                   //                       data['image']
                    //                   //                           .toString()),
                    //                   //               fit: BoxFit.fill)
                    //                   // ),
                    //                   //     )),
                    //                   DataCell(SelectableText(
                    //                     details['productName'],
                    //                     style: FlutterFlowTheme.bodyText2
                    //                         .override(
                    //                       fontFamily: 'Lexend Deca',
                    //                       color: Colors.black,
                    //                       fontSize: 11,
                    //                       fontWeight: FontWeight.bold,
                    //                     ),
                    //                   )),
                    //                   DataCell(InkWell(
                    //                     onTap: () {
                    //                         Navigator.push(
                    //                             context,
                    //                             MaterialPageRoute(
                    //                                 builder: (context) =>
                    //                                     EditProductCategory(
                    //                                         data:
                    //                                         details)));
                    //
                    //                       print(details.id);
                    //                       // print(data.shopName);
                    //                       print(
                    //                           '000000000000000000000000000000');
                    //
                    //                     },
                    //                     child: Container(
                    //                       height: 45,
                    //                       width: 100,
                    //                       decoration: BoxDecoration(
                    //                         borderRadius:
                    //                         BorderRadius.circular(15),
                    //                         color: Color(0xff002859),
                    //                       ),
                    //                       child: Center(
                    //                         child: Text(
                    //                           'Edit',
                    //                           style: FlutterFlowTheme
                    //                               .bodyText2
                    //                               .override(
                    //                             fontFamily: 'Lexend Deca',
                    //                             color: Colors.white,
                    //                             fontSize: 14,
                    //                             fontWeight:
                    //                             FontWeight.bold,
                    //                           ),
                    //                         ),
                    //                       ),
                    //                     ),
                    //                   )),
                    //                   DataCell(
                    //                     InkWell(
                    //                       onTap: () {
                    //                         showDialog(
                    //                             context: context,
                    //                             builder: (buildcontext) {
                    //                               return AlertDialog(
                    //                                 title: Text(
                    //                                     'Delete Product',
                    //                                     style: GoogleFonts.outfit(
                    //                                         fontWeight:
                    //                                         FontWeight
                    //                                             .w600)),
                    //                                 content: const Text(
                    //                                     'Do you want to delete?'),
                    //                                 actions: [
                    //                                   TextButton(
                    //                                       onPressed: () {
                    //                                         Navigator.pop(
                    //                                             context);
                    //                                       },
                    //                                       child: Text(
                    //                                         'Cancel',
                    //                                         style: TextStyle(
                    //                                             color: Colors
                    //                                                 .black),
                    //                                       )),
                    //                                   TextButton(
                    //                                       onPressed: () {
                    //                                         FirebaseFirestore
                    //                                             .instance
                    //                                             .collection(
                    //                                             'products')
                    //                                             .doc(details
                    //                                             .id)
                    //                                             .update({
                    //                                           'delete':
                    //                                           true
                    //                                         });
                    //                                         showUploadMessage(
                    //                                             context,
                    //                                             'Product Deleted Successfully');
                    //                                         Navigator.pop(
                    //                                             context);
                    //                                       },
                    //                                       child: Text(
                    //                                         'Delete',
                    //                                         style: TextStyle(
                    //                                             color: Colors
                    //                                                 .red),
                    //                                       )),
                    //                                 ],
                    //                               );
                    //                             });
                    //                         setState(() {});
                    //                       },
                    //                       child: Icon(
                    //                         Icons.delete,
                    //                         color: Colors.red,
                    //                       ),
                    //                     ),
                    //                   ),
                    //                 ],
                    //               );
                    //             },
                    //           ),
                    //         ),
                    //       ),
                    //       Padding(
                    //         padding: const EdgeInsets.only(top: 10),
                    //         child: Row(
                    //           mainAxisAlignment:
                    //           MainAxisAlignment.spaceAround,
                    //           children: [
                    //             pageIndex == 0
                    //                 ? SizedBox()
                    //                 : InkWell(
                    //                 onTap: () {
                    //                   prev();
                    //                 },
                    //                 child: Row(
                    //                   children: [
                    //                     Icon(Icons.chevron_left,
                    //                         color: Colors.blue),
                    //                     Text(
                    //                       'Prev',
                    //                       style: GoogleFonts.ubuntu(
                    //                           color: Colors.blue),
                    //                     )
                    //                   ],
                    //                 )),
                    //             (lastDoc == null && pageIndex != 0) ||
                    //                 data!.length! < limit
                    //                 ? SizedBox()
                    //                 : InkWell(
                    //               onTap: () {
                    //                 next();
                    //               },
                    //               child: Row(
                    //                 children: [
                    //                   Text('Next',
                    //                       style: GoogleFonts.ubuntu(
                    //                           color: Colors.blue)),
                    //                   Icon(
                    //                     Icons.chevron_right,
                    //                     color: Colors.blue,
                    //                   )
                    //                 ],
                    //               ),
                    //             )
                    //           ],
                    //         ),
                    //       )
                    //     ]);                                                       ///////
                    //   },
                    // ),
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



}
class ProductView extends DataTableSource {

  final BuildContext context;
  // Function set;

  ProductView(
      {
        required this.context,
       });

  @override
  // TODO: implement isRowCountApproximate
  bool get isRowCountApproximate => false;

  @override
  // TODO: implement rowCount
  int get rowCount => 5;

  @override
  // TODO: implement selectedRowCount
  int get selectedRowCount => 0;
  DataRow getRow(int index) {
  //  ProductCategoryModel model=productModel[index];

    return DataRow(
      color: index.isOdd
          ? MaterialStateProperty.all(Colors.grey[50]!.withOpacity(0.9))
          : MaterialStateProperty.all(
          Colors.blueGrey.shade100.withOpacity(0.5)),
      cells: [
        DataCell(
            Container(
              width: MediaQuery.of(context).size.width * 0.03,
              child: SelectableText(
                // ( index + 1 : ind + index + 1).toString(),
                ( index + 1 ).toString(),
              ),
            )),
        DataCell(
            Container(
              width: MediaQuery.of(context).size.width * 0.05,
              child: SelectableText('dd-MM-yyyy'
              ),
            )),
        DataCell(
            SelectableText(
            'ABC'
            )),
        //     DataCell(Container(
        //       height: 45,
        //       width: 100,
        //       decoration: BoxDecoration(
        //           image: DecorationImage(
        //               image:
        //                   CachedNetworkImageProvider(
        //                       data['image']
        //                           .toString()),
        //               fit: BoxFit.fill)
        // ),
        //     )),
        DataCell(
            SelectableText(
               'productname',

            )),
        DataCell(
            InkWell(
              onTap: () {


              },
              child: Container(
                height: 45,
                width: 100,
                decoration: BoxDecoration(
                  borderRadius:
                  BorderRadius.circular(15),
                  color: Color(0xff002859),
                ),
                child: Center(
                  child: Text('Edit',

                  ),
                ),
              ),
            )),
        DataCell(
          InkWell(
            onTap: () {
              showDialog(
                  context: context,
                  builder: (buildcontext) {
                    return AlertDialog(
                      title: Text(
                          'Delete Product',
                          style: GoogleFonts.outfit(
                              fontWeight:
                              FontWeight
                                  .w600)),
                      content: const Text(
                          'Do you want to delete?'),
                      actions: [
                        TextButton(
                            onPressed: () {
                              Navigator.pop(
                                  context);
                            },
                            child: Text(
                              'Cancel',
                              style: TextStyle(
                                  color: Colors
                                      .black),
                            )),
                        TextButton(
                            onPressed: () {
                              // FirebaseFirestore
                              //     .instance
                              //     .collection(
                              //     'products')
                              //     .doc(details
                              //     .id)
                              //     .update({
                              //   'delete':
                              //   true
                              // });

                              Navigator.pop(context);
                            },
                            child: Text(
                              'Delete',
                              style: TextStyle(
                                  color: Colors
                                      .red),
                            )),
                      ],
                    );
                  });
              // setState(() {});
            },
            child: Icon(
              Icons.delete,
              color: Colors.red,
            ),
          ),
        ),
      ],
    );
  }
}
