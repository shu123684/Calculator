import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:calculator/Chat/api/apis.dart';
import 'package:calculator/Chat/helper/dialogs.dart';
import 'package:calculator/Chat/models/chat_user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';

import '../../main.dart';

class ProfileScreen extends StatefulWidget {
  final ChatUser user;

  const ProfileScreen({super.key, required this.user});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _image;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // For hiding keyboard
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        //Appbar
        appBar: AppBar(
          title: Text("Profile Screen"),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(4.0),
            child: Container(
              color: Theme.of(context).primaryColor.withOpacity(0.4),
              height: 2.3,
              margin: EdgeInsets.only(left: 2, right: 2),
            ),
          ),
        ),

        //floatingActionButton
        floatingActionButton: Padding(
          padding: EdgeInsets.only(bottom: 10, right: 5),
          child: FloatingActionButton.extended(
            backgroundColor: Colors.redAccent,
            onPressed: () async {
              // For showing progress dialog
              Dialogs.showProgressBar(context);

              await APIs.auth.signOut().then((value) async {
                await GoogleSignIn().signOut().then((value) {
                  // For hiding progress bar
                  Navigator.pop(context);

                  // For moving to home screen
                  Navigator.pop(context);

                  // For moving to login screen
                  Navigator.pushReplacementNamed(context, '/loginScreen');
                });
              });
            },
            icon: Icon(Icons.logout),
            label: Text("Logout"),
          ),
        ),

        //body
        body: Form(
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: mq.width * 0.05),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // For adding some space
                  SizedBox(width: mq.width, height: mq.height * 0.03),

                  // user profile picture
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      // Profile Picture
                      _image != null
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(
                                mq.height * 0.075,
                              ),
                              child: Image.file(
                                File(_image!),
                                width: mq.height * 0.15,
                                height: mq.height * 0.15,
                                fit: BoxFit.cover,
                              ),
                            )
                          : ClipRRect(
                              borderRadius: BorderRadius.circular(
                                mq.height * 0.075,
                              ),
                              child: CachedNetworkImage(
                                width: mq.height * 0.15,
                                height: mq.height * 0.15,
                                fit: BoxFit.cover,
                                imageUrl: widget.user.image,
                                placeholder: (context, url) =>
                                    CircularProgressIndicator(),
                                errorWidget: (context, url, error) =>
                                    const CircleAvatar(
                                      child: Icon(CupertinoIcons.person),
                                    ),
                              ),
                            ),

                      // Edit image button
                      Positioned(
                        bottom: 0,
                        right: -9,
                        child: MaterialButton(
                          elevation: 1,
                          onPressed: () {
                            _showBottomSheet();
                          },
                          shape: CircleBorder(),
                          color: Colors.white70,
                          minWidth: 34,
                          height: 34,
                          child: Icon(
                            Icons.edit,
                            color: Colors.purple.shade400,
                            size: 20,
                          ),
                        ),
                      ),
                    ],
                  ),

                  // Space after image Note: Recompile with -Xlint:deprecation for details.
                  SizedBox(height: mq.height * 0.03),

                  Text(
                    widget.user.email,
                    style: TextStyle(
                      fontSize: 16,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),

                  SizedBox(height: mq.height * 0.05),

                  // Name
                  TextFormField(
                    initialValue: widget.user.name,
                    onSaved: (val) => APIs.me.name = val ?? '',
                    validator: (val) =>
                        val != null && val.isNotEmpty ? null : 'Required Field',
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.person),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      hintText: 'Enter your name',
                      labelText: 'Name',
                    ),
                  ),

                  SizedBox(height: mq.height * 0.02),

                  // About
                  TextFormField(
                    initialValue: widget.user.about,
                    onSaved: (val) => APIs.me.about = val ?? '',
                    validator: (val) =>
                        val != null && val.isNotEmpty ? null : 'Required Field',
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.info_outline),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                      hintText: 'eg. Feeling Happy',
                      labelText: 'About',
                    ),
                  ),

                  SizedBox(height: mq.height * 0.05),

                  // Update Button
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: APIs.themeManager == ThemeMode.dark
                          ? Colors.blue
                          : Colors.deepPurpleAccent.shade400,
                      shape: StadiumBorder(),
                      minimumSize: Size(mq.width * 0.44, mq.height * 0.06),
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        APIs.updateUserInfo().then((value) {
                          Dialogs.showSnackBar(
                            context,
                            'Profile Updated Successfully',
                          );
                        });
                      }
                    },
                    label: const Text("Update", style: TextStyle(fontSize: 16)),
                    icon: const Icon(Icons.edit, size: 28),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // bottom sheet for picking a profile picture  for user
  void _showBottomSheet() {
    showModalBottomSheet(
      backgroundColor: APIs.themeManager == ThemeMode.light
          ? Colors.white
          : Colors.black38,
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      builder: (_) {
        return ListView(
          shrinkWrap: true,
          padding: EdgeInsets.only(
            top: mq.height * 0.03,
            bottom: mq.height * 0.05,
          ),
          children: [
            Text(
              'Pick Profile Picture',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: Theme.of(context).primaryColor,
              ),
            ),

            SizedBox(height: mq.height * 0.02),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor,
                    shape: CircleBorder(),
                    fixedSize: Size(mq.width * 0.3, mq.height * 0.15),
                  ),
                  onPressed: () async {
                    final ImagePicker picker = ImagePicker();
                    // Pick an image.
                    final XFile? image = await picker.pickImage(
                      source: ImageSource.gallery,
                    );
                    if (image != null) {
                      setState(() {
                        _image = image.path;
                      });
                      // For hiding Bottom Sheet
                      Navigator.pop(context);
                    }
                  },
                  child: Image.asset('images/add_image.png'),
                ),

                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor,
                    shape: CircleBorder(),
                    fixedSize: Size(mq.width * 0.3, mq.height * 0.15),
                  ),
                  onPressed: () async{
                    final ImagePicker picker = ImagePicker();
                    // Pick an image.
                    final XFile? image = await picker.pickImage(
                      source: ImageSource.camera,
                    );
                    if (image != null) {
                      setState(() {
                        _image = image.path;
                      });
                      // For hiding Bottom Sheet
                      Navigator.pop(context);
                    }
                  },
                  child: Image.asset('images/camera.png'),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
