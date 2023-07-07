import 'package:flutter/material.dart';
import 'package:frontend/constants.dart';
import 'package:frontend/screens/home_screen.dart';
import 'package:frontend/screens_details/date_details.dart';
import 'package:frontend/widgets/home_content.dart';
import 'package:frontend/widgets/nav_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../widgets/page_app_bar.dart';

class DateScreen extends StatefulWidget {
  const DateScreen({Key? key}) : super(key: key);

  @override
  State<DateScreen> createState() => _DateScreenState();
}

class _DateScreenState extends State<DateScreen> {


  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      drawer: Navbar(route: () => const HomeContent(role: '',)),
      appBar: AppBar(),
      body: Column(
          children: <Widget>[
            Container(
              height: size.height * 0.28,
              width: double.infinity,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/task.png'),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(50),
                  bottomRight: Radius.circular(50),
                ),
              ),
              child: Stack(
                children: <Widget>[
                  SizedBox(height: size.height * .1),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Text(
                          'Mis Citas',
                          style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Listado de \nCitas asignadas',
                          style: GoogleFonts.poppins(
                            color: Colors.black38,
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: 10,
                    right: 10,
                    child: Image.asset(
                      'assets/images/logo.png',
                      height: 50,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),

            Expanded(
  
              child: SingleChildScrollView(
                child: Container(
                  color: Colors.white,
                  padding: EdgeInsets.only(top: size.height * 0.031),
                  child: Column(
                    children: <Widget>[
                      DateCard(
                        size: size,
                        name: 'pRUEBA\n',
                        date: DateTime.now(),
                      ),
                      DateCard(
                        size: size,
                        name: 'pRUEBA\n',
                        date: DateTime.now(),
                      ),
                      DateCard(
                        size: size,
                        name: 'pRUEBA\n',
                        date: DateTime.now(),
                      ),
                      DateCard(
                        size: size,
                        name: 'pRUEBA\n',
                        date: DateTime.now(),
                      ),
                      DateCard(
                        size: size,
                        name: 'pRUEBA\n',
                        date: DateTime.now(),
                      ),
                      DateCard(
                        size: size,
                        name: 'pRUEBA\n',
                        date: DateTime.now(),
                      ),
                      const SizedBox(
                        height: 10,
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
    );
  }
}

class DateCard extends StatelessWidget {
  final String name;
  final DateTime date;
  final Size size;

  const DateCard({
    Key? key,
    required this.size,
    required this.name,
    required this.date,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formattedDate =
        DateFormat('d MMM - HH:mm').format(date); // Format the date

    return Container(
      
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 30.0),
      margin: const EdgeInsets.only(bottom: 16.0),
      width: size.width - 48,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(38.5),
        boxShadow: [
          BoxShadow(
            offset: const Offset(10, 10),
            blurRadius: 33,
            color: const Color(0xFFD3D3D3).withOpacity(.84),
          ),
        ],
      ),
      child: Row(
        children: <Widget>[
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: name,
                  style: const TextStyle(
                    fontSize: 16,
                    color: dBlackColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(
                  text: formattedDate,
                  style: const TextStyle(color: dLightBlackColor),
                ),
              ],
            ),
          ),
          const Spacer(),
          IconButton(
            icon: const Icon(
              Icons.arrow_forward_ios,
              size: 18,
            ),
            onPressed: () {
              Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      const DateDetailScreen(),
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
          ),
        ],
      ),
    );
  }
}
