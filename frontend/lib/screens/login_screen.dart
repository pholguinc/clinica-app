import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend/screens/data_scrren.dart';
import 'package:frontend/screens/home_screen.dart';
import 'package:frontend/utils/preferences.dart';
import 'package:frontend/widgets/animated_textfield.dart';
import 'package:frontend/widgets/home_content.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/custom_clip_path.dart';
import 'package:http/http.dart' as http;

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  bool isLoading = false;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  late SharedPreferences pref;
  late BuildContext loginContext;

  @override
  void initState() {
    super.initState();
    initializePreferences(); // Call the method to initialize prefs
  }

  Future<void> initializePreferences() async {
    pref = await SharedPreferences.getInstance();
  }

  Future<void> login() async {
    if (emailController.text.isNotEmpty && passwordController.text.isNotEmpty) {
      var reqBody = {
        "email": emailController.text,
        "password": passwordController.text
      };

      var response = await http.post(
          Uri.parse('http://10.0.2.2:3000/auth/login'),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(reqBody));

      var jsonResponse = jsonDecode(response.body);


    if (response.statusCode == 200) {
      var token = jsonResponse['access_token'];
      await pref.setString('access_token', token);

      navigateToHomeContent(token);
    } 

      var token = jsonResponse['access_token'];
      await pref.setString('access_token', token);

      navigateToHomeContent(token);
    }else{
      print("error login");
    }
  }

void navigateToHomeContent(String token) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => HomeScreen(token: token), // Pass the name argument here
    ),
  );
}



  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    loginContext = context;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              width: width,
              height: height * 0.4,
              child: ClipPath(
                clipper: CustomClipPath(), // Custom clipper class
                child: Image.asset(
                  "assets/images/bg-login.jpg",
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              width: width,
              margin: const EdgeInsets.only(left: 20, right: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Transform(
                    transform: Matrix4.translationValues(0.0, -40.0, 0.0),
                    child: Text(
                      "Bienvenido",
                      style: GoogleFonts.poppins(
                          fontSize: 40, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 20),
                  AnimatedTextField(
                      label: "E-mail",
                      suffix: null,
                      obscureText: false,
                      textCtrl: emailController),
                  const SizedBox(height: 20),
                  AnimatedTextField(
                    label: "Password",
                    suffix: null,
                    obscureText: true,
                    textCtrl: passwordController,
                  ),
                ],
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: ElevatedButton(
                  onPressed: () {
                    login();
                  },
                  style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.zero,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20))),
                  child: Ink(
                    decoration: BoxDecoration(
                        gradient: const LinearGradient(
                            colors: [Colors.red, Colors.yellow]),
                        borderRadius: BorderRadius.circular(20)),
                    child: SizedBox(
                        width: 300,
                        height: 50,
                        child: isLoading
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 3,
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                          Colors.white),
                                    ),
                                  ),
                                  const SizedBox(width: 24),
                                  Text("Espere un momento...",
                                      style: GoogleFonts.poppins(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          fontStyle: FontStyle.italic)),
                                ],
                              )
                            : Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Iniciar Sesión",
                                    style: GoogleFonts.poppins(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600,
                                        fontStyle: FontStyle.italic),
                                  ),
                                ],
                              )),
                  ),
                ),
              ),
            ),
            SizedBox(height: width * 0.08),
            RichText(
                text: TextSpan(
                    text: "¿No tienes una cuenta?",
                    style: GoogleFonts.poppins(
                        fontSize: 16,
                        color: Colors.grey,
                        fontWeight: FontWeight.w500),
                    children: [
                  TextSpan(
                      text: "  Crea una aquí",
                      style: GoogleFonts.poppins(
                          fontSize: 16,
                          color: Colors.blue,
                          fontWeight: FontWeight.w500))
                ]))
          ],
        ),
      ),
    );
  }
}
