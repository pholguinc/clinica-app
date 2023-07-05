import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:frontend/controllers/auth_controller.dart';

import '../constants.dart';
import 'input_container.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({
    Key? key,
    required this.isLogin,
    required this.animationDuration,
    required this.size,
    required this.defaultLoginSize,
  }) : super(key: key);

  final bool isLogin;
  final Duration animationDuration;
  final Size size;
  final double defaultLoginSize;

  @override
  LoginFormState createState() => LoginFormState();
}

class LoginFormState extends State<LoginForm> {
  
  AuthController authController = AuthController();



  @override
  void dispose() {
    super.dispose();
  }

  

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: widget.isLogin ? 1.0 : 0.0,
      duration: widget.animationDuration * 4,
      child: Align(
        alignment: Alignment.center,
        child: SizedBox(
          width: widget.size.width,
          height: widget.defaultLoginSize,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Welcome Back',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                ),
                const SizedBox(height: 40),
                SvgPicture.asset(
                  'assets/images/doctor-login.svg',
                  width: 150,
                  height: 150,
                ),
                const SizedBox(height: 40),
                InputContainer(
                  child: TextField(
                    controller: authController.emailController,
                    keyboardType: TextInputType.emailAddress,
                    autofocus: false,
                    cursorColor: logPrimaryColor,
                    decoration: const InputDecoration(
                      icon: Icon(Icons.email, color: logPrimaryColor),
                      hintText: 'Email',
                      border: InputBorder.none,
                    ),
                    onChanged: (value) {
                      setState(() {
                        authController.emailController.text = value;
                      });
                    },
                  ),
                ),
                InputContainer(
                  child: TextField(
                    cursorColor: logPrimaryColor,
                    controller: authController.passwordController,
                    decoration: const InputDecoration(
                      icon: Icon(Icons.lock, color: logPrimaryColor),
                      hintText: 'Password',
                      border: InputBorder.none,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                GestureDetector(
                  onTap: () {
                    authController.loginUser();
                  },
                  child: Container(
                    width: widget.size.width * 0.8,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: logPrimaryColor,
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    alignment: Alignment.center,
                    child: const Text(
                      'Login',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


