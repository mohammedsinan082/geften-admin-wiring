import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:file_picker/file_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../model/adv_model.dart';
import '../../../../core/constants/Appcolor.dart';

class AdvertisementPage extends StatefulWidget {
  const AdvertisementPage({super.key});

  @override
  State<AdvertisementPage> createState() => _AdvertisementPageState();
}

class _AdvertisementPageState extends State<AdvertisementPage> {
  bool isLoading = false;
  Uint8List? pickedImageBytes;
  String? pickedImageName;
  String description = '';

  Future<void> pickImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      withData: true,
    );

    if (result != null && result.files.single.bytes != null) {
      setState(() {
        pickedImageBytes = result.files.single.bytes;
        pickedImageName = result.files.single.name;
      });
    }
  }

  Future<void> uploadImage() async {
    if (pickedImageBytes == null || pickedImageName == null) return;

    setState(() {
      isLoading = true;
    });

    try {
      final storageRef = FirebaseStorage.instance.ref().child('advertisements/$pickedImageName');
      final uploadTask = storageRef.putData(pickedImageBytes!);

      final snapshot = await uploadTask.whenComplete(() {});

      final url = await snapshot.ref.getDownloadURL();

      if (await Advertisement.isUrlDuplicate(url)) {
        setState(() {
          isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Duplicate URL found!')));
      } else {
        final adCount = await FirebaseFirestore.instance.collection('advertisements').get().then((value) => value.size + 1);
        final ad = Advertisement(
          id: 'Advertisement $adCount',
          imageUrl: url,
          description: description,
        );

        await ad.saveToFirestore();

        setState(() {
          isLoading = false;
          pickedImageBytes = null;
          pickedImageName = null;
          description = '';
        });

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Upload and save successful!')));
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Upload failed: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Advertisement Page'),
      ),
      body: Center(
        child: isLoading
            ? CircularProgressIndicator()
            : Container(
          height: MediaQuery.of(context).size.height * 0.7,
          width: MediaQuery.of(context).size.width * 0.45,
          decoration: BoxDecoration(
            border: Border.all(width: 5, color: AppColors.darkGreen),
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.02,),
                Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                  ),
                  child: pickedImageBytes != null
                      ? Image.memory(pickedImageBytes!, fit: BoxFit.cover)
                      : Center(child: Text('No image selected')),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: pickImage,
                  child: Text('Pick Image',style: TextStyle(color: AppColors.white),),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.dakLightGreen,
                  ),
                ),
                SizedBox(height: 20),
                SizedBox(
                  width: 300, // Adjust the width as needed
                  child: TextFormField(
                    keyboardType: TextInputType.multiline,
                    maxLines: null, // Allows the TextFormField to expand vertically
                    decoration: InputDecoration(labelText: 'Description'),
                    onChanged: (value) {
                      setState(() {
                        description = value;
                      });
                    },
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: pickedImageBytes != null ? uploadImage : null,
                  child: Text('Upload',style: TextStyle(color: Colors.white),),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.dakLightGreen, // Change this to your desired color
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
