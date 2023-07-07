import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:frontend/animations/page_transition_animation.dart';
import 'package:frontend/constants.dart';
import 'package:frontend/screens/modules/medicines/model/medicine_model.dart';
import 'package:frontend/screens/home_screen.dart';
import 'package:frontend/screens/modules/medicines/service/medicine_service.dart';
import 'package:frontend/screens/modules/medicines/view/form_medicine_add_screen.dart';
import 'package:frontend/screens/modules/medicines/view/form_medicine_put_screen.dart';
import 'package:frontend/utils/alerts.dart';
import 'package:frontend/widgets/nav_bar.dart';
import 'package:frontend/widgets/page_app_bar.dart';
import 'package:google_fonts/google_fonts.dart';

class MedicineScreen extends StatefulWidget {
  const MedicineScreen({Key? key}) : super(key: key);

  @override
  State<MedicineScreen> createState() => _MedicineScreenState();
}

class _MedicineScreenState extends State<MedicineScreen> {
  late Color successColor = const Color.fromARGB(255, 88, 170, 21);
  late Color errorColor = Colors.red;

  bool loading = true;
  late String token;
  late List<MedicineModel> medicineData;
  late List<MedicineModel> filteredMedicineData;
  TextEditingController searchController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    medicineData = [];
    filteredMedicineData = [];
    fetchData();
  }

  Future<void> fetchData() async {
    setState(() {
      loading = true; // Set loading state to true before fetching data
    });

    try {
      List<MedicineModel> medicines = await MedicineService.fetchData();

      // Simulate a delayed loading state for 2 seconds
      await Future.delayed(const Duration(seconds: 1));

      setState(() {
        medicineData = medicines;
        filteredMedicineData = medicines;
        loading = false; // Set loading state to false after data is fetched
      });
    } catch (e) {
      setState(() {
        loading = false; // Set loading state to false on error
      });
    }
  }

  Future<void> deleteData(String medicineId) async {
    final success = await MedicineService.deleteData(medicineId);

    if (success) {
      setState(() {
        medicineData.removeWhere((medicine) => medicine.id == medicineId);
        filteredMedicineData
            .removeWhere((medicine) => medicine.id == medicineId);
      });

      // ignore: use_build_context_synchronously
      showDeleteSuccessNotification(
        context,
        'EL registro fue eliminado correctamente',
        successColor,
      );
    } else {
      throw Exception("Error deleting data");
    }
  }

  void runFilter(String enteredKeyword) {
    if (enteredKeyword.isEmpty) {
      setState(() {
        filteredMedicineData = medicineData;
      });
    } else {
      List<MedicineModel> results = medicineData
          .where((medicine) => medicine.name
              .toLowerCase()
              .contains(enteredKeyword.toLowerCase()))
          .toList();
      setState(() {
        filteredMedicineData = results;
      });
    }
  }

  Future<void> navigateToMedicineScreen(String medicineId) async {
    List<MedicineModel> medicines = await MedicineService.fetchData();

    MedicineModel? medicine = medicines.firstWhere((m) => m.id == medicineId);

    _navigateToMedicineScreen(medicine);
  }

  Future<void> _navigateToMedicineScreen(MedicineModel medicine) async {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Navigator.of(context).push(
        PageTransitionAnimation(FormMedicinePutScreen(medicine: medicine)),
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
        "Medicinas",
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
                    : filteredMedicineData.isEmpty
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
                            itemCount: filteredMedicineData.length,
                            itemBuilder: (context, index) => Card(
                              elevation: 1,
                              margin: const EdgeInsets.symmetric(vertical: 2),
                              child: ListTile(
                                onTap: () {},
                                title: Text(filteredMedicineData[index].name),
                                subtitle: Text(
                                    filteredMedicineData[index].description),
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
                                              filteredMedicineData[index].id),
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
                                                              deleteData(
                                                                  filteredMedicineData[
                                                                          index]
                                                                      .id);
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
            PageTransitionAnimation(const FormAddMedicine()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }



}
