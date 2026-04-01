import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class splash extends StatefulWidget {
  @override
  State<splash> createState() => _splashState();
}

class _splashState extends State<splash> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();

    _controller = VideoPlayerController.asset(
      "assets/video/splash.mp4",
    )
      ..initialize().then((_) {
        setState(() {});
        _controller.play();
      });

    // Navigate after video ends
    _controller.addListener(() {
      if (_controller.value.position ==
          _controller.value.duration) {
        Navigator.pushReplacementNamed(context, "/l");
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _controller.value.isInitialized
          ? SizedBox.expand(
        child: FittedBox(
          fit: BoxFit.cover,
          child: SizedBox(
            width: _controller.value.size.width,
            height: _controller.value.size.height,
            child: VideoPlayer(_controller),
          ),
        ),
      )
          : Center(child: CircularProgressIndicator()),
    );
  }
}