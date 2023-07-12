import 'package:flutter/material.dart';
import 'package:frontend/constants.dart';
import 'package:frontend/screens/search_screen.dart';
import 'package:frontend/widgets/home_content.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

import 'account_screen.dart';
import 'date_screen.dart';

class HomeScreen extends StatefulWidget {
  final String token;
  
  const HomeScreen({Key? key, required this.token}) : super(key: key);

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  var currentPage = DrawerSections.dashboard;
  late String role;
  late final List<Widget> screens;
  bool selected = true;

  @override
  void initState() {
    super.initState();
    extractUserRole();
    screens = [
      HomeContent(role: role),
      const DateScreen(),
      const SearchScreen(),
      const AccountScreen(),
    ];
  }

  void extractUserRole() {
    Map<String, dynamic> decodedToken = JwtDecoder.decode(widget.token);
    role = decodedToken['role'] ?? '';

    print('User Role: $role');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorPrimary,
        elevation: 0, 
        iconTheme: IconThemeData(color: Colors.white),
      ),
      drawer: Drawer(
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                Container(
                  color: colorPrimary,
                  width: double.infinity,
                  height: 200,
                  padding: EdgeInsets.only(top: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.only(bottom: 10),
                        height: 70,
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image: AssetImage(
                                    'assets/images/doctor-avatar.jpg'))),
                      ),
                      const Text('Citas médicas',
                          style: TextStyle(color: Colors.white, fontSize: 20)),
                      const Text('doctor@ecodsalud.com',
                          style: TextStyle(color: Colors.grey, fontSize: 14)),
                    ],
                  ),
                ),
                InkWell( 
                    onTap: (){},
                    child: const ListTile(
                      leading: Icon(Icons.dashboard_customize),
                      title:  Text('Dashboard'),
                    ),
                  ),
                  InkWell( 
                    onTap: (){},
                    child: const ListTile(
                      leading: Icon(Icons.person),
                      title:  Text('Usuarios'),
                    ),
                  ),
                  InkWell( 
                    onTap: (){},
                    child: const ListTile(
                      leading: Icon(Icons.local_hospital),
                      title:  Text('Consultorios'),
                    ),
                  ),

                  InkWell( 
                    onTap: (){},
                    child: const ListTile(
                      leading: Icon(Icons.room_service),
                      title:  Text('Servicios'),
                    ),
                  ),

                  InkWell( 
                    onTap: (){},
                    child: const ListTile(
                      leading: Icon(Icons.medication_liquid),
                      title:  Text('Medicinas'),
                    ),
                  ),
                  InkWell( 
                    onTap: (){},
                    child: const ListTile(
                      leading: Icon(Icons.date_range),
                      title:  Text('Citas'),
                    ),
                  ),
                  InkWell( 
                    onTap: (){},
                    child: const ListTile(
                      leading: Icon(Icons.data_exploration),
                      title:  Text('Tipo de Cita'),
                    ),
                  ),

                  InkWell( 
                    onTap: (){},
                    child: const ListTile(
                      leading: Icon(Icons.folder),
                      title:  Text('Historuia clinica'),
                    ),
                  ),
                
                
              ],
            ),
          ),
        ),
      ),
      body: HomeContent(role: role),

      
    );
  }

}