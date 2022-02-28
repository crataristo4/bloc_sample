/// File: login.dart
/// Project: mobile
/// Created Date: Tuesday, May 25th 2021, 5:24:02 pm
/// Author: Dennis Bilson <codelbas.quabynah@gmail.com>
/// -----
/// Last Modified: Thursday, June 10th 2021 8:20:43 am
/// Modified By: Dennis Bilson <codelbas.quabynah@gmail.com>
/// -----
/// Copyright (c) 2021 Quabynah Codelabs LLC
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/core/di/injector.dart';
import 'package:mobile/core/routes/routes.gr.dart';
import 'package:mobile/core/util/constants.dart';
import 'package:mobile/core/util/ui.dart';
import 'package:mobile/core/widgets/buttons.dart';
import 'package:mobile/core/widgets/form.input.dart';
import 'package:mobile/features/login/presentation/bloc/auth_cubit.dart';
import 'package:shared_utils/shared_utils.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // controller for name
  final _nameController = TextEditingController();

  // cubit
  final _authCubit = AuthCubit(localStorage: Injector.get());

  // UI state
  bool _loading = false;

  @override
  void dispose() {
    _authCubit.close();
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var kTheme = Theme.of(context);
    var kColorScheme = kTheme.colorScheme;

    kUseDefaultOverlays(
      isLightTheme: kTheme.brightness == Brightness.light,
      statusColor: kTransparent,
      navColor: kColorScheme.background,
      navIconColor: kColorScheme.background,
      statusIconBrightness: Brightness.light,
    );

    return BlocListener<AuthCubit, BlocState>(
      bloc: _authCubit,
      listener: (context, state) {
        _loading = state is LoadingState;
        if (mounted) setState(() {});
        if (state is SuccessState) {
          // move to home page
          context.router.pushAndPopUntil(
            HomeRoute(),
            predicate: (_) => false,
          );
        } else if (state is ErrorState) {
          _loading = false;
          if (mounted) setState(() {});
          context.showSnackBar(state.failure.toString());
        }
      },
      child: Scaffold(
        body: _loading
            ? CircularProgressIndicator().centered()
            : Column(
                children: [
                  Expanded(
                    flex: 5,
                    child: Container(
                      decoration: BoxDecoration(
                        color: kColorScheme.secondary,
                        image: DecorationImage(
                          image: AssetImage(kLinkSix),
                          fit: BoxFit.cover,
                          alignment: Alignment.topCenter,
                          colorFilter: ColorFilter.mode(
                            Colors.black38,
                            BlendMode.darken,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        'Welcome to '.h5(context).bottom(kSpacingX6),
                        'Plan a consistent health life right from the app'
                            .subtitle2(context),
                        FormInputField(
                          hint: 'e.g. Ella Doe',
                          label: 'Username',
                          controller: _nameController,
                          onSubmit: (input) => _validateAndSave(),
                        ).top(kSpacingX12),
                        RoundedButton(
                          label: 'Get started',
                          onPressed: _validateAndSave,
                        ).top(kSpacingX28),
                      ],
                    ).horizontal(kSpacingX36),
                  ),
                ],
              ),
      ),
    );
  }

  /// validate username and login
  void _validateAndSave() async {
    if (_nameController.text.isNullOrEmpty()) {
      context.showSnackBar('Enter your full name first');
      return;
    }

    // sign in user
    _authCubit.setUser(_nameController.text.trim());
  }
}
