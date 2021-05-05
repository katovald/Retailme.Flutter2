import 'dart:async';

import 'package:ic_nominas/presentation/helpers/constants.dart';
import 'package:ic_nominas/presentation/helpers/expandable_fab.dart';
import 'package:material_dialogs/material_dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter/material.dart';

class MediaVideoView extends StatefulWidget {
  final MediaArguments args;

  MediaVideoView({Key key, this.args}) : super(key: key);

  @override
  MediaVideoViewState createState() => MediaVideoViewState();
}

class MediaVideoViewState extends State<MediaVideoView>{
  VideoPlayerController _controller;
  Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset(widget.args.url);
    _initializeVideoPlayerFuture = _controller.initialize();
    _controller.setLooping(false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: videoPlayer,
      floatingActionButton: ExpandableFab(
        distance: 112.0,
        children: [
          ActionButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back),
          ),
          ActionButton(
            onPressed: (){
              showInformationDialog(context);
            },
            icon: const Icon(Icons.add),
          ),
          ActionButton(
            onPressed: () {

            } ,
            icon: const Icon(Icons.share),
          ),
          ActionButton(
            onPressed: () => Dialogs.bottomMaterialDialog(
              titleStyle: TextStyle(color: Colors.black),
              color: Colors.white,
              msgStyle: TextStyle(color: Colors.black),
              msg: 'Felicitaciones, revela un QR para una promocion',
              title: 'Felicidades',
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
                    onPressed: () {
                      //TODO: QR code promo view
                    },
                    text: 'Ver',
                    iconData: Icons.qr_code,
                    color: Colors.blue,
                    textStyle: TextStyle(color: Colors.white),
                    iconColor: Colors.white,
                  ),
                ],
          ),
            icon: const Icon(Icons.card_giftcard),
          ),
        ],
      ),
    );
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
}