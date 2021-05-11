import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

final List<String> imgList = [
  'assets/img/fresa.jpeg',
  'assets/img/chocolate.jpeg',
  'assets/img/horchata.jpeg',
  'assets/img/mango.jpeg',
  'assets/img/matcha.jpeg',
  'assets/img/piniacolada.jpeg'
];

final List<Widget> imageSliders = imgList.map((item) => Container(
  child: Container(
    margin: EdgeInsets.only(top: 30, bottom: 30),
    child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
        child: Stack(
          children: <Widget>[
            Image.asset(item, fit: BoxFit.cover, width: 1300.0),
            Positioned(
              bottom: 0.0,
              left: 0.0,
              right: 0.0,
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color.fromARGB(200, 0, 0, 0),
                      Color.fromARGB(0, 0, 0, 0)
                    ],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                ),
                padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                child: Text(
                  'Receta No. ${imgList.indexOf(item) + 1}',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        )
    ),
  ),
)).toList();

class RecipeCarrousel extends StatefulWidget {
  RecipeCarrousel({Key key}) : super( key: key );

  @override
  RecipeCarrouselState createState() => RecipeCarrouselState();

}

class RecipeCarrouselState extends State<RecipeCarrousel>
{
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: body,
    );
  }

  Widget get body => Stack(
    children: [
      pictureCarrousel,
      backButton,
    ],
  );

  Widget get pictureCarrousel => Padding(
      padding: EdgeInsets.all(10.0),
      child: Column(children: <Widget>[
        CarouselSlider(
          options: CarouselOptions(
            autoPlay: false,
            aspectRatio: 1.9,
            enlargeCenterPage: true,
          ),
          items: imageSliders,
        ),
      ],)
  );

  Widget get backButton => Positioned(
    bottom: 10.0,
    left: 10.0,
    child: FloatingActionButton.extended(
      onPressed: () {
        Navigator.of(context).pop();
      },
      icon: Icon(Icons.arrow_back),
      label: Text('Salir'),
      backgroundColor: Colors.redAccent,
    ),
  );
}