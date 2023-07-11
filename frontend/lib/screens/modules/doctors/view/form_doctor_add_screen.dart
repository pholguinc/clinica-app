import 'package:flutter/material.dart';
import 'package:frontend/constants.dart';
import 'package:frontend/models/text_field_form.dart';
import 'package:frontend/screens/modules/doctors/view/doctor_screen.dart';
import 'package:frontend/widgets/alerts/error_alert.dart';
import 'package:frontend/widgets/alerts/success_alert.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

class FormAddDoctor extends StatefulWidget {
  const FormAddDoctor({Key? key}) : super(key: key);

  @override
  State<FormAddDoctor> createState() => _FormAddDoctorState();
}

class _FormAddDoctorState extends State<FormAddDoctor>
    with TickerProviderStateMixin {
  bool backPressed = false;
  late AnimationController controllerToIncreasingCurve;
  late AnimationController controllerToDecreasingCurve;

  late Animation<double> animationToIncreasingCurve;
  late Animation<double> animationToDecreasingCurve;

  // Definiendo control principal del loading del botón de registro
  bool isLoading = false;

  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  // Definimos controladores de los inputs
  final nameController = TextEditingController();
  final lastnamePaterController = TextEditingController();
  final lastnameMaterController = TextEditingController();
  final numDocController = TextEditingController();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final roleController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  // Agregamos la función haciendo una petición
  // al backend de la lista de doctores
  Future<void> registerDoctor() async {
    final Logger logger = Logger();

    String url =
        "http://10.0.2.2:3000/users/"; // Replace with your actual API URL

    Map<String, String> headers = {
      'Content-Type': 'application/json',
    };

    Map<String, dynamic> requestBody = {
      'name': nameController.text,
      'lastname_pater': lastnamePaterController.text,
      'lastname_mater': lastnameMaterController.text,
      'num_doc' : numDocController.text,
      'phone': phoneController.text,
      'address': addressController.text,
      'email': emailController.text,
      'password': passwordController.text,
      'role': roleController.text
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
        //logger.d("error");
      }
      // ignore: empty_catches
    } catch (error) {}
    nameController.clear();
    lastnamePaterController.clear();
    lastnameMaterController.clear();
    numDocController.clear();
    phoneController.clear();
    addressController.clear();
    emailController.clear();
    passwordController.clear();
    roleController.clear();
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
    controllerToIncreasingCurve =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    controllerToDecreasingCurve =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));

    animationToIncreasingCurve = Tween<double>(begin: 500, end: 0).animate(
      CurvedAnimation(
        parent: controllerToIncreasingCurve,
        curve: Curves.fastLinearToSlowEaseIn,
      ),
    )..addListener(() {
        setState(() {});
      });

    animationToDecreasingCurve = Tween<double>(begin: 0, end: 800).animate(
      CurvedAnimation(
        parent: controllerToIncreasingCurve,
        curve: Curves.fastLinearToSlowEaseIn,
      ),
    )..addListener(() {
        setState(() {});
      });

    controllerToIncreasingCurve.forward();
    super.initState();
  }

  @override
  void dispose() {
    controllerToIncreasingCurve.dispose();
    controllerToDecreasingCurve.dispose();
    nameController.dispose();
    lastnamePaterController.dispose();
    lastnameMaterController.dispose();
    numDocController.dispose();
    phoneController.dispose();
    addressController.dispose();
    emailController.dispose();
    passwordController.dispose();
    roleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        backPressed = true;
        controllerToDecreasingCurve.forward();
        return true;
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(backPressed == false
            ? animationToIncreasingCurve.value
            : animationToDecreasingCurve.value),
        child: Scaffold(
          key: scaffoldKey,
          appBar: AppBar(
            title: Text(
              'Crear Nuevo doctor',
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            iconTheme: const IconThemeData(color: Colors.white),
            centerTitle: true,
            backgroundColor: colorPrimary,
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
                                        controller: lastnamePaterController,
                                        fieldName: 'Apellido Paterno',
                                        icon: Icons.local_hospital,
                                        prefixIconColor: colorPrimary,
                                        textValidator: 'Rellene los campos vacíos',
                                      ),
                                      const SizedBox(height: 20.0),
                                      TextFieldForm(
                                        controller: lastnameMaterController,
                                        fieldName: 'Apellido Materno',
                                        icon: Icons.local_hospital,
                                        prefixIconColor: colorPrimary,
                                        textValidator: 'Rellene los campos vacíos',
                                      ),
                                      const SizedBox(height: 20.0),
                                      TextFieldForm(
                                        controller: numDocController,
                                        fieldName: 'Número de documento',
                                        icon: Icons.local_hospital,
                                        prefixIconColor: colorPrimary,
                                        textValidator: 'Rellene los campos vacíos',
                                      ),
                                      const SizedBox(height: 20.0),
                                      TextFieldForm(
                                        controller: phoneController,
                                        fieldName: 'Teléfono',
                                        icon: Icons.local_hospital,
                                        prefixIconColor: colorPrimary,
                                        textValidator: 'Rellene los campos vacíos',
                                      ),    
                                      const SizedBox(height: 20.0),
                                      TextFieldForm(
                                        controller: addressController,
                                        fieldName: 'Dirección',
                                        icon: Icons.local_hospital,
                                        prefixIconColor: colorPrimary,
                                        textValidator: 'Rellene los campos vacíos',
                                      ),                                  const SizedBox(height: 20.0),
                                      TextFieldForm(
                                        controller: emailController,
                                        fieldName: 'Email',
                                        icon: Icons.description,
                                        prefixIconColor: colorPrimary,
                                        textValidator: 'Rellene los campos vacíos',
                                      ),
                                      const SizedBox(height: 20.0),
                                      TextFieldForm(
                                        controller: passwordController,
                                        fieldName: 'Password',
                                        icon: Icons.description,
                                        prefixIconColor: colorPrimary,
                                        textValidator: 'Rellene los campos vacíos',
                                      ),
                                      const SizedBox(height: 20.0),
                                      TextFieldForm(
                                        controller: roleController,
                                        fieldName: 'Role',
                                        icon: Icons.description,
                                        prefixIconColor: colorPrimary,
                                        textValidator: 'Rellene los campos vacíos',
                                      ),
                                      const SizedBox(height: 20.0),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            textStyle: const TextStyle(fontSize: 18),
                                            minimumSize: const Size.fromHeight(45),
                                            shape: const StadiumBorder(),
                                            fixedSize: const Size(30, 45),
                                            backgroundColor: colorPrimary,
                                          ),
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
                                                      child: CircularProgressIndicator(
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                    SizedBox(width: 24),
                                                    Text('Espere un momento...')
                                                  ],
                                                )
                                              : const Text('Registrar'),
                                          onPressed: () async {
                                            final isValidForm = formKey.currentState!.validate();

                                            if (isValidForm) {
                                              if (isLoading) return;

                                              setState(() => isLoading = true);
                                              await Future.delayed(const Duration(seconds: 2));
                                              await registerDoctor();
                                              hideKeyboard();
                                              showSuccessNotification(context);
                                              Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (BuildContext context) =>
                                                      const DoctorScreen(),
                                                ),
                                              );
                                            } else {
                                              showErrorNotification(context);
                                            }
                                          },
                                        ),
                                      ),
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
        ),
      ),
    );
  }
}