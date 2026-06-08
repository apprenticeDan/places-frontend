import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget{
  final String textoBoton;
  final VoidCallback? onPressed;
  
  const RoundedButton(
    this.textoBoton, 
    {super.key, this.onPressed});
    
  @override
  Widget build(BuildContext context) {
    final roundedButton = InkWell(
      onTap: onPressed ?? () { 
        // 👈 AQUÍ VINCULAMOS. Si no pasas nada, hace este SnackBar por defecto.
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Navegando..."),
          )
        );
      },
      onDoubleTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Cayendo al boliche..."),
            )
        );
      },
      child: Container(
        height: 50,
        width: 160,
        margin: EdgeInsets.only(
          top: 20,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          gradient: LinearGradient(
            colors: [
              Color(0xFF4268D3),
              Color(0xFF574ACF)
            ],
            begin: FractionalOffset(0.0, 0.5),
            end: FractionalOffset(1.0, 0.5),
            stops: [0.0, 0.5],
          )
        ),
        child: Center(
          child: Text(
            textoBoton,
            style: TextStyle(
              fontFamily: "Lato",
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: Colors.white
            ),
          ),
        ),
      ),
    );
    return roundedButton;
  }
}
