 
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend/constants.dart';
import 'package:frontend/models/text_field_form.dart';
import 'package:frontend/screens/modules/consulting-room/model/c_room_model.dart';
import 'package:frontend/screens/modules/consulting-room/view/c_room_screen.dart';
import 'package:frontend/widgets/alerts/error_alert.dart';
import 'package:frontend/widgets/alerts/update_alert.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logger/logger.dart';
import 'package:http/http.dart' as http;

class FormcroomPut extends StatefulWidget {
  final CRoomModel croom;
  const FormcroomPut({super.key, required this.croom});

  @override
  State<FormcroomPut> createState() => FormcroomPutState();
}

class FormcroomPutState extends State<FormcroomPut>
    with TickerProviderStateMixin {
  bool backPressed = false;

  late AnimationController controllerToIncreasingCurve;
  late AnimationController controllerToDecreasingCurve;

  late Animation<double> animationToIncreasingCurve;
  late Animation<double> animationToDecreasingCurve;

  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  final numConsultController = TextEditingController();

  late List<CRoomModel> croomData;
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

    nameController.text = widget.croom.name;
    descriptionController.text = widget.croom.description;
    numConsultController.text = widget.croom.numConsult.toString();
  }

  @override
  void dispose() {
    controllerToIncreasingCurve.dispose();
    controllerToDecreasingCurve.dispose();
    super.dispose();
  }

  Future<void> updatecRoom(String cRoomId) async {
    String url = "http://10.0.2.2:3000/consulting-room/$cRoomId";

    Map<String, String> headers = {
      'Content-Type': 'application/json',
    };

    Map<String, dynamic> requestBody = {
      'name': nameController.text,
      'description': descriptionController.text,
      'numConsult': numConsultController.text,
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
        numConsultController.clear();
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
              'Actualizar Consultorio',
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
                                        controller: descriptionController,
                                        fieldName: 'Descripción',
                                        icon: Icons.description,
                                        prefixIconColor: colorPrimary,
                                        textValidator: '',
                                      ),
                                      const SizedBox(height: 20.0),
                                      TextFieldForm(
                                        controller: numConsultController,
                                        fieldName: 'Número de consultorio',
                                        icon: Icons.local_hospital,
                                        prefixIconColor: colorPrimary,
                                        textValidator: '',
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
                                                await updatecRoom(
                                                    widget.croom.id);
                                                setState(() {});
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
