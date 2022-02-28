/// File: featured_video_cubit.dart
/// Project: mobile
/// Created Date: Thursday, May 27th 2021, 1:43:37 pm
/// Author: Dennis Bilson <codelbas.quabynah@gmail.com>
/// -----
/// Last Modified: Thursday, May 27th 2021 2:03:00 pm
/// Modified By: Dennis Bilson <codelbas.quabynah@gmail.com>
/// -----
/// Copyright (c) 2021 Quabynah Codelabs LLC

import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile/features/home/data/models/featured.videos.dart';
import 'package:mobile/features/home/domain/entities/featured.videos.dart';

import 'package:shared_utils/shared_utils.dart';

class FeaturedVideoCubit extends Cubit<BlocState> {
  FeaturedVideoCubit() : super(BlocState.initialState());

  Future<void> loadVideos(BuildContext context) async {
    emit(BlocState.loadingState());
    // load videos async
    var src = await rootBundle.loadString('assets/videos.json');
    var decoded = jsonDecode(src) as List;
    var result = <BaseFeaturedVideo>[];
    for (var json in decoded) {
      // add decoded video to list
      result.add(FeaturedVideo.fromJson(json));
    }

    // update UI
    emit(
      result.isEmpty
          ? BlocState.errorState(failure: [])
          : BlocState<List<BaseFeaturedVideo>>.successState(data: result),
    );
  }
}
