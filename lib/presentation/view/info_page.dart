import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:retailmi/presentation/controller/info_page_controller.dart';
import 'package:retailmi/presentation/helpers/constants.dart';
import 'package:retailmi/presentation/helpers/expandable_fab.dart';

class InfoView extends View{
  InfoView({Key key, this.args}) : super(key: key);

  final ProductsArguments args;

  @override
  InfoViewState createState() => InfoViewState();

}

class InfoViewState extends ViewState<InfoView, InfoViewController>{
  InfoViewState() : super(InfoViewController());

  @override
  // TODO: implement view
  Widget get view => SafeArea(child: Scaffold(
    key: globalKey,
    body: body,
    floatingActionButton: floatingButton,
  ));

  Stack get body => Stack(
    children: <Widget>[
      background,
      productPresentation,
      recetas,
      promos,
      media,
    ],
  );

  Container get background => Container(
    width: MediaQuery.of(context).size.width,
    height: MediaQuery.of(context).size.height,
    decoration: BoxDecoration(
        image: DecorationImage(
            image: NetworkImage(widget.args.bg),
            fit: BoxFit.fill
        )
    ),
  );

  Positioned get productPresentation => Positioned(
    top: 20.0,
    left: MediaQuery.of(context).size.width / 2 - 200,
    child: Center(
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height / 8,
                  bottom: 10.0),
              child: Container(
                width: 200,
                height: 400,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    color: Colors.black87,
                    image: DecorationImage(
                      image: NetworkImage(widget.args.imgPrincipal),
                      fit: BoxFit.contain
                    )
                ),
              ),
            ),
            Text(
              widget.args.title,
              style: TextStyle(
                color: Colors.black87,
                fontSize: 32.0,
                fontWeight: FontWeight.w300,
                letterSpacing: 2.0,
              ),
            )
          ],
        ),
      ),
    ),
  );
  
  Widget get recetas => ControlledWidgetBuilder<InfoViewController>(builder: (context, controller) {
    if(widget.args.recetas.length > 0){
      return Positioned(
        top: 10.0,
        left: 10.0,
        child: Container(
          width: 200,
          height: 200,
          child: ListView.builder(itemBuilder: (BuildContext ctx, int index) {
            return new GestureDetector(
              onTap: () {
                controller.presentVideo(widget.args.recetas[index]);
              },
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Container(
                  width: 180.0,
                  height: 30.0,
                  alignment: FractionalOffset.center,
                  decoration: BoxDecoration(
                      color: Colors.black87,
                      borderRadius: BorderRadius.circular(10.0)),
                  child: Text('Receta ' + (index + 1).toString(),
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                          fontWeight: FontWeight.w300,
                          letterSpacing: 0.4)
                  ),
                ),
              ),
            );
          },
            itemCount: widget.args.recetas.length,
          ),
        ),
      );
    } else {
      return Container(
        width: 1,
        height: 1,
      );
    }
  });

  Widget get promos => ControlledWidgetBuilder<InfoViewController>(builder: (context, controller) {
    if(widget.args.promos.length > 0){
      return Positioned(
        top: 10.0,
        right: 10.0,
        child: Container(
          width: 200,
          height: 200,
          child: ListView.builder(itemBuilder: (BuildContext ctx, int index) {
            return new GestureDetector(
              onTap: () {
                controller.presentVideo(widget.args.promos[index]);
              },
              child: Container(
                width: 180.0,
                height: 30.0,
                alignment: FractionalOffset.center,
                decoration: BoxDecoration(
                    color: Colors.black87,
                    borderRadius: BorderRadius.circular(10.0)),
                child: Text('Promo ' + index.toString(),
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                        fontWeight: FontWeight.w300,
                        letterSpacing: 0.4)
                ),
              ),
            );
          },
            itemCount: widget.args.promos.length,
          ),
        ),
      );
    } else {
      return Container(
        width: 1,
        height: 1,
      );
    }
  });

  Widget get media => ControlledWidgetBuilder<InfoViewController>(builder: (context, controller) {
    if(widget.args.media.length > 0){
      return Positioned(
        bottom: 10.0,
        left: 10.0,
        child: Container(
          width: 200,
          height: 200,
          child: ListView.builder(itemBuilder: (BuildContext ctx, int index) {
            return new GestureDetector(
              onTap: () {
                controller.presentVideo(widget.args.media[index]);
              },
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Container(
                  width: 180.0,
                  height: 30.0,
                  alignment: FractionalOffset.center,
                  decoration: BoxDecoration(
                      color: Colors.black87,
                      borderRadius: BorderRadius.circular(10.0)),
                  child: Text('Video ' + (index + 1).toString(),
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                          fontWeight: FontWeight.w300,
                          letterSpacing: 0.4)
                  ),
                ),
              ),
            );
          },
            itemCount: widget.args.media.length,
          ),
        ),
      );
    } else {
      return Container(
        width: 1,
        height: 1,
      );
    }
  });

  ExpandableFab get floatingButton => ExpandableFab(
    distance: 112.0,
    children: [
      ActionButton(
        onPressed: (){},
        icon: const Icon(Icons.call),
      ),
      ActionButton(
        onPressed: (){},
        icon: const Icon(Icons.chat),
      ),
      ActionButton(
        onPressed: (){},
        icon: const Icon(Icons.mail_rounded),
      )
    ],
  );
}