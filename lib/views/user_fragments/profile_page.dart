import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:seat_easy/components/my_button.dart';
import 'package:seat_easy/components/my_snack_bar.dart';
import 'package:seat_easy/components/my_textfield.dart';
import 'package:seat_easy/services/auth/auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  File? _imageFile; // To store the selected image
  final ImagePicker _picker = ImagePicker(); // Image picker instance

  late final TextEditingController _name;
  late final TextEditingController _phone;

  @override
  void initState() {
    super.initState();

    _name = TextEditingController();
    _phone = TextEditingController();

    // Fetch user data on initialization
    _fetchUserData();
  }

  @override
  void dispose() {
    _name.dispose();
    _phone.dispose();
    super.dispose();
  }

  // Function to pick image from gallery
  Future<void> _pickImageFromGallery() async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  // Function to fetch user data from Firestore
  Future<void> _fetchUserData() async {
    final String userId = AuthService.firebase().currentUser!.id;

    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('UserDB')
          .where('UserId', isEqualTo: userId)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        // Extract the first document's data
        final userData =
            querySnapshot.docs.first.data() as Map<String, dynamic>;

        // Set data to the text fields
        setState(() {
          _name.text = userData['UserName'] ?? '';
          _phone.text = userData['Phone'] ?? '';
        });
      } else {
        print('No user found with the given UserId.');
      }
    } catch (e) {
      print('Error fetching user data: $e');
      showMySnackBar(
        context: context,
        message: 'Failed to fetch user data. Please try again.',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Image Display Section
              GestureDetector(
                onTap: _pickImageFromGallery,
                child: Container(
                  height: 150,
                  width: 150,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: _imageFile != null
                      ? Image.file(
                          _imageFile!,
                          fit: BoxFit.cover,
                        )
                      : const Center(child: Text("No Image Selected")),
                ),
              ),

              const SizedBox(height: 25),

              Text(
                AuthService.firebase().currentUser!.email,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),

              const SizedBox(height: 32),

              // Text fields for Name and Phone
              MyTextField(
                controller: _name,
                hintText: 'Name',
                textInputType: TextInputType.text,
                obscureText: false,
              ),

              const SizedBox(height: 32),

              MyTextField(
                controller: _phone,
                hintText: 'Phone',
                textInputType: TextInputType.text,
                obscureText: false,
              ),

              const SizedBox(height: 50),

              // Update Button
              MyButton(
                onTap: () {
                  _updateUserInfo();
                },
                text: 'Update Your Info',
                isEnabled: true,
              ),

              const SizedBox(height: 50),

              const Text(
                'Send mail to us: admin@seateay.com',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Function to update user info in Firestore
  Future<void> _updateUserInfo() async {
    final String userId = AuthService.firebase().currentUser!.id;

    try {
      await FirebaseFirestore.instance
          .collection('UserDB')
          .doc(userId) // Assuming `UserId` is the document ID
          .update({
        'UserName': _name.text,
        'Phone': _phone.text,
      });

      showMySnackBar(
        context: context,
        message: 'User info updated successfully!',
      );
    } catch (e) {
      print('Error updating user info: $e');
      showMySnackBar(
        context: context,
        message: 'Failed to update user info. Please try again.',
      );
    }
  }

  void showMySnackBar(
      {required BuildContext context, required String message}) {}
}
