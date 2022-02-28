/// File: featured.video.tile.dart
/// Project: mobile
/// Created Date: Thursday, May 27th 2021, 1:41:53 pm
/// Author: Dennis Bilson <codelbas.quabynah@gmail.com>
/// -----
/// Last Modified: Thursday, June 10th 2021 5:40:37 pm
/// Modified By: Dennis Bilson <codelbas.quabynah@gmail.com>
/// -----
/// Copyright (c) 2021 Quabynah Codelabs LLC
import 'package:flutter/material.dart';
import 'package:mobile/core/util/intents.dart';
import 'package:mobile/features/home/domain/entities/featured.videos.dart';
import 'package:share/share.dart';
import 'package:shared_utils/shared_utils.dart';

class FeaturedVideoTile extends StatefulWidget {
  final BaseFeaturedVideo featuredVideo;

  const FeaturedVideoTile({
    Key? key,
    required this.featuredVideo,
  }) : super(key: key);

  @override
  _FeaturedVideoTileState createState() => _FeaturedVideoTileState();
}

class _FeaturedVideoTileState extends State<FeaturedVideoTile> {
  @override
  Widget build(BuildContext context) {
    var kTheme = Theme.of(context);
    var kColorScheme = kTheme.colorScheme;

    return Container(
      height: context.height * 0.35,
      width: context.width,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: kColorScheme.surface,
        borderRadius: BorderRadius.circular(kSpacingX12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Container(
              clipBehavior: Clip.antiAlias,
              width: context.width,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(kSpacingX12)),
              child: Image.asset(
                widget.featuredVideo.img,
                width: context.width,
                fit: BoxFit.cover,
                alignment: Alignment.topCenter,
              ),
            ),
          ),

          // title
          Text(
            widget.featuredVideo.title,
            style: kTheme.textTheme.subtitle1?.copyWith(
                color: kColorScheme.onSurface, fontWeight: FontWeight.w600),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ).horizontal(kSpacingX16).vertical(kSpacingX8),

          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              // play video icon
              Container(
                decoration: BoxDecoration(
                  color: kColorScheme.secondary,
                  borderRadius: BorderRadius.circular(kSpacingX8),
                ),
                width: kSpacingX40,
                height: kSpacingX40,
                alignment: Alignment.center,
                child: Icon(
                  Icons.play_arrow_outlined,
                  color: kColorScheme.onSecondary,
                ),
              )
                  .clickable(
                    onTap: () => openUrl(widget.featuredVideo.url),
                  )
                  .right(kSpacingX12),

              // Share video icon
              Container(
                decoration: BoxDecoration(
                  color: kColorScheme.background,
                  borderRadius: BorderRadius.circular(kSpacingX8),
                ),
                width: kSpacingX40,
                height: kSpacingX40,
                alignment: Alignment.center,
                child: Icon(Icons.share_outlined),
              ).clickable(
                onTap: () => Share.share(
                    '${widget.featuredVideo.title}\n${widget.featuredVideo.url}'),
              ),
            ],
          ).top(kSpacingX12).right(kSpacingX24),
        ],
      ).bottom(kSpacingX20),
    );
  }
}
