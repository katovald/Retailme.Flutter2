import 'package:ic_nominas/presentation/helpers/constants.dart';
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

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.args.url)..initialize().then((_) {
      setState(() {});
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _controller.value.isInitialized
            ? AspectRatio(
          aspectRatio: _controller.value.aspectRatio,
          child: VideoPlayer(_controller),
        )
            : Container(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _controller.value.isPlaying
                ? _controller.pause()
                : _controller.play();
          });
        },
        child: Icon(
          _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
        ),
      ),
    );
  }



  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}