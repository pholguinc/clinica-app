import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:frontend/animations/page_transition_animation.dart';
import 'package:frontend/screens/home_screen.dart';
import 'package:frontend/screens/modules/consulting-room/model/c_room_model.dart';
import 'package:frontend/screens/modules/consulting-room/service/c_room_service.dart';
import 'package:frontend/screens/modules/consulting-room/view/form_c_room_add.dart';
import 'package:frontend/screens/modules/consulting-room/view/form_c_room_put.dart';
import 'package:frontend/utils/alerts.dart';
import 'package:frontend/widgets/nav_bar.dart';
import 'package:frontend/widgets/page_app_bar.dart';
import 'package:google_fonts/google_fonts.dart';

class CroomScreen extends StatefulWidget {
  const CroomScreen({super.key});

  @override
  State<CroomScreen> createState() => _CroomScreenState();
}

class _CroomScreenState extends State<CroomScreen> {
  late Color successColor = const Color.fromARGB(255, 88, 170, 21);
  late Color errorColor = Colors.red;

  bool loading = true;
  late List<CRoomModel> cRoomData;
  late List<CRoomModel> filteredCRoomData;
  TextEditingController searchController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    cRoomData = [];
    filteredCRoomData = [];
    fetchData();
  }

  Future<void> fetchData() async {
    setState(() {
      loading = true; // Set loading state to true before fetching data
    });

    try {
      List<CRoomModel> croom = await CRoomService.fetchData();

      // Simulate a delayed loading state for 2 seconds
      await Future.delayed(const Duration(seconds: 1));

      setState(() {
        cRoomData = croom;
        filteredCRoomData = croom;
        loading = false; // Set loading state to false after data is fetched
      });
    } catch (e) {
      setState(() {
        loading = false; // Set loading state to false on error
      });
    }
  }

  Future<void> deleteData(String croomId) async {
    final success = await CRoomService.deleteData(croomId);

    if (success) {
      setState(() {
        cRoomData.removeWhere((croom) => croom.id == croomId);
        filteredCRoomData.removeWhere((croom) => croom.id == croomId);
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
        filteredCRoomData = cRoomData;
      });
    } else {
      List<CRoomModel> results = cRoomData
          .where((croom) =>
              croom.name.toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList();
      setState(() {
        filteredCRoomData = results;
      });
    }
  }

  Future<void> navigateTocroomScreen(String croomId) async {
    List<CRoomModel> crooms = await CRoomService.fetchData();

    CRoomModel? croom = crooms.firstWhere((m) => m.id == croomId);

    _navigateTocroomScreen(croom);
  }

  Future<void> _navigateTocroomScreen(CRoomModel croom) async {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Navigator.of(context).push(
        PageTransitionAnimation( FormcroomPut(croom: croom,)),
      );
    });
  }

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Navbar(route: () => const HomeScreen()),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: PageAppBar(pageTitle: 'Buscar Consultorios', route: () => const HomeScreen()),
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
                  hintText: "Search",
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
                    : filteredCRoomData.isEmpty
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
                            itemCount: filteredCRoomData.length,
                            itemBuilder: (context, index) => Card(
                              elevation: 1,
                              margin: const EdgeInsets.symmetric(vertical: 2),
                              child: ListTile(
                                onTap: () {},
                                title: Text.rich(
                                  TextSpan(
                                    text: filteredCRoomData[index].name,
                                    children: [
                                      const WidgetSpan(child: SizedBox(width:40)),
                                      TextSpan(
                                        text: "CON-${filteredCRoomData[index]
                                            .numConsult
                                            .toString()}",
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                                subtitle: Text(
                                    filteredCRoomData[index].description),
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
                                          onTap: () => navigateTocroomScreen(
                                              filteredCRoomData[index].id),
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
                                                                  filteredCRoomData[
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
            PageTransitionAnimation(const FormAddcRoom()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
