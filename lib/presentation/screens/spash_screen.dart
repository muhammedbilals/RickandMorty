import 'package:flutter/material.dart';
import 'package:machinetest/core/colors/colors.dart';
import 'package:machinetest/presentation/screens/login_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    Future.delayed(
      const Duration(seconds: 3),
      () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) =>  LoginPage(),
          ),
        );
      },
    );
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: size.width * 0.9,
              width: size.width * 0.9,
              child: Image.asset('assets/images/rickyandmorty.png'),
            ),
            const Text(
              'Ricky and Morty',
              style: TextStyle(color: colorblack, fontSize: 25),
            ),
          ],
        ),
      ),
    );
  }
}
