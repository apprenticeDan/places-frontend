import 'package:flutter/material.dart';

import 'package:flutter/cupertino.dart';
import 'package:places/ui/screens/home.dart';
import 'package:places/ui/screens/profile_places.dart';
import 'package:places/ui/screens/search_places.dart';

class PlacesCupertino extends StatelessWidget{
  const PlacesCupertino({super.key});

  @override
  Widget build(BuildContext context) {
    final places = CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        backgroundColor: Colors.white.withAlpha(50),
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: Color(0xFF574ACF),
            )
          ),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.search,
                color: Color(0xFF574ACF),
              )
          ),

          BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
                color: Color(0xFF574ACF),
              )
          ),
        ],
      ),
      tabBuilder: (BuildContext context, int index){
        CupertinoTabView cupertinoTabView = CupertinoTabView();

        switch(index){
          case 0:
            cupertinoTabView = CupertinoTabView(
              builder: (BuildContext context) => MyHome(),
            );
            break;
          case 1:
            cupertinoTabView = CupertinoTabView(
              builder: (BuildContext context) => SearchPlaces(),
            );
            break;
          case 2:
            cupertinoTabView = CupertinoTabView(
              builder: (BuildContext context) => ProfilePlaces(),
            );
            break;
        }

        return cupertinoTabView;
      }
    );

    // ROLLBACK: Para deshabilitar la responsividad y que ocupe toda la pantalla,
    // comenta el Center y el ConstrainedBox, y descomenta el 'return places;'
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 750),
        child: places,
      ),
    );
    // return places;
  }
}
