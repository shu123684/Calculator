import 'dart:io';

import 'package:calculator/Chat/api/apis.dart';
import 'package:calculator/Chat/helper/dialogs.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../../main.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isAnimate = false;
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 500), () {
      setState(() {
        _isAnimate = true;
      });
    });
  }

  _handleGoogleBtnClick() {
    // For showing context bar
    Dialogs.showProgressBar(context);

    _signInWithGoogle().then((user) async {
      // for hiding context bar
      Navigator.pop(context);

      if (user != null) {
        print("User: ${user.user}");
        print("UserAdditionalInfo: ${user.additionalUserInfo}");

        if ((await APIs.userExist())) {
          Navigator.pushReplacementNamed(context, '/chattingScreen');
        }else {
          await APIs.createUser().then((value) {
            Navigator.pushReplacementNamed(context, '/chattingScreen');
          });
        }
      }
    });
  }

  Future<UserCredential?> _signInWithGoogle() async {
    try {
      await InternetAddress.lookup('google.com');
      // #docregion CheckAuthorization
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      return await APIs.auth.signInWithCredential(credential);
    } catch (e) {
      print("_signInWithGoogle: $e");
      Dialogs.showSnackBar(context, "Somthing Went Wrong (Check Internet)");
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Welcome to Love Chat"),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(4.0),
          child: Container(
            color: Theme.of(context).primaryColor.withOpacity(0.4),
            height: 2.3,
            margin: EdgeInsets.only(left: 2, right: 2),
          ),
        ),
      ),

      // body
      body: Stack(
        children: [
          AnimatedPositioned(
            top: mq.height * 0.15,
            right: _isAnimate ? mq.width * 0.24 : -mq.width * 0.5,
            width: mq.width * 0.5,
            duration: const Duration(milliseconds: 1000),
            child: Image.asset('images/keys.png'),
          ),
          Positioned(
            bottom: mq.height * 0.15,
            left: mq.width * 0.05,
            width: mq.width * 0.9,
            height: mq.height * 0.06,
            child: ElevatedButton.icon(
              onPressed: () {
                _handleGoogleBtnClick();
              },
              icon: Image.asset('images/Google.png', height: mq.height * 0.035),
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(
                  context,
                ).primaryColor.withOpacity(0.15),
                shape: StadiumBorder(),
                elevation: 1,
                shadowColor: Colors.black.withOpacity(0.1),
              ),
              label: RichText(
                text: TextSpan(
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 17,
                  ),
                  children: [
                    TextSpan(text: "Sign In with "),
                    TextSpan(
                      text: "Google",
                      style: TextStyle(fontWeight: FontWeight.bold),
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
