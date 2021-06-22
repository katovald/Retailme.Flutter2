import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:retailmi/domain/helpers/constants.dart';
import 'package:retailmi/domain/models/product_model.dart';
import 'package:retailmi/domain/repositories/data_auth_repo.dart';
import 'package:retailmi/presentation/controller/home_page_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends View {
  HomePage() {
    getProducts().then((value) => {
          this.imgList = value,
          print("-------------------retorno del future-----------"),
          print(value.map((e) => e.toString()))
        });
  }

  Future<List<Product>> getProducts() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    Map<String, dynamic> json =
        jsonDecode(pref.getString(Constants.sucursalInfo));
    this.backgroundUrl = json['videoUrl'];
    List<dynamic> prods = json['products'];
    List<Product> productos = [];
    prods.forEach((product) {
      Product newProduct = Product(
          id: product['id'],
          title: product['title'],
          description: product['description'],
          over18: product['over18'],
          barcode: product['barcode']);

      List<dynamic> multiInfo = product['multimedias'];
      multiInfo.forEach((multim) {
        Map<String, dynamic> multiI = Map<String, dynamic>.from(multim);
        newProduct.multimedias.add(new Multimedia(
            id: multiI['id'],
            title: multiI['title'],
            description: multiI['description'],
            multimediaTypeValue: multiI['multimediaTypeValue'],
            multimediaType: multiI['multimediaType'],
            url: multiI['url'],
            position: multiI['position'],
            enable: multiI['enable']));
      });
      print("..........producto...........");
      print(newProduct.toString());
      print("..........finproducto...........");
      productos.add(newProduct);
    });
    return productos;
  }

  String backgroundUrl;

  List<Product> imgList = [];

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends ViewState<HomePage, HomePageController> {
  HomePageState() : super(HomePageController());

  CarouselController _controller = CarouselController();

  @override
  Widget get view => Scaffold(
        key: globalKey,
        body: body,
      );

  Stack get body => Stack(
        children: <Widget>[background, camera, pictureCarrousel],
      );

  Widget get background => Positioned(
        left: 0,
        top: 0,
        child: Container(
          width: MediaQuery.of(context).size.width -
              MediaQuery.of(context).size.width / 4,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(widget.backgroundUrl),
                  fit: BoxFit.fitHeight)),
        ),
      );

  Widget get camera => ControlledWidgetBuilder<HomePageController>(
          builder: (context, controller) {
        return Positioned(
          bottom: (MediaQuery.of(context).size.width -
                  MediaQuery.of(context).size.width / 4) /
              30,
          left: (MediaQuery.of(context).size.width -
                      MediaQuery.of(context).size.width / 4) /
                  2 -
              MediaQuery.of(context).size.height / 8,
          child: GestureDetector(
            onTap: () {
              controller.startScan(widget.imgList);
            },
            child: Container(
              width: MediaQuery.of(context).size.height / 4,
              height: MediaQuery.of(context).size.height / 4,
              alignment: FractionalOffset.center,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  image: DecorationImage(
                    image: AssetImage('assets/img/logo.png'),
                  )),
            ),
          ),
        );
      });

  Widget get pictureCarrousel => Positioned(
        right: 0,
        child: ControlledWidgetBuilder<HomePageController>(
            builder: (context, controller) {
          return Stack(
            children: [
              Container(
                color: Color.fromRGBO(254, 232, 208, 0.9),
                width: MediaQuery.of(context).size.width / 4,
                height: MediaQuery.of(context).size.height,
                child: CarouselSlider(
                  options: CarouselOptions(
                    autoPlay: false,
                    aspectRatio: 2.0,
                    enlargeCenterPage: true,
                  ),
                  carouselController: _controller,
                  items: imageButtonSliders,
                ),
              ),
              Positioned(
                bottom: 10,
                child: IconButton(
                  icon: Icon(Icons.arrow_back_ios),
                  onPressed: () => _controller.previousPage(),
                  color: Colors.black,
                  iconSize: 50,
                ),
              ),
              Positioned(
                right: 0,
                bottom: 10,
                child: IconButton(
                  icon: Icon(Icons.arrow_forward_ios),
                  onPressed: () => _controller.nextPage(),
                  color: Colors.black,
                  iconSize: 50,
                ),
              ),
            ],
          );
        }),
      );

  List<Widget> get imageButtonSliders => widget.imgList
      .map((item) => ControlledWidgetBuilder<HomePageController>(
              builder: (context, controller) {
            String url;
            item.multimedias.forEach((element) {
              if (element.multimediaType == 2 &&
                  element.description == "principal") {
                url = element.url;
              }
            });
            if (url == null) {
              item.multimedias.forEach((element) {
                if (element.multimediaType == 2) {
                  url = element.url;
                }
              });
            }
            print("--------------------------url----------------");
            print(url);
            print("--------------------------url----------------");
            if (url != null)
              return Container(
                color: Colors.transparent,
                child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    child: Stack(
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            controller.selectProduct(item);
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.height / 4,
                            height: MediaQuery.of(context).size.height,
                            alignment: FractionalOffset.center,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                image: DecorationImage(
                                  image: NetworkImage(url),
                                )),
                          ),
                        )
                      ],
                    )),
              );
            else
              return Container();
          }))
      .toList();
}
