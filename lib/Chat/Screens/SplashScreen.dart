import 'package:calculator/Chat/api/apis.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import '../../../../main.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 1500), () {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
      SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
      );
      if(APIs.auth.currentUser == null){
        Navigator.pushReplacementNamed(context, '/loginScreen');}
      else{
        Navigator.pushReplacementNamed(context, '/chattingScreen');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;
    return Scaffold(
      // body
      body: Stack(
        children: [
          Positioned(
            top: mq.height * 0.3,
            right: mq.width * 0.24,
            width: mq.width * 0.5,
            child: Image.asset('images/keys.png'),
          ),
          Positioned(
            bottom: mq.height * 0.2,
            left: mq.width *0.325,
            width: mq.width * 0.9,
            child: Text(
              "Made With ❤️",
              style: TextStyle(
                fontSize: 17.3,
                color: Theme.of(context).primaryColor,
                letterSpacing: .7,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
