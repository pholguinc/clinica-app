// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_flushbar/flutter_flushbar.dart';
import 'package:frontend/animations/page_transition_animation.dart';
import 'package:frontend/constants.dart';
import 'package:frontend/models/doctor_model.dart';
import 'package:frontend/models/medicine_model.dart';
import 'package:frontend/models/text_field_form.dart';
import 'package:frontend/screens/modules/medicines/view/medicine_screen.dart';
import 'package:frontend/screens/search_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class FormMedicinePutScreen extends StatefulWidget {
  final MedicineModel medicine;

  const FormMedicinePutScreen({required this.medicine, Key? key})
      : super(key: key);

  @override
  State<FormMedicinePutScreen> createState() => _FormMedicinePutScreenState();
}

class _FormMedicinePutScreenState extends State<FormMedicinePutScreen>
    with TickerProviderStateMixin {
  bool backPressed = false;

  late AnimationController controllerToIncreasingCurve;
  late AnimationController controllerToDecreasingCurve;

  late Animation<double> animationToIncreasingCurve;
  late Animation<double> animationToDecreasingCurve;

  final nameController = TextEditingController();
  final descriptionController = TextEditingController();

  final PickedFile? imageFile = null;
  late List<DoctorModel> doctorData;

  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  bool isLoading = false;

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

    nameController.text = widget.medicine.name;
    descriptionController.text = widget.medicine.description;
  }

  @override
  void dispose() {
    controllerToIncreasingCurve.dispose();
    controllerToDecreasingCurve.dispose();
    super.dispose();
  }

  Future<void> updateMedicine(String medicineId) async {
    String url = "http://10.0.2.2:3000/medicines/$medicineId";

    Map<String, String> headers = {
      'Content-Type': 'application/json',
    };

    Map<String, dynamic> requestBody = {
      'name': nameController.text,
      'description': descriptionController.text,
    };

    try {
      http.Response response = await http.put(
        Uri.parse(url),
        headers: headers,
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 200) {
        nameController.clear();
        descriptionController.clear();
      } else {
        print('Error occurred during update: $response.statusCode');
      }
    } catch (error) {
      print('Error occurred during update: $error');
    }
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
        "El registro fue actualizado correctamente",
        style: TextStyle(
          fontSize: 16.0,
          color: Colors.white,
          fontFamily: "ShadowsIntoLightTwo",
        ),
      ),
    ).show(context);
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
                                      /*TextFieldForm(
                                          controller: nameController,
                                          fieldName: 'Nombre',
                                          icon: Icons.local_hospital,
                                          prefixIconColor: colorPrimary),
                                      const SizedBox(height: 20.0),
                                      TextFieldForm(
                                          controller: descriptionController,
                                          fieldName: 'Descripción',
                                          icon: Icons.description,
                                          prefixIconColor: colorPrimary),*/
                                      const SizedBox(height: 20.0),
                                      Text(widget.medicine.id),
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
                                                if (isLoading) return;

                                                setState(
                                                    () => isLoading = true);
                                                await Future.delayed(
                                                    const Duration(seconds: 2));

                                                setState(
                                                    () => isLoading = false);
                                                hideKeyboard();
                                                showSuccessNotification();
                                                await updateMedicine(
                                                    widget.medicine.id);

                                                
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
