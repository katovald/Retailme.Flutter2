import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:ic_nominas/presentation/controller/info_page_controller.dart';

class InfoView extends View{
  InfoView({Key key, this.title}) : super(key: key);

  final String title;

  @override
  InfoViewState createState() => InfoViewState();

}

class InfoViewState extends ViewState<InfoView, InfoViewController>{
  InfoViewState() : super(InfoViewController());

  Item selectedUser;

  Item selectedPromo;

  @override
  // TODO: implement view
  Widget get view => SafeArea(child: Scaffold(
    key: globalKey,
    body: body
  ));

  Stack get body => Stack(
    children: <Widget>[
      background,
      ListView(
        children: <Widget>[
          Column(
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Image(
                        image: AssetImage('assets/img/product.png'),
                        width: 300.0,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Padding(
                      padding: EdgeInsets.only(
                          top: 10.0,
                          left: 10.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width / 2,
                        child: Text("Aqui ira la descripcion de los productos, el texto se adecuara al tamaño de la pantalla, dependeindo de la descripcion guardada en la base de datos",
                          style: TextStyle(
                              color: Colors.white70
                          ),),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(10.0),
                      child: DropdownButton<Item>(
                        hint: Text('Opciones, menus, recetas, etc.'),
                        style: TextStyle(color: Colors.white70),
                        value: selectedUser,
                        onChanged: (Item value) {
                          setState(() {
                            selectedUser = value;
                          });
                        },
                        items: users.map((Item user) {
                          return DropdownMenuItem<Item>(
                            value: user,
                              child: Row(
                                children: <Widget>[
                                  user.icon,
                                  SizedBox(width: 10,),
                                  Text(
                                    user.name,
                                    style:  TextStyle(color: Colors.black),
                                  ),
                                ],
                              )
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(10.0),
                      child: DropdownButton<Item>(
                        hint: Text('Promociones, regalos, etc'),
                        style: TextStyle(color: Colors.white70),
                        value: selectedPromo,
                        onChanged: (Item value) {
                          setState(() {
                            selectedPromo = value;
                          });
                        },
                        items: promos.map((Item user) {
                          return DropdownMenuItem<Item>(
                              value: user,
                              child: Row(
                                children: <Widget>[
                                  user.icon,
                                  SizedBox(width: 10,),
                                  Text(
                                    user.name,
                                    style:  TextStyle(color: Colors.black),
                                  ),
                                ],
                              )
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ],
              ),
              mediaButton,
              SizedBox(height: 40.0),
              promoButton,
            ],
          ),
        ]
      ),
    ],
  );

  Container get background => Container(
    color: Color.fromRGBO(0, 0, 0, 0.8),
  );

  List<Item> users = <Item>[
    const Item('Video',Icon(Icons.play_circle_fill,color:  const Color(0xFF167F67),)),
    const Item('Galeria',Icon(Icons.image,color:  const Color(0xFF167F67),)),
    const Item('Publicacion',Icon(Icons.menu_book,color:  const Color(0xFF167F67),)),
    const Item('Compartir',Icon(Icons.share,color:  const Color(0xFF167F67),)),
  ];

  List<Item> promos = <Item>[
    const Item('Regalo',Icon(Icons.card_giftcard,color:  const Color(0xFF167F67),)),
    const Item('2x1',Icon(Icons.sports_motorsports,color:  const Color(0xFF167F67),)),
    const Item('3x2',Icon(Icons.account_balance_wallet,color:  const Color(0xFF167F67),)),
  ];

  Widget get mediaButton => ControlledWidgetBuilder<InfoViewController>(builder: (context, controller) {
    return GestureDetector(
      onTap: () {
        //controller.selectAction();
      },
      child: Container(
        width: 320.0,
        height: 50.0,
        alignment: FractionalOffset.center,
        decoration: BoxDecoration(
            color: Color.fromRGBO(230, 38, 50, 1.0),
            borderRadius: BorderRadius.circular(20.0)),
        child: Text("Media",
            style: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
                fontWeight: FontWeight.w300,
                letterSpacing: 0.4)
        ),
      ),
    );
  });

  Widget get promoButton => ControlledWidgetBuilder<InfoViewController>(builder: (context, controller) {
    return GestureDetector(
      onTap: () {
        //controller.selectPromo();
      },
      child: Container(
        width: 320.0,
        height: 50.0,
        alignment: FractionalOffset.center,
        decoration: BoxDecoration(
            color: Color.fromRGBO(230, 38, 50, 1.0),
            borderRadius: BorderRadius.circular(20.0)),
        child: Text("Promocion",
            style: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
                fontWeight: FontWeight.w300,
                letterSpacing: 0.4)
        ),
      ),
    );
  });

}

class Item {
  const Item(this.name,this.icon);
  final String name;
  final Icon icon;
}