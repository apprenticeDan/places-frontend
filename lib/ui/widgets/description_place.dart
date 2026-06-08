import 'package:flutter/material.dart';
import 'package:places/ui/widgets/rounded_button.dart';
import 'package:places/ui/widgets/rating_stars.dart';

class DescriptionPlace extends StatelessWidget{
  // variables
  String textTitulo;
  int cantidadEstrellas;
  String textoDescripcion;

  DescriptionPlace(this.textTitulo, this.cantidadEstrellas, this.textoDescripcion, {super.key});

  @override
  Widget build(BuildContext context) {

    final titulo = Container(
      margin: EdgeInsets.only(
        right: 20
      ),
      child: Text(
        textTitulo,
        style: TextStyle(
          fontFamily: "Lato",
          fontSize: 38,
          fontWeight: FontWeight.bold
        ),
      ),
    );

    final filaEstrellas = RatingStars(rating: cantidadEstrellas);

    final filaTitulo = Row(
      children: <Widget>[
        titulo,
        filaEstrellas
      ],
    );
    final descripcion = Container(
      margin: EdgeInsets.only(
        top: 10
      ),
      child: Text(
        textoDescripcion,
        style: TextStyle(
          fontFamily: "Lato",
          color: Colors.black54,
        ),
      ),
    );

    final descriptionPlace = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        filaTitulo,
        descripcion,
        RoundedButton("Navigate")
      ],
    );

    return descriptionPlace;
  }
}


