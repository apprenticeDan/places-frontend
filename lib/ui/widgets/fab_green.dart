import 'package:flutter/material.dart';

class FabGreen extends StatefulWidget {
  const FabGreen({super.key});

  @override
  State<StatefulWidget> createState(){
    return _FabGreen();
  }
}

class _FabGreen extends State<FabGreen>{
  var _fabIcon = Icons.favorite_border;

  void onPressedFav(){
    setState(() {
      if(_fabIcon == Icons.favorite_border){
        _fabIcon = Icons.favorite;
      } else {
        _fabIcon = Icons.favorite_border;
      }
    });
  }

  @override
  Widget build(BuildContext context){
    final fabGreen = FloatingActionButton(
      heroTag: null, // Evita colisiones de Hero animations si hay múltiples FABs
      backgroundColor: Color(0xFF16db58),
      mini: true,
      tooltip: "Fab",
      shape: CircleBorder(),
      onPressed: onPressedFav,
      child: Icon(
        _fabIcon,
        color: Colors.white,
      ),
    );
    return fabGreen;
  }
}