import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widgets/custom_clip_path.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
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
                      "Regístrate",
                      style: GoogleFonts.poppins(
                          fontSize: 40, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 20),
                  /*AnimatedTextField(
                    label: "E-mail",
                    suffix: null,
                    obscureText: false,
                    TextController: null,
                  )
                  const SizedBox(height: 20),
                  AnimatedTextField(
                    label: "Password",
                    suffix: null,
                    obscureText: true,
                    TextController: a,
                  ),*/
                ],
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: ElevatedButton(
                  onPressed: () {
                    debugPrint('Hi there');
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
                    child: Container(
                      width: 300,
                      height: 50,
                      alignment: Alignment.center,
                      child: const Text(
                        'Registrar',
                        style: TextStyle(
                            fontSize: 24, fontStyle: FontStyle.italic),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: width * 0.08),
            RichText(
                text: TextSpan(
                    text: "¿Ya tienes una cuenta?",
                    style: GoogleFonts.poppins(
                        fontSize: 16,
                        color: Colors.grey,
                        fontWeight: FontWeight.w500),
                    children: [
                  TextSpan(
                      text: "  Iniciar sesión",
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
