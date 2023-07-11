import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:frontend/animations/page_transition_animation.dart';
import 'package:frontend/constants.dart';
import 'package:frontend/screens/modules/doctors/model/doctor_model.dart';
import 'package:frontend/screens/modules/doctors/service/doctor_service.dart';
import 'package:frontend/screens/modules/doctors/view/form_doctor_add_screen.dart';
import 'package:frontend/screens/modules/doctors/view/form_doctor_put_screen.dart';
import 'package:frontend/screens/modules/medicines/model/medicine_model.dart';
import 'package:frontend/screens/modules/medicines/service/medicine_service.dart';
import 'package:frontend/screens/modules/medicines/view/form_medicine_put_screen.dart';
import 'package:google_fonts/google_fonts.dart';
class DoctorScreen extends StatefulWidget {
  const DoctorScreen({Key? key}) : super(key: key);

  @override
  State<DoctorScreen> createState() => _DoctorScreenState();
}

class _DoctorScreenState extends State<DoctorScreen> {
 late Color successColor = const Color.fromARGB(255, 88, 170, 21);
  late Color errorColor = Colors.red;

  bool loading = true;
  late List<DoctorModel> doctorData;
  late List<DoctorModel> filteredDoctorData;
  TextEditingController searchController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController roleController = TextEditingController();

  @override
  void initState() {
    super.initState();
    doctorData = [];
    filteredDoctorData = [];
    fetchData();
  }

  Future<void> fetchData() async {
    setState(() {
      loading = true; // Set loading state to true before fetching data
    });

    try {
      List<DoctorModel> doctors = await DoctorService.fetchData();

      // Simulate a delayed loading state for 2 seconds
      await Future.delayed(const Duration(seconds: 1));

      setState(() {
        doctorData = doctors;
        filteredDoctorData = doctors;
        loading = false; // Set loading state to false after data is fetched
      });
    } catch (e) {
      setState(() {
        loading = false; // Set loading state to false on error
      });
    }
  }



  void runFilter(String enteredKeyword) {
    if (enteredKeyword.isEmpty) {
      setState(() {
        filteredDoctorData = doctorData;
      });
    } else {
      List<DoctorModel> results = doctorData
          .where((doctor) => doctor.name
              .toLowerCase()
              .contains(enteredKeyword.toLowerCase()))
          .toList();
      setState(() {
        filteredDoctorData = results;
      });
    }
  }

  Future<void> navigateToMedicineScreen(String doctorId) async {
    List<DoctorModel> doctors = await DoctorService.fetchData();

    DoctorModel? doctor = doctors.firstWhere((m) => m.id == doctorId);

    _navigateToMedicineScreen(doctor);
  }

  Future<void> _navigateToMedicineScreen(DoctorModel doctor) async {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Navigator.of(context).push(
        PageTransitionAnimation(FormDoctorPutScreen(doctor: doctor,)),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
      title: Text(
        "Doctor",
        style: GoogleFonts.poppins(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
      iconTheme: const IconThemeData(color: Colors.white),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 5.0),
          child: IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
        ),
      ],
      centerTitle: true,
      backgroundColor: colorPrimary,
      automaticallyImplyLeading: false,
    ),
      body: SizedBox(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              TextField(
                controller: searchController,
                onChanged: (value) => runFilter(value),
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 10.0,
                    horizontal: 15,
                  ),
                  hintText: "Buscar",
                  suffixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: const BorderSide(),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: loading
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : filteredDoctorData.isEmpty
                        ? Stack(
                            children: [
                              Positioned(
                                top: -90,
                                bottom: 0,
                                left: 24,
                                right: 24,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          width: 250,
                                          height: 250,
                                          alignment: Alignment.center,
                                          child: SvgPicture.asset(
                                              "assets/images/404.svg"),
                                        ),
                                      ],
                                    ),
                                    const Text(
                                      '¡No se encontraron resultados con su búsqueda!',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: Color(0xff2f3640),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )
                        : ListView.builder(
                            shrinkWrap: true,
                            itemCount: filteredDoctorData.length,
                            itemBuilder: (context, index) => Card(
                              elevation: 1,
                              margin: const EdgeInsets.symmetric(vertical: 2),
                              child: ListTile(
                                onTap: () {},
                                title: Text(filteredDoctorData[index].name),
                                subtitle: Text(
                                    filteredDoctorData[index].name),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                      width: 40,
                                      height: 40,
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.blue,
                                      ),
                                      child: Material(
                                        color: Colors.transparent,
                                        child: InkWell(
                                          onTap: () => navigateToMedicineScreen(
                                              filteredDoctorData[index].id),
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          child: Ink(
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color:
                                                  Colors.blue.withOpacity(0.5),
                                            ),
                                            child: const Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: Icon(
                                                Icons.edit,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Container(
                                      width: 40,
                                      height: 40,
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.red,
                                      ),
                                      child: Material(
                                        color: Colors.transparent,
                                        child: InkWell(
                                          onTap: () async {
                                            await showModalBottomSheet(
                                              context: context,
                                              shape:
                                                  const RoundedRectangleBorder(
                                                borderRadius: BorderRadius.only(
                                                  topRight: Radius.circular(20),
                                                  topLeft: Radius.circular(20),
                                                ),
                                              ),
                                              builder: (context) {
                                                return SizedBox(
                                                  height: 150,
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(top: 30),
                                                        child: Text(
                                                          '¿Está seguro de eliminar el registro?',
                                                          style: GoogleFonts
                                                              .poppins(
                                                            color: Colors.black,
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                          height: 20),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          ElevatedButton(
                                                            onPressed: () {
                                                              /*deleteData(
                                                                  filteredMedicineData[
                                                                          index]
                                                                      .id);*/
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                            style:
                                                                ElevatedButton
                                                                    .styleFrom(
                                                              backgroundColor:
                                                                  Colors.blue,
                                                              fixedSize:
                                                                  const Size(
                                                                120,
                                                                50,
                                                              ),
                                                            ),
                                                            child: Text(
                                                              'Sí eliminar',
                                                              style: GoogleFonts
                                                                  .poppins(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                              ),
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                              width: 10),
                                                          ElevatedButton(
                                                            onPressed: () {
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                            style:
                                                                ElevatedButton
                                                                    .styleFrom(
                                                              backgroundColor:
                                                                  Colors.red,
                                                              fixedSize:
                                                                  const Size(
                                                                120,
                                                                50,
                                                              ),
                                                            ),
                                                            child: Text(
                                                              'Cerrar',
                                                              style: GoogleFonts
                                                                  .poppins(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              },
                                            );
                                          },
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          child: Ink(
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color:
                                                  Colors.red.withOpacity(0.5),
                                            ),
                                            child: const Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: Icon(
                                                Icons.delete,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            PageTransitionAnimation(const FormAddDoctor()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }



}
