import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:retailmi/presentation/controller/media_video_page_controller.dart';
import 'package:retailmi/presentation/helpers/expandable_fab.dart';
import 'package:retailmi/presentation/helpers/constants.dart';
import 'package:retailmi/presentation/view/custom_dialog.dart';
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
  Timer _backTime;

  MediaVideoViewState() : super(MediaVideoViewController());

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset(widget.args.url);
    _initializeVideoPlayerFuture = _controller.initialize().then((value) =>
    {
      _controller.addListener(() {
        if(!_controller.value.isPlaying && (_controller.value.duration >= _controller.value.position))
          {
            startTimer();
          }
      })
    });
    _controller.setLooping(false);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
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
        InkWell(
          onTap: () {
            stopTimer();
            Navigator.of(context).pushNamed('/recipe');
          },
          child: Image.asset('assets/img/Recetas.ico'),
        ),
        InkWell(
          onTap: () async {
            stopTimer();
            await showDialog(
                context: context,
                builder: (_) => ImageDialog('assets/img/promoQR.png')
            );
          },
          child: Image.asset('assets/img/ChatBot.ico'),
        ),
        InkWell(
          onTap: () {
            stopTimer();
            showDialog(context: context, builder: (BuildContext context) {
              return CustomMediaDialog(args: MediaArguments('', 'assets/img/backgroundPromo.png', ''));
            });
          },
          child: Image.asset('assets/img/Promociones.ico'),
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

  void stopTimer(){
    if(_backTime != null){
      _backTime.cancel();
      _backTime = null;
    }
  }

  void startTimer(){
    _backTime = Timer(Duration(seconds: 15), () {
      Navigator.of(context).pop();
    });
  }
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