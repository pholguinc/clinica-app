import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend/models/doctor_model.dart';
import 'package:frontend/screens/doctor_profile_screen.dart';
import 'package:frontend/widgets/home_content.dart';
import 'package:frontend/widgets/nav_bar.dart';
import 'package:http/http.dart' as http;

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late List<DoctorModel> doctorData;
  late List<DoctorModel> filteredDoctorData;
  TextEditingController searchController = TextEditingController();

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
        description: data['description'].toString()
      );
    }).toList();
    setState(() {
      doctorData = doctors;
      filteredDoctorData = doctors;
    });
  }

  void runFilter(String enteredKeyword) {
    if (enteredKeyword.isEmpty) {
      setState(() {
        filteredDoctorData = doctorData;
      });
    } else {
      List<DoctorModel> results = doctorData
          .where((doctor) =>
              doctor.name.toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList();
      setState(() {
        filteredDoctorData = results;
      });
    }
  }

  void navigateToDoctorProfileScreen(String doctorId) async {
    Uri uri = Uri.parse("http://10.0.2.2:3000/doctors/$doctorId");
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
              DoctorProfileScreen(doctor: doctor),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Navbar(route: () => const HomeContent(role: '',)),
      appBar: AppBar(),
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
                      vertical: 10.0, horizontal: 15),
                  hintText: "Search",
                  suffixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: const BorderSide(),
                  ),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: filteredDoctorData.length,
                  itemBuilder: (context, index) => Card(
                    elevation: 1,
                    margin: const EdgeInsets.symmetric(vertical: 2),
                    child: ListTile(
                      onTap: () => navigateToDoctorProfileScreen(
                          filteredDoctorData[index].id),
                      leading: CircleAvatar(
                        radius: 30.0,
                        backgroundImage:
                            NetworkImage(filteredDoctorData[index].image),
                        backgroundColor: Colors.transparent,
                      ),
                      title: Text(
                        '${filteredDoctorData[index].name} '
                        '${filteredDoctorData[index].lastnamePater} '
                        '${filteredDoctorData[index].lastnameMater}',
                      ),
                      subtitle: Text(filteredDoctorData[index].job),
                      trailing: const Icon(Icons.arrow_forward),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

