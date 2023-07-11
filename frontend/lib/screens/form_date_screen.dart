import 'package:flutter/material.dart';
import 'package:frontend/models/text_field_form.dart';
import 'package:frontend/screens/search_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logger/logger.dart';
import '../constants.dart'; // For date formatting
import 'package:intl/intl.dart';
import 'dart:async';


class FormAddDate extends StatefulWidget {
  /*final DoctorModel doctor;*/
  const FormAddDate({Key? key }) : super(key: key);

  @override
  State<FormAddDate> createState() => _FormAddDateState();
}

class _FormAddDateState extends State<FormAddDate> {
  // Inicializaremos con una opción vacía del dropdown

  String selectedOption = "";

  // En esta lista rellenaremos dinámicamente el dropdown
  // haciendo una petiición al backend

  List<dynamic> dropdownOptions = [];

  // Definiendo control principal del loading del botón de registro

  bool isLoading = false;

  // Definimos lista estática de género

  List dropDownListData = [
    {"title": "Masculino", "value": "1"},
    {"title": "Femenino", "value": "2"},
  ];

  String selectedCourseValue = "";

  // Definimos tipo de las fechas

  DateTime? selectedDate;

  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  // Definimos controladores de los inputs

  final namePatientController = TextEditingController();
  final namePaterController = TextEditingController();
  final nameMaterController = TextEditingController();
  final celController = TextEditingController();
  final emailController = TextEditingController();
  final doctorController = TextEditingController();
  final addressController = TextEditingController();

  // Hacemos una función para aperturar el modal del datepicker

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor:
                colorPrimary, 
            colorScheme: const ColorScheme.light(
                primary: colorPrimary),
            buttonTheme: const ButtonThemeData(
              textTheme: ButtonTextTheme.primary,
            ),
          ),
          child: child ?? Container(),
        );
      },
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  // Agregamos la función haciendo una petición
  // al backend de la lista de doctores

  // Hacemos llamado a las funciones definidas

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    namePatientController.dispose();
    namePaterController.dispose();
    nameMaterController.dispose();
    celController.dispose();
    emailController.dispose();
    addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Logger logger = Logger();

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
                    const SearchScreen(),
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
                                      controller: namePatientController,
                                      fieldName: 'name',
                                      icon: Icons.person_2_outlined,
                                      prefixIconColor: colorPrimary, 
                                      textValidator: '',),
                                  const SizedBox(height: 20.0),
                                  TextFieldForm(
                                      controller: namePaterController,
                                      fieldName: 'Apellido Paterno',
                                      icon: Icons.person_add_outlined,
                                      prefixIconColor: colorPrimary, textValidator: '',),
                                  const SizedBox(height: 20.0),
                                  TextFieldForm(
                                      controller: nameMaterController,
                                      fieldName: 'Correo electrónico',
                                      icon: Icons.personal_injury_outlined,
                                      prefixIconColor: colorPrimary, textValidator: '',),
                                  const SizedBox(height: 20.0),
                                  InputDecorator(
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(3.0),
                                      ),
                                      contentPadding: const EdgeInsets.all(17),
                                      // Other input decoration properties
                                    ),
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton<String>(
                                        value: selectedCourseValue,
                                        isDense: true,
                                        isExpanded: true,
                                        menuMaxHeight: 350,
                                        items: [
                                          const DropdownMenuItem(
                                            value: "",
                                            child: Text(
                                              "Selecciona el género",
                                              style: TextStyle(
                                                  color: colorPrimary),
                                            ),
                                          ),
                                          ...dropDownListData
                                              .map<DropdownMenuItem<String>>(
                                                  (e) {
                                            return DropdownMenuItem(
                                              value: e['value'],
                                              child: Text(
                                                e['title'],
                                              ),
                                            );
                                          }).toList(),
                                        ],
                                        onChanged: (newValue) {
                                          setState(() {
                                            selectedCourseValue = newValue!;
                                            logger.d(selectedCourseValue);
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  /*InputFieldDoctor(
                                    controller: doctorController, 
                                    //fieldName: '${widget.doctor.name} ${widget.doctor.lastnamePater} ${widget.doctor.lastnameMater}',
                                    icon: Icons.pest_control_rodent_outlined, 
                                    prefixIconColor: colorPrimary,
                                  ),
*/
                                  const SizedBox(height: 20.0),
                                  TextFieldForm(
                                      controller: celController,
                                      fieldName: 'Celular',
                                      icon: Icons.phone_android,
                                      prefixIconColor: colorPrimary, textValidator: '',),
                                  const SizedBox(height: 20.0),
                                  TextFieldForm(
                                      controller: emailController,
                                      fieldName: 'Correo electrónico',
                                      icon: Icons.email_outlined,
                                      prefixIconColor: colorPrimary, textValidator: '',),
                                  const SizedBox(height: 20.0),
                                  TextFieldForm(
                                      controller: addressController,
                                      fieldName: 'Dirección',
                                      icon: Icons.home_outlined,
                                      prefixIconColor: colorPrimary, textValidator: '',),
                                  const SizedBox(height: 20.0),
                                  GestureDetector(
                                    onTap: () {
                                      selectDate(context);
                                    },
                                    child: AbsorbPointer(
                                      child: TextFormField(
                                        controller: TextEditingController(
                                          text: selectedDate != null
                                              ? DateFormat('yyyy-MM-dd')
                                                  .format(selectedDate!)
                                              : '',
                                        ),
                                        decoration: const InputDecoration(
                                          labelText: 'Selecciona la fecha',
                                          labelStyle:
                                              TextStyle(color: colorPrimary),
                                          prefixIcon: Icon(Icons.calendar_today,
                                              color: colorPrimary),
                                          border: OutlineInputBorder(),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide:
                                                BorderSide(color: colorPrimary),
                                          ),
                                        ),
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Please select a date';
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
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
                                                  children:  [
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
                                            setState(() => isLoading = false);
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
