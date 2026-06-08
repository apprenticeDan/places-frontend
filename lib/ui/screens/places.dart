import 'package:flutter/material.dart';
import 'package:places/ui/screens/profile_places.dart';
import 'package:places/ui/screens/search_places.dart';

import 'home.dart';

class Places extends StatefulWidget{
  const Places({super.key});

  @override
  State<StatefulWidget> createState() {
    return _Places();
  }
}

class _Places extends State<Places>{

  int currentIndex = 0;

  List<Widget> pantallas = <Widget> [
    MyHome(),
    SearchPlaces(),
    ProfilePlaces(),
  ];

  void cambiarPantalla(int index ){
    setState(() {
      currentIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    final scaffold = Scaffold(
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: Colors.white,
          primaryColor: Color(0xFF574ACF)
        ),
        child: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                color: Color(0xFF574ACF),
              ),
              label: "",
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.search,
                color: Color(0xFF574ACF),
              ),
              label: "",
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
                color: Color(0xFF574ACF),
              ),
              label: "",
            ),
          ],
          onTap: cambiarPantalla,
        ),
      ),
      body: pantallas[currentIndex],
    );
    // ROLLBACK: Para deshabilitar la responsividad y que ocupe toda la pantalla,
    // comenta el Center y el ConstrainedBox, y descomenta el 'return scaffold;'
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 750),
        child: scaffold,
      ),
    );
    // return scaffold;
  }
}