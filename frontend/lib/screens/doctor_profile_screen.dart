import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:frontend/screens/form_date_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:permission_handler/permission_handler.dart';

import '../constants.dart';
import '../models/doctor_model.dart';

class DoctorProfileScreen extends StatefulWidget {
  final DoctorModel doctor;

  const DoctorProfileScreen({required this.doctor, Key? key}) : super(key: key);

  @override
  State<DoctorProfileScreen> createState() => _DoctorProfileScreenState();
}

class _DoctorProfileScreenState extends State<DoctorProfileScreen> {
  final PickedFile? imageFile = null;
  final ImagePicker picker = ImagePicker();
  late List<DoctorModel> doctorData;
  late List<DoctorModel> filteredDoctorData;
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  bool value = false;

  void changeData() {
    setState(() {
      value = true;
    });
  }

  @override
  void initState() {
    super.initState();
    doctorData = [];
    filteredDoctorData = [];
    fetchData();
  }

  Future<void> fetchData() async {
    Uri uri = Uri.parse("http://10.0.2.2:3000/doctors");
    http.Response response = await http.get(uri);
    List<dynamic> responseData = jsonDecode(response.body);
    List<DoctorModel> doctors = responseData.map((data) {
      return DoctorModel(
          id: data["id"].toString(),
          name: data["name"].toString(),
          lastnamePater: data["lastname_pater'),"].toString(),
          lastnameMater: data["lastname_mater"].toString(),
          job: data["job"].toString(),
          image: data["image"].toString(),
          description: data['description'].toString());
    }).toList();
    setState(() {
      doctorData = doctors;
      filteredDoctorData = doctors;
    });
  }

  void navigateToDoctorProfileScreen(String doctorId) async {
    Uri uri = Uri.parse("http://10.0.2.2:3000/api/doctors/$doctorId");
    http.Response response = await http.get(uri);
    dynamic responseData = jsonDecode(response.body);
    DoctorModel doctor = DoctorModel(
      id: responseData["id"].toString(),
      name: responseData["name"].toString(),
      lastnamePater: responseData["lastname_pater"].toString(),
      lastnameMater: responseData["lastname_mater"].toString(),
      job: responseData["job"].toString(),
      description: responseData["description"].toString(),
      image: responseData["image"].toString(),
    );
    _navigateToDoctorProfileScreen(doctor);
  }

  void _navigateToDoctorProfileScreen(DoctorModel doctor) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              FormAddDate(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(-1.0, 0.0);
            const end = Offset.zero;
            const curve = Curves.ease;
            final tween =
                Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
            return SlideTransition(
              position: animation.drive(tween),
              child: child,
            );
          },
        ),
      );
    });
  }

  void photoCamera(ImageSource source) async {
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        //final imageFile = PickedFile(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: Builder(
        builder: (BuildContext context) {
          return SizedBox(
            width: MediaQuery.of(context).size.width,
            height: double.maxFinite,
            child: Stack(
              children: [
                Positioned(
                  left: 0,
                  right: 0,
                  child: Container(
                    width: double.maxFinite,
                    height: 350,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image:
                            AssetImage('assets/images/doctor-profile-bg.jpg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            radius: 80,
                            backgroundImage:
                                imageFile == null || imageFile!.path.isEmpty
                                    ? NetworkImage(widget.doctor.image)
                                        as ImageProvider<Object>?
                                    : FileImage(File(imageFile!.path)),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                    top: 190.0,
                    left: 250.0,
                    child: InkWell(
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            builder: ((builder) => bottomCameraAsset()),
                          );
                        },
                        child: const Icon(Icons.camera_alt_rounded))),
                Positioned(
                  left: 20,
                  top: 40,
                  child: Row(
                    children: [
                      IconButton(
                        onPressed:
                            () {}, // Aquí se corrige la sintaxis del callback
                        icon: const Icon(Icons.arrow_back),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: 280,
                  child: Container(
                    padding: const EdgeInsets.only(top: 30),
                    width: MediaQuery.of(context).size.width,
                    height: 500,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(50),
                      ),
                      color: Colors.white,
                    ),
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Text(
                                '${widget.doctor.name} ${widget.doctor.lastnamePater} ${widget.doctor.lastnameMater}',
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 25,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 2),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Text(
                                widget.doctor.job,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Flexible(
                                  child: Text(
                                    widget.doctor.description,
                                    style: GoogleFonts.poppins(
                                      fontSize: 15,
                                    ),
                                    textAlign: TextAlign.justify,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 6,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: () async {
                                    _navigateToDoctorProfileScreen(
                                        widget.doctor);
                                  },
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: colorPrimary,
                                      foregroundColor:
                                          const Color.fromARGB(255, 255, 0, 0)),
                                  child: Text(
                                    'Agendar Cita',
                                    style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 18,
                                        color: Colors.white),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Wrap(
                          spacing: 8.0,
                          runSpacing: 8.0,
                          children: [
                            OutlinedButton(
                              onPressed: () {
                                // Add your button onPressed logic here
                              },
                              style: OutlinedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                side: const BorderSide(
                                  color: colorPrimary,
                                  width: 2.0,
                                ),
                                padding: const EdgeInsets.all(
                                    12.0), // Increased padding size
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(
                                    Icons.work_outline,
                                    color: colorPrimary,
                                  ),
                                  const SizedBox(width: 4.0),
                                  Text(
                                    widget.doctor.job,
                                    style: const TextStyle(
                                      color: colorPrimary,
                                      fontSize: 16.0,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            OutlinedButton(
                              onPressed: () {
                                // Add your button onPressed logic here
                              },
                              style: OutlinedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                side: const BorderSide(
                                  color: colorPrimary,
                                  width: 2.0,
                                ),
                                padding: const EdgeInsets.all(12.0),
                              ),
                              child: const Row(
                                mainAxisSize: MainAxisSize.min,
                                children:  [
                                  Icon(
                                    Icons.gps_fixed,
                                    color: colorPrimary,
                                  ),
                                  SizedBox(width: 4.0),
                                  Text(
                                    'Ubicación',
                                    style: TextStyle(
                                      color: colorPrimary,
                                      fontSize: 16.0,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20.0)
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget bottomCameraAsset() {
    final Logger logger = Logger();
    return Container(
      height: 100,
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        children: <Widget>[
          const Text('Agregar imagen', style: TextStyle(fontSize: 20.0)),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              InkWell(
                onTap: () async {
                  Map<Permission, PermissionStatus> statuses = await [
                    Permission.camera,
                  ].request();
                  if (statuses[Permission.camera]!.isGranted == true) {
                    photoCamera(ImageSource.camera);
                  } else {
                    logger.e("Error");
                  }
                },
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  child: const Row(
                    children: <Widget>[
                      Icon(Icons.camera, size: 40.0),
                      SizedBox(width: 8.0),
                      Text("Camera"),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () async{
                  Map<Permission, PermissionStatus> statuses = await [
                    Permission.storage,
                  ].request();
                  if (statuses[Permission.storage]!.isGranted == true) {
                    photoCamera(ImageSource.gallery);
                  } else {

                    logger.e("Error");
                  }
                },
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  child: const Row(
                    children: <Widget>[
                      Icon(Icons.image, size: 40.0),
                      SizedBox(width: 8.0),
                      Text("Gallery"),
                    ],
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
