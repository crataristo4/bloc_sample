/// File: auth_cubit.dart
/// Project: mobile
/// Created Date: Thursday, May 27th 2021, 10:39:34 am
/// Author: Dennis Bilson <codelbas.quabynah@gmail.com>
/// -----
/// Last Modified: Thursday, May 27th 2021 11:25:37 am
/// Modified By: Dennis Bilson <codelbas.quabynah@gmail.com>
/// -----
/// Copyright (c) 2021 Quabynah Codelabs LLC

import 'package:bloc/bloc.dart';
import 'package:mobile/core/helpers/local.storage.dart';
import 'package:shared_utils/shared_utils.dart';

class AuthCubit extends Cubit<BlocState> {
  final BaseLocalStorage localStorage;
  AuthCubit({required this.localStorage}) : super(BlocState.initialState());

  // get login state
  Future<void> getLoginState() async {
    emit(BlocState.loadingState());
    emit(BlocState<bool>.successState(data: localStorage.loggedIn));
  }

  // get user details
  Future<void> getUser() async {
    emit(BlocState.loadingState());

    if (localStorage.loggedIn)
      emit(BlocState<String>.successState(data: localStorage.username));
    else
      emit(BlocState.errorState(failure: 'No user found'));
  }

  // set username
  Future<void> setUser(String username) async {
    emit(BlocState.loadingState());
    await Future.delayed(Duration(seconds: 2)); // simulate delay
    await localStorage.updateUsername(username);
    emit(BlocState<String>.successState(data: username));
  }

  // logout user
  Future<void> logOut() async {
    emit(BlocState.loadingState());
    await localStorage.logOut();
    emit(BlocState.successState(data: null));
  }
}
