import 'package:flutter/material.dart';
import 'package:hedeyety2/app_colors.dart';
import 'package:hedeyety2/models/gift.dart';
import 'package:hedeyety2/reusables/app_bar.dart';
import '../reusables/drawer.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:permission_handler/permission_handler.dart';

class GiftDetails extends StatefulWidget {
  final bool isDarkMode;
  const GiftDetails({super.key, required this.isDarkMode});

  @override
  State<GiftDetails> createState() => _GiftDetailsState(isDarkMode: isDarkMode);
}

class _GiftDetailsState extends State<GiftDetails> {
  final bool isDarkMode;
  final _formKey = GlobalKey<FormState>();

  TextEditingController _giftNameController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _priceController = TextEditingController();

  String? _imagePath; // Holds the selected image path

  _GiftDetailsState({required this.isDarkMode});



  Future<void> _pickImage() async {
    // Check and request permission
    if (await _requestStoragePermission()) {
      try {
        final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
        if (pickedFile != null) {
          setState(() {
            _imagePath = pickedFile.path;
          });
        }
      } catch (e) {
        print("Error picking image: $e");
      }
    } else {
      print("Permission denied");
    }
  }

  Future<bool> _requestStoragePermission() async {
    PermissionStatus storagePermission = await Permission.storage.request();
    PermissionStatus cameraPermission = await Permission.camera.request();

    if (storagePermission.isGranted && cameraPermission.isGranted) {
      return true;
    } else {
      if (storagePermission.isDenied || cameraPermission.isDenied) {
        print("Storage or Camera permission is denied");
      }
      if (storagePermission.isPermanentlyDenied || cameraPermission.isPermanentlyDenied) {
        print("Storage or Camera permission is permanently denied");
      }
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(showProfilePicture: true, title: "Gift Details", isDarkMode: isDarkMode),
      drawer: MyDrawer(theme: isDarkMode),
      backgroundColor: isDarkMode ? AppColors.primaryDark : AppColors.primaryLight,
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(28.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.card_giftcard,
                      color: isDarkMode ? AppColors.textColor : AppColors.primaryDark,
                      size: 50,
                    ),
                    Spacer(),
                    Stack(
                      children: [
                        CircleAvatar(
                          radius: 90,
                          backgroundImage: _imagePath != null
                              ? FileImage(File(_imagePath!))
                              : AssetImage("images/Playstation 5.jpeg") as ImageProvider,
                          child: Align(
                            alignment: Alignment.bottomRight,
                            child: GestureDetector(
                              onTap: _pickImage,
                              child: CircleAvatar(
                                radius: 24,
                                backgroundColor: isDarkMode ? AppColors.thirdDark : Colors.white,
                                child: Icon(
                                  Icons.camera_alt,
                                  color: isDarkMode ? AppColors.textColor : AppColors.primaryDark,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 46),
                TextFormField(
                  style: TextStyle(color: isDarkMode ? AppColors.textColor : AppColors.primaryDark),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter a gift name";
                    }
                    return null;
                  },
                  controller: _giftNameController,
                  decoration: InputDecoration(
                    labelText: "Gift Name",
                    labelStyle: TextStyle(color: isDarkMode ? AppColors.textColor : AppColors.primaryDark),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: isDarkMode ? AppColors.textColor : AppColors.primaryDark),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: isDarkMode ? AppColors.thirdDark : AppColors.primaryDark),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                TextFormField(
                  style: TextStyle(color: isDarkMode ? AppColors.textColor : AppColors.primaryDark),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter a description";
                    }
                    return null;
                  },
                  controller: _descriptionController,
                  decoration: InputDecoration(
                    labelText: "Description",
                    labelStyle: TextStyle(color: isDarkMode ? AppColors.textColor : AppColors.primaryDark),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: isDarkMode ? AppColors.textColor : AppColors.primaryDark),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: isDarkMode ? AppColors.thirdDark : AppColors.primaryDark),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                TextFormField(
                  style: TextStyle(color: isDarkMode ? AppColors.textColor : AppColors.primaryDark),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter a price";
                    }
                    if (double.tryParse(value) == null) {
                      return "Please enter a valid price";
                    }
                    return null;
                  },
                  controller: _priceController,
                  decoration: InputDecoration(
                    labelText: "Price",
                    labelStyle: TextStyle(color: isDarkMode ? AppColors.textColor : AppColors.primaryDark),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: isDarkMode ? AppColors.textColor : AppColors.primaryDark),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: isDarkMode ? AppColors.thirdDark : AppColors.primaryDark),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isDarkMode ? AppColors.thirdDark : AppColors.secondaryDark,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ) ,
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // Save the gift details
                        print("Gift Name: ${_giftNameController.text}");
                        print("Description: ${_descriptionController.text}");
                        print("Price: ${_priceController.text}");
                        print("Image Path: $_imagePath");
                        
                        Navigator.pop(context, Gift(
                            name: _giftNameController.text,
                            description: _descriptionController.text,
                            imageUrl: _imagePath ?? "images/Playstation 5.jpeg",
                            price: _priceController.text,
                            id: "1",
                            requestingUserId: "1",
                            pledgedUserId: "1",
                            isPledged: false,
                            categoryId: "1"));
                      }
                    },
                    child: Text("Save", style: TextStyle(color: isDarkMode ? AppColors.primaryDark : AppColors.textColor),)

                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
