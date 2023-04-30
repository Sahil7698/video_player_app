import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../../utils/video_utils.dart';

class VideoPage extends StatefulWidget {
  final String video;
  const VideoPage({Key? key, required this.video}) : super(key: key);

  @override
  State<VideoPage> createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> with TickerProviderStateMixin {
  VideoPlayerController? videoPlayerController;
  AnimationController? animationController;
  ChewieController? chewieController;

  @override
  void initState() {
    super.initState();

    animationController = AnimationController(
      vsync: this,
      duration: const Duration(
        microseconds: 250,
      ),
    );

    videoPlayerController =
        VideoPlayerController.asset(videoPath + widget.video)
          ..initialize().then(
            (value) => setState(() {}),
          );

    chewieController = ChewieController(
      videoPlayerController: videoPlayerController!,
      autoPlay: false,
      aspectRatio: 4 / 2,
      additionalOptions: (context) => [
        OptionItem(
          onTap: () {},
          iconData: Icons.settings,
          title: "Settings",
        ),
        OptionItem(
          onTap: () {},
          iconData: Icons.person,
          title: "Profile",
        ),
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();
    videoPlayerController!.dispose();
    animationController!.dispose();
    chewieController!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(Icons.arrow_back_ios_new),
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          "Video Player",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        ),
      ),
      body: Center(
        child: AspectRatio(
          aspectRatio: videoPlayerController!.value.aspectRatio,
          child: Chewie(
            controller: chewieController!,
          ),
        ),
      ),
    );
  }
}
