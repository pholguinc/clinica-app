// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend/constants.dart';

import 'package:frontend/models/text_field_form.dart';
import 'package:frontend/screens/modules/doctors/model/doctor_model.dart';
import 'package:frontend/screens/modules/doctors/view/doctor_screen.dart';
import 'package:frontend/screens/modules/medicines/view/medicine_screen.dart';
import 'package:frontend/widgets/alerts/error_alert.dart';
import 'package:frontend/widgets/alerts/update_alert.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';

class FormDoctorPutScreen extends StatefulWidget {
  final DoctorModel doctor;

  const FormDoctorPutScreen({required this.doctor, Key? key}) : super(key: key);

  @override
  State<FormDoctorPutScreen> createState() => _FormDoctorPutScreenState();
}

class _FormDoctorPutScreenState extends State<FormDoctorPutScreen>
    with TickerProviderStateMixin {
  bool backPressed = false;

  late AnimationController controllerToIncreasingCurve;
  late AnimationController controllerToDecreasingCurve;

  late Animation<double> animationToIncreasingCurve;
  late Animation<double> animationToDecreasingCurve;

  final nameController = TextEditingController();
  final lastnamePaterController = TextEditingController();
  final lastnameMaterController = TextEditingController();
  final numDocController = TextEditingController();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final roleController = TextEditingController();

  final PickedFile? imageFile = null;
  final formKey = GlobalKey<FormState>();
  final Logger logger = Logger();

  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  bool isLoading = false;

  void showSuccessNotification(BuildContext context) {
    const UpdateAlert().show(context);
  }

  void showErrorNotification(BuildContext context) {
    const ErrorAlert().show(context);
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

    nameController.text = widget.doctor.name;
    lastnamePaterController.text = widget.doctor.lastnamePater;
    lastnameMaterController.text = widget.doctor.lastnameMater;
    numDocController.text = widget.doctor.numDoc;
    phoneController.text = widget.doctor.phone;
    addressController.text = widget.doctor.address;
    emailController.text = widget.doctor.email;
    roleController.text = widget.doctor.role;

  }

  @override
  void dispose() {
    controllerToIncreasingCurve.dispose();
    controllerToDecreasingCurve.dispose();
    super.dispose();
  }

  Future<void> updateDoctor(String doctorId) async {
    String url = "http://10.0.2.2:3000/users/$doctorId";

    Map<String, String> headers = {
      'Content-Type': 'application/json',
    };

    Map<String, dynamic> requestBody = {
      'name': nameController.text,
      'lastname_pater': lastnamePaterController.text,
      'lastname_mater': lastnameMaterController.text,
      'num_doc': numDocController.text,
      'phone': phoneController.text,
      'address': addressController.text,
      'email': emailController.text,
      'role': roleController.text
    };

    if (passwordController.text.isNotEmpty) {
    requestBody['password'] = passwordController.text;
  }

    try {
      http.Response response = await http.put(
        Uri.parse(url),
        headers: headers,
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 200) {
        nameController.clear();
        lastnamePaterController.clear();
        lastnameMaterController.clear();
        numDocController.clear();
        phoneController.clear();
        addressController.clear();
        emailController.clear();
        passwordController.clear();
        roleController.clear();
      } else {
        logger.d('Error occurred during update: $response.statusCode');
      }
    } catch (error) {
      logger.d('Error occurred during update: $error');
    }
  }

  void hideKeyboard() {
    FocusManager.instance.primaryFocus?.unfocus();
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
              'Actualizar Medicina',
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
                                  child: Column(
                                    children: [
                                      TextFieldForm(
                                        controller: nameController,
                                        fieldName: 'Nombre',
                                        icon: Icons.local_hospital,
                                        prefixIconColor: colorPrimary,
                                        textValidator: '',
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
                                        fieldName: 'Password optional',
                                        icon: Icons.description,
                                        prefixIconColor: colorPrimary,
                                        textValidator: '',
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
                                                  textStyle: const TextStyle(
                                                      fontSize: 18),
                                                  minimumSize:
                                                      const Size.fromHeight(45),
                                                  shape: const StadiumBorder(),
                                                  fixedSize: const Size(30, 45),
                                                  backgroundColor:
                                                      colorPrimary),
                                              child: isLoading
                                                  ? const Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
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
                                                        Text(
                                                            'Espere un momento...')
                                                      ],
                                                    )
                                                  : const Text('Actualizar'),
                                              onPressed: () async {
                                                final currentContext = context;
                                                if (isLoading) return;

                                                setState(
                                                    () => isLoading = true);
                                                await Future.delayed(
                                                    const Duration(seconds: 2));
                                                setState(
                                                    () => isLoading = false);

                                                hideKeyboard();
                                                // ignore: use_build_context_synchronously
                                                showSuccessNotification(
                                                    context);
                                                await updateDoctor(
                                                    widget.doctor.id);

                                                // ignore: use_build_context_synchronously
                                                Navigator.push(
                                                  currentContext,
                                                  MaterialPageRoute(
                                                    builder:
                                                        (BuildContext context) {
                                                      return Builder(
                                                        builder: (BuildContext
                                                            context) {
                                                          return const DoctorScreen();
                                                        },
                                                      );
                                                    },
                                                  ),
                                                );

                                                // Add "not found" notification after navigating
                                                await Future.delayed(
                                                    const Duration(
                                                        milliseconds: 100));

                                                // ignore: use_build_context_synchronously
                                                showSuccessNotification(
                                                    context);
                                                setState(() {});
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
        ),
      ),
    );
  }
}
