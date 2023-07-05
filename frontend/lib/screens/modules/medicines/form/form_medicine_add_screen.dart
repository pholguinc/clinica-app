import 'package:flutter/material.dart';
import 'package:flutter_flushbar/flutter_flushbar.dart';
import 'package:frontend/models/medicine_model.dart';
import 'package:frontend/models/text_field_form.dart';
import 'package:frontend/screens/home_screen.dart';
import 'package:frontend/screens/modules/medicines/view/medicine_screen.dart';
import 'package:frontend/screens/search_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../animations/page_transition_animation.dart';
import '../../../../constants.dart'; // For date formatting
import 'package:intl/intl.dart';
import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;

import '../../../../models/doctor_model.dart';
import '../../../../models/input_field_doctor.dart';
import 'form_medicine_put_screen.dart';

class FormAddMedicine extends StatefulWidget {
  const FormAddMedicine({Key? key}) : super(key: key);

  @override
  State<FormAddMedicine> createState() => _FormAddDateState();
}

class _FormAddDateState extends State<FormAddMedicine> {
  // Definiendo control principal del loading del botón de registro

  bool isLoading = false;

  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  // Definimos controladores de los inputs

  final nameController = TextEditingController();
  final descriptionController = TextEditingController();

  // Agregamos la función haciendo una petición
  // al backend de la lista de doctores

  Future<void> registerMedicine() async {
    String url =
        "http://10.0.2.2:3000/medicines/"; // Replace with your actual API URL

    Map<String, String> headers = {
      'Content-Type': 'application/json',
    };

    Map<String, dynamic> requestBody = {
      'name': nameController.text,
      'description': descriptionController.text,
    };

    try {
      http.Response response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 200) {
        // Medicine registered successfully
        // You can handle the response here if needed
      } else {
        // Error registering medicine
        // You can handle the error response here if needed
      }
    } catch (error) {
      // Exception occurred while making the request
      // You can handle the error here
    }
    nameController.clear();
    descriptionController.clear();
  }


  void showSuccessNotification() {
    Flushbar(
      flushbarPosition: FlushbarPosition.TOP,
      borderRadius: BorderRadius.circular(10),
      backgroundColor: const Color.fromARGB(255, 88, 170, 21),
      duration: const Duration(seconds: 2),
      icon: const Icon(
        Icons.check_circle,
        color: Colors.white,
      ),
      titleText: const Text(
        "¡Éxito!",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20.0,
          color: Colors.white,
          fontFamily: "ShadowsIntoLightTwo",
        ),
      ),
      messageText: const Text(
        "El registro fue eliminado correctamente",
        style: TextStyle(
          fontSize: 16.0,
          color: Colors.white,
          fontFamily: "ShadowsIntoLightTwo",
        ),
      ),
    ).show(context);
  }
  // Hacemos llamado a las funciones definidas

void hideKeyboard() {
  FocusManager.instance.primaryFocus?.unfocus();
}
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
              context,
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) =>
                    const MedicineScreen(),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                  const begin = Offset(-1.0, 0.0);
                  const end = Offset.zero;
                  const curve = Curves.ease;
                  final tween = Tween(begin: begin, end: end)
                      .chain(CurveTween(curve: curve));
                  return SlideTransition(
                    position: animation.drive(tween),
                    child: child,
                  );
                },
              ),
            );
          },
        ),
        title: Text(
          'Agendar cita',
          style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.only(right: 5.0),
              child: IconButton(
                icon: const Icon(Icons.menu),
                onPressed: () {
                  scaffoldKey.currentState?.openDrawer();
                },
              ),
            ),
          ),
        ],
        centerTitle: true,
        backgroundColor: colorPrimary,
        automaticallyImplyLeading: false, // Remove the default back button
      ),
      body: SingleChildScrollView(
        child: Builder(
          builder: (BuildContext context) {
            return SizedBox(
              width: MediaQuery.of(context).size.width,
              height: double.maxFinite,
              child: Container(
                padding: const EdgeInsets.only(top: 30),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height - 100,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50),
                  ),
                  color: Colors.white,
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Form(
                              child: Column(
                                children: [
                                  TextFieldForm(
                                      controller: nameController,
                                      fieldName: 'Nombre',
                                      icon: Icons.local_hospital,
                                      prefixIconColor: colorPrimary, 
                                      textValidator: '',),
                                  const SizedBox(height: 20.0),
                                  TextFieldForm(
                                      controller: descriptionController,
                                      fieldName: 'Descripción',
                                      icon: Icons.description,
                                      prefixIconColor: colorPrimary, 
                                      textValidator: ''),
                                  const SizedBox(height: 20.0),
                                  Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              textStyle:
                                                  const TextStyle(fontSize: 18),
                                              minimumSize:
                                                  const Size.fromHeight(45),
                                              shape: const StadiumBorder(),
                                              fixedSize: const Size(30, 45),
                                              backgroundColor: colorPrimary),
                                          child: isLoading
                                              ? const Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    SizedBox(
                                                      width:
                                                          20, // Set the desired width of the CircularProgressIndicator
                                                      height:
                                                          20, // Set the desired height of the CircularProgressIndicator
                                                      child:
                                                          CircularProgressIndicator(
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                    SizedBox(width: 24),
                                                    Text('Espere un momento...')
                                                  ],
                                                )
                                              : const Text('Registrar'),
                                          onPressed: () async {
                                            if (isLoading) return;

                                            setState(() => isLoading = true);
                                            await Future.delayed(
                                                const Duration(seconds: 2));
                                            registerMedicine();
                                            setState(() => isLoading = false);
                                            hideKeyboard();
                                            showSuccessNotification();
                                          }))
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
