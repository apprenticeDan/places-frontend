import 'package:flutter/material.dart';
import 'package:places/domain/entities/review_entity.dart';
import 'package:places/ui/widgets/rating_stars.dart';

class Review extends StatelessWidget {

  final ReviewEntity reviewInfo;

  const Review({super.key, required this.reviewInfo});

  @override
  Widget build(BuildContext context){

    final foto = Container(
      margin: EdgeInsets.only(
        right: 10,
        top: 10,
      ),
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
          image: NetworkImage(
            reviewInfo.profileImageUrl
          ),
          fit: BoxFit.cover
        )
      ),
    );

    final nombreUsuario = Container(
      child: Text(
        reviewInfo.userName,
        style: TextStyle(
          fontFamily: "Lato",
          fontSize: 22
        ),
      ),
    );

    final resumenUsuario = Container(
      margin: EdgeInsets.only(
        right: 10,
      ),
      child: Text(
        reviewInfo.summary,
        style: TextStyle(
          fontFamily: "Lato",
          color: Colors.black54
        ),
      ),
    );

    final filaEstrellas = RatingStars(rating: reviewInfo.stars);

    final filaResumen = Row(
      children: <Widget>[
        resumenUsuario,
        filaEstrellas
      ],
    );

    final comentario = Container(
      child: Text(
        reviewInfo.comment,
          style: TextStyle(
          fontFamily: "Lato",
      ),
      ),
    );

    final columnaReview = Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        nombreUsuario,
        filaResumen,
        comentario
      ],
    );

    final review = Row(
      children: <Widget>[
        foto,
        columnaReview
      ],
    );
    return review;
  }
}