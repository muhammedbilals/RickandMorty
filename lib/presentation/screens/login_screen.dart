import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:machinetest/core/colors/colors.dart';
import 'package:machinetest/core/constant/constant.dart';
import 'package:machinetest/presentation/screens/home_screen.dart';
import 'package:machinetest/presentation/widgets/textfieldsignup.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                const SizedBox(
                  height: 250,
                ),
                const Center(
                  child: Text(
                    'Login to Account',
                    style: TextStyle(fontSize: 30),
                  ),
                ),
                sbox,
                sbox,
                // const SizedBox(
                //   height: 100,
                // ),
                TextFieldSignUp(
                

                    formKey: formKey,
                    selection: 1,
                    controller: emailController,
                    icon: Icons.email,
                    title: 'Username'),
                sbox,
                TextFieldSignUp(
              controller: passwordController,
                  
                  icon: Icons.password,
                  title: 'Password',
                ),
                sbox,
                sbox,

                InkWell(
                  onTap: () async {
                    if (emailController.text == 'admin' &&
                        passwordController.text == 'password') {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HomeScreen(),
                        ),
                      );
                    } else {
                      const snackBar =SnackBar(
                          content: Text('wrong username or password'));
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      log('wrong password');
                    }
                  },
                  child: Container(
                    width: size.width * 0.9,
                    height: size.width * 0.13,
                    decoration: BoxDecoration(
                        border: Border.all(color: colorgrey),
                        borderRadius: BorderRadius.circular(20),
                        color: colorwhite),
                    child: const Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          'Log In',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                  ),
                ),
                sbox,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
