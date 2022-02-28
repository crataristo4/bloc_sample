/// File: healthy.videos.details.dart
/// Project: mobile
/// Created Date: Tuesday, May 25th 2021, 5:43:58 pm
/// Author: Dennis Bilson <codelbas.quabynah@gmail.com>
/// -----
/// Last Modified: Tuesday, June 1st 2021 10:43:23 pm
/// Modified By: Dennis Bilson <codelbas.quabynah@gmail.com>
/// -----
/// Copyright (c) 2021 Quabynah Codelabs LLC

import 'package:flutter/material.dart';
import 'package:mobile/core/util/ui.dart';
import 'package:mobile/features/home/domain/entities/featured.videos.dart';
import 'package:shared_utils/shared_utils.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class HealthyVideoDetailsPage extends StatefulWidget {
  final BaseFeaturedVideo featuredVideo;

  const HealthyVideoDetailsPage({Key? key, required this.featuredVideo})
      : super(key: key);
  @override
  _HealthyVideoDetailsPageState createState() =>
      _HealthyVideoDetailsPageState();
}

class _HealthyVideoDetailsPageState extends State<HealthyVideoDetailsPage> {
  YoutubePlayerController? _controller;

  @override
  void initState() {
    super.initState();

    if (mounted) {
      _controller = YoutubePlayerController(
        initialVideoId: widget.featuredVideo.url,
        params: YoutubePlayerParams(
          autoPlay: true,
          showControls: true,
          showFullscreenButton: true,
        ),
      );
      setState(() {});
    }
  }

  @override
  void dispose() {
    _controller?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var kTheme = Theme.of(context);
    var kColorScheme = kTheme.colorScheme;

    var lightTheme = kTheme.brightness == Brightness.light;

    kUseDefaultOverlays(
      statusColor: kColorScheme.background,
      statusIconBrightness: lightTheme ? Brightness.dark : Brightness.light,
      navColor: kColorScheme.background,
      navIconColor: kColorScheme.background,
    );

    return Scaffold(
      body: Column(
        children: [
          YoutubePlayerIFrame(
            controller: _controller,

            // showVideoProgressIndicator: true,
            // progressIndicatorColor: Colors.amber,
            // progressColors: ProgressBarColors(
            // playedColor: Colors.amber,
            // handleColor: Colors.amberAccent,
            // ),
            // onReady: () {
            // _controller.addListener(() {});
            // },
          ).centered(),
        ],
      ),
    );
  }
}

// YoutubePlayerController _controller = YoutubePlayerController(
//       initialVideoId: YoutubePlayer.convertUrlToId('https://www.youtube.com/watch?v=oOKq7_KfZkM') ??
//           Uuid().v4(),
//       flags: YoutubePlayerFlags(
//         autoPlay: true,
//         mute: true,
//       ),
//     );


// Center(
//         child: YoutubePlayer(
//           controller: _controller,
//           showVideoProgressIndicator: true,
//           progressIndicatorColor: Colors.amber,
//           progressColors: ProgressBarColors(
//             playedColor: Colors.amber,
//             handleColor: Colors.amberAccent,
//           ),
//           onReady: () {
//             _controller.addListener(() {});
//           },
//         ),
//       ),
