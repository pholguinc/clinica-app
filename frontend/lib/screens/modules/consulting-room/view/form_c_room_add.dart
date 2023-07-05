import 'package:flutter/material.dart';
import 'package:frontend/constants.dart';
import 'package:frontend/models/text_field_form.dart';
import 'package:frontend/screens/modules/consulting-room/view/c_room_screen.dart';
import 'package:frontend/screens/modules/medicines/view/medicine_screen.dart';
import 'package:frontend/widgets/alerts/error_alert.dart';
import 'package:frontend/widgets/alerts/success_alert.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

class FormAddcRoom extends StatefulWidget {
  const FormAddcRoom({Key? key}) : super(key: key);

  @override
  State<FormAddcRoom> createState() => _FormcroomScreenState();
}

class _FormcroomScreenState extends State<FormAddcRoom> {
  // Definiendo control principal del loading del botón de registro

  bool isLoading = false;

  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  // Definimos controladores de los inputs

  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  final numConsultController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  // Agregamos la función haciendo una petición
  // al backend de la lista de doctores

  Future<void> registercRoom() async {
    final Logger logger = Logger();

    String url =
        "http://10.0.2.2:3000/consulting-room/"; // Replace with your actual API URL

    Map<String, String> headers = {
      'Content-Type': 'application/json',
    };

    Map<String, dynamic> requestBody = {
      'name': nameController.text,
      'description': descriptionController.text,
      'numConsult': numConsultController.text,
    };

    try {
      http.Response response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 200) {
        logger.d("correcto");
      } else {
        logger.d("error");
      }
    // ignore: empty_catches
    } catch (error) {}
    nameController.clear();
    descriptionController.clear();
    numConsultController.clear();
  }

  void showSuccessNotification(BuildContext context) {
    const SuccessAlert().show(context);
  }

  void showErrorNotification(BuildContext context) {
    const ErrorAlert().show(context);
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
          'Agregar Medicina',
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
        automaticallyImplyLeading: false,
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
                              key: formKey,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              child: Column(
                                children: [
                                  TextFieldForm(
                                    controller: nameController,
                                    fieldName: 'Nombre',
                                    icon: Icons.local_hospital,
                                    prefixIconColor: colorPrimary,
                                    textValidator: 'Rellene los campos vacíos',
                                  ),
                                  const SizedBox(height: 20.0),
                                  TextFieldForm(
                                    controller: descriptionController,
                                    fieldName: 'Descripción',
                                    icon: Icons.description,
                                    prefixIconColor: colorPrimary,
                                    textValidator: 'Rellene los campos vacíos',
                                  ),
                                  const SizedBox(height: 20.0),
                                  TextFieldForm(
                                    controller: numConsultController,
                                    fieldName: 'Descripción',
                                    icon: Icons.description,
                                    prefixIconColor: colorPrimary,
                                    textValidator: 'Rellene los campos vacíos',
                                  ),
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
                                            final currentContext = context;
                                            final isValidForm = formKey
                                                .currentState!
                                                .validate();

                                            if (isValidForm) {
                                              if (isLoading) return;

                                              setState(() => isLoading = true);
                                              await Future.delayed(
                                                  const Duration(seconds: 2));
                                              registercRoom();
                                              setState(() => isLoading = false);
                                              hideKeyboard();
                                              // ignore: use_build_context_synchronously
                                              Navigator.push(
                                                currentContext,
                                                MaterialPageRoute(
                                                  builder:
                                                      (BuildContext context) {
                                                    return Builder(
                                                      builder: (BuildContext
                                                          context) {
                                                        return const CroomScreen();
                                                      },
                                                    );
                                                  },
                                                ),
                                              );
                                              // ignore: use_build_context_synchronously
                                              showSuccessNotification(context);
                                            } else {
                                              showErrorNotification(context);
                                            }
                                          })),
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
