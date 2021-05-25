import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:retailmi/domain/models/recipe_model.dart';

final List<Recipe> imgList = [
  new Recipe(imgUrl: 'assets/img/fresa.jpeg', description: 'Baileys Shakeado con fresa', name: 'BAILEYS FRESA SHAKEADO'),
  new Recipe(imgUrl: 'assets/img/chocolate.jpeg', description: 'Baileys Shakeado con chocolate', name: 'BAILEYS CHOCOLATE SHAKEADO'),
  new Recipe(imgUrl: 'assets/img/horchata.jpeg', description: 'Baileys Shakeado con horchata', name: 'BAILEYS HORCHATA SHAKEADO'),
  new Recipe(imgUrl: 'assets/img/mango.jpeg', description: 'Baileys Shakeado con mango', name: 'BAILEYS MANGO SHAKEADO'),
  new Recipe(imgUrl: 'assets/img/matcha.jpeg', description: 'Baileys Shakeado con matcha', name: 'BAILEYS MATCHA SHAKEADO'),
  new Recipe(imgUrl: 'assets/img/piniacolada.jpeg', description: 'Baileys Shakeado con piña colada', name: 'BAILEYS PIÑA COLADA SHAKEADO')
];

final List<Widget> imageSliders = imgList.map((item) => Container(
  child: Container(
    margin: EdgeInsets.only(top: 30, bottom: 30),
    child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
        child: Stack(
          children: <Widget>[
            Image.asset(item.imgUrl, fit: BoxFit.cover, width: 1300.0),
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
                  item.name,
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

  Widget get pictureCarrousel => Container(
    width: MediaQuery.of(context).size.width,
    height: MediaQuery.of(context).size.height,
    child: Padding(
        padding: EdgeInsets.all(10.0),
        child: CarouselSlider(
          options: CarouselOptions(
            autoPlay: false,
            aspectRatio: 1.9,
            enlargeCenterPage: true,
          ),
          items: imageSliders,
        ),
    ),
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