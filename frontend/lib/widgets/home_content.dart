import 'package:flutter/material.dart';
import 'package:frontend/screens/form_date_screen.dart';
import 'package:frontend/screens/modules/consulting-room/view/c_room_screen.dart';
import 'package:frontend/screens/modules/doctors/view/doctor_screen.dart';
import 'package:frontend/screens/modules/services/view/service_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logger/logger.dart';

import '../constants.dart';
import '../screens/modules/medicines/view/medicine_screen.dart';

class HomeContent extends StatelessWidget {
  final String role;
  const HomeContent({ Key? key, required this.role}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Logger logger = Logger();

    return Scaffold(
        body: ListView(
      padding: EdgeInsets.zero,
      children: [
        Container(
          height: 160, // Increase the height to accommodate the content
          decoration: const BoxDecoration(
            color: colorPrimary,
            borderRadius: BorderRadius.only(bottomRight: Radius.circular(50)),
          ),
          child: Column(
            children: [
              const SizedBox(height: 60),

              ListTile(
                title: Padding(
                  padding: const EdgeInsets.only(top: 15, left: 30),
                  child: Text(
                    'Bienvenido',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: Colors.white,
                        ),
                  ),
                ),
                subtitle: Padding(
                  padding: const EdgeInsets.only(left: 30),
                  child: Text(
                   'Ahora está como "$role"',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: Colors.white54,
                        ),
                  ),
                ),
                trailing: const CircleAvatar(
                  radius: 50,
                  backgroundImage:
                      AssetImage('assets/images/doctor-avatar.jpg'),
                ),
              ), // Adjust the height as needed
            ],
          ),
        ),
        Container(
          color: colorPrimary,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(100))),
            child: GridView.count(
              shrinkWrap: true,
              crossAxisCount: 2,
              crossAxisSpacing: 20,
              mainAxisSpacing: 30,
              children: [
                GestureDetector(
                  onTap: () {
                    // Add your onTap functionality here
                    logger.d('Button tapped!');
                  },
                  child: itemDashboard(
                    context,
                    'Medicinas',
                    Icons.medication_liquid,
                    const Color.fromARGB(255, 201, 51, 228),
                    40,
                    () =>
                        const MedicineScreen(), // Pass a callback function that returns the desired screen
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    // Add your onTap functionality here
                    logger.d('Button tapped!');
                  },
                  child: itemDashboard(context, 'Citas', Icons.date_range,
                      Colors.deepOrange, 40, () => const FormAddDate()),
                ),
                GestureDetector(
                  onTap: () {
                    // Add your onTap functionality here
                    logger.d('Button tapped!');
                  },
                  child: itemDashboard(context, 'Servicios', Icons.room_service,
                      Colors.brown, 40, () => const ServiceScreen()),
                ),
                GestureDetector(
                  onTap: () {
                    // Add your onTap functionality here
                    logger.d('Button tapped!');
                  },
                  child: itemDashboard(
                      context,
                      'Consultorios',
                      Icons.local_hospital,
                      Colors.blue,
                      40,
                      () => const CroomScreen()),
                ),
                GestureDetector(
                  onTap: () {},
                  child: itemDashboard(
                      context,
                      'Historia Clínica',
                      Icons.library_books,
                      Colors.green,
                      40,
                      () => const MedicineScreen()),
                ),
                GestureDetector(
                  onTap: () {
                    // Add your onTap functionality here
                    logger.d('Button tapped!');
                  },
                  child: itemDashboard(context, 'Contactos', Icons.phone,
                      Colors.pinkAccent, 40, () => const DoctorScreen()),
                ),
              ],
            ),
          ),
        )
      ],
    ));
  }

  Widget itemDashboard(
    BuildContext context,
    String title,
    IconData iconData,
    Color background,
    double iconSize,
    Widget Function() route, // Separate parameter for the route
  ) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 5),
            color: Theme.of(context).primaryColor.withOpacity(.2),
            spreadRadius: 2,
            blurRadius: 5,
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) => route(),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                const begin = Offset(1.0, 0.0);
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
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
          overlayColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
              if (states.contains(MaterialState.pressed)) {
                // Overlay color when the button is pressed
                return Colors.grey.withOpacity(
                    0.2); // Replace with your desired color and opacity
              }
              // Default overlay color
              return Colors.transparent;
            },
          ),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: background,
                shape: BoxShape.circle,
              ),
              child: Icon(iconData, color: Colors.white, size: iconSize),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Text(
                title,
                style: GoogleFonts.poppins(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                    color: Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
