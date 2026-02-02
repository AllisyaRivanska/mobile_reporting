import 'dart:async';

import 'package:flutter/material.dart';
// import 'package:mobile_reporting/constant/bottom_bar/bottom_main.dart';
//import 'package:mobile_reporting/features/home/home_page.dart';
import 'package:mobile_reporting/features/login/login_page.dart';
import 'package:flutter_svg/flutter_svg.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 3), () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const LoginPage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 200, 224, 236),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset('assets/icons/logo-unpam.svg',
            width: 150,
    ),

            const SizedBox(height: 20),
            const Text(
              "Campus Report",
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.w800,
                color: Colors.black,
              ),
            ),
            const Text(
              "Laporkan Masalah Kampus \ndengan Mudah",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: Colors.black,  
              )
            ),
          ],
        ),
      ),
    );
  }
}
