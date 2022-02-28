/// File: theme_cubit.dart
/// Project: mobile
/// Created Date: Thursday, May 27th 2021, 11:02:08 am
/// Author: Dennis Bilson <codelbas.quabynah@gmail.com>
/// -----
/// Last Modified: Thursday, May 27th 2021 11:08:44 am
/// Modified By: Dennis Bilson <codelbas.quabynah@gmail.com>
/// -----
/// Copyright (c) 2021 Quabynah Codelabs LLC

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:mobile/core/helpers/local.storage.dart';
import 'package:shared_utils/shared_utils.dart';

/// theme bloc implementation
class ThemeCubit extends Cubit<BlocState> {
  final BaseLocalStorage localStorage;
  ThemeCubit({required this.localStorage}) : super(BlocState.initialState());

  Future<void> updateTheme(ThemeMode themeMode) async {
    emit(BlocState.loadingState());
    await localStorage.updateTheme(themeMode);
    emit(BlocState<ThemeMode>.successState(data: themeMode));
  }

  Future<void> getCurrentTheme() async {
    emit(BlocState.loadingState());
    emit(BlocState<ThemeMode>.successState(data: localStorage.currentTheme));
  }
}
