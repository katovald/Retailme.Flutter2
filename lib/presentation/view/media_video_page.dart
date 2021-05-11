import 'dart:async';

import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:retailmi/presentation/controller/media_video_page_controller.dart';
import 'package:retailmi/presentation/helpers/expandable_fab.dart';
import 'package:retailmi/presentation/helpers/constants.dart';
import 'package:material_dialogs/material_dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter/material.dart';

class MediaVideoView extends View {
  final MediaArguments args;

  MediaVideoView({Key key, this.args}) : super(key: key);

  @override
  MediaVideoViewState createState() => MediaVideoViewState();
}

class MediaVideoViewState extends ViewState<MediaVideoView, MediaVideoViewController>{
  VideoPlayerController _controller;
  Future<void> _initializeVideoPlayerFuture;

  MediaVideoViewState() : super(MediaVideoViewController());

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset(widget.args.url);
    _initializeVideoPlayerFuture = _controller.initialize();
    _controller.setLooping(false);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  Future<void> showInformationDialog(BuildContext context) async {
    return await showDialog(
        context: context,
        builder: (context) {
          bool isChecked = false;
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              content: Form(
                  key: GlobalKey(),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormField(
                        validator: (value) {
                          return value.isNotEmpty ? null : "No puede ser vacio";
                        },
                        decoration:
                        InputDecoration(hintText: "Correo"),
                      ),
                      TextFormField(
                        validator: (value) {
                          return value.isNotEmpty ? null : "No puede ser vacio";
                        },
                        decoration:
                        InputDecoration(hintText: "Edad"),
                      ),
                      TextFormField(
                        validator: (value) {
                          return value.isNotEmpty ? null : "No puede ser vacio";
                        },
                        decoration:
                        InputDecoration(hintText: "Telefono"),
                      ),
                    ],
                  )),
              title: Text('Tus datos son necesarios'),
              actions: <Widget>[
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Container(
                  width: 320.0,
                  height: 50.0,
                  alignment: FractionalOffset.center,
                  decoration: BoxDecoration(
                  color: Colors.black87,
                  borderRadius: BorderRadius.circular(10.0)),
                  child: Text('OK',
                    style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.w300,
                    letterSpacing: 0.4)
                    ),
                  ),
                ),
              ],
            );
          });
        });
  }

  FutureBuilder get videoPlayer =>  FutureBuilder(
    future: _initializeVideoPlayerFuture,
    builder: (context, snapshot) {
      if(snapshot.connectionState == ConnectionState.done){
        _controller.play();
        return Center(
          child: AspectRatio(aspectRatio: _controller.value.aspectRatio, child: VideoPlayer(_controller),),
        );
      }else{
        return Center(child: CircularProgressIndicator(),);
      }
    },
  );

  @override
  // TODO: implement view
  Widget get view => Scaffold(
    body: body,
    floatingActionButton: ExpandableFab(
      distance: 140.0,
      children: [
        GestureDetector(
          onTap: () {
            Navigator.of(context).popAndPushNamed('/recipe');
          },
          child: Container(
            width: 100.0,
            height: 30.0,
            alignment: FractionalOffset.center,
            decoration: BoxDecoration(
                color: Colors.black87,
                borderRadius: BorderRadius.circular(10.0)),
            child: Text("Recetas",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.0,
                    fontWeight: FontWeight.w300,
                    letterSpacing: 0.4)
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            showInformationDialog(context);
          },
          child: Container(
            width: 100.0,
            height: 30.0,
            alignment: FractionalOffset.center,
            decoration: BoxDecoration(
                color: Colors.black87,
                borderRadius: BorderRadius.circular(10.0)),
            child: Text("Datos",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.0,
                    fontWeight: FontWeight.w300,
                    letterSpacing: 0.4)
            ),
          ),
        ),
        GestureDetector(
          onTap: () async {
            await showDialog(
                context: context,
                builder: (_) => ImageDialog('assets/img/robotQR.png')
            );
          },
          child: Container(
            width: 100.0,
            height: 30.0,
            alignment: FractionalOffset.center,
            decoration: BoxDecoration(
                color: Colors.black87,
                borderRadius: BorderRadius.circular(10.0)),
            child: Text("ChatBot",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.0,
                    fontWeight: FontWeight.w300,
                    letterSpacing: 0.4)
            ),
          ),
        ),
        GestureDetector(
          onTap: () => Dialogs.materialDialog(
            titleStyle: TextStyle(color: Colors.black),
            color: Colors.white,
            msgStyle: TextStyle(color: Colors.black),
            msg: 'Por participar tienes la oportunidad de obtener promociones, solo escanea el QR',
            title: 'Muchas gracias',
            animation: 'assets/anim/cong_anim.json',
            context: context,
            actions: [
              IconsButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                text: 'Cancelar',
                iconData: Icons.close,
                color: Colors.red,
                textStyle: TextStyle(color: Colors.white),
                iconColor: Colors.white,
              ),
              IconsButton(
                onPressed: () async {
                  await showDialog(
                      context: context,
                      builder: (_) => ImageDialog('assets/img/promoQR.png')
                  );
                },
                text: 'Ver',
                iconData: Icons.qr_code,
                color: Colors.blue,
                textStyle: TextStyle(color: Colors.white),
                iconColor: Colors.white,
              ),
            ],
          ),
          child: Container(
            width: 100.0,
            height: 30.0,
            alignment: FractionalOffset.center,
            decoration: BoxDecoration(
                color: Colors.black87,
                borderRadius: BorderRadius.circular(10.0)),
            child: Text("Promociones",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.0,
                    fontWeight: FontWeight.w300,
                    letterSpacing: 0.4)
            ),
          ),
        ),
      ],
    ),
  );

  Widget get body => Stack(
    children: [
      videoPlayer,
      backButton,
    ],
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

class ImageDialog extends StatelessWidget {
  final String _url;

  ImageDialog(this._url);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        width: 400,
        height: 400,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Center(
                child: Text('Escanea para conocerlo', style: TextStyle(fontSize: 20),),
              ),
            ),
            Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                color: Colors.white,
                  image: DecorationImage(
                      image: AssetImage(_url),
                      fit: BoxFit.fitHeight
                  )
              ),
            ),
          ],
        ),
      ),
    );
  }
}