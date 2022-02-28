/// File: routes.dart
/// Project: mobile
/// Created Date: Tuesday, May 25th 2021, 5:30:24 pm
/// Author: Dennis Bilson <codelbas.quabynah@gmail.com>
/// -----
/// Last Modified: Thursday, May 27th 2021 1:28:33 pm
/// Modified By: Dennis Bilson <codelbas.quabynah@gmail.com>
/// -----
/// Copyright (c) 2021 Quabynah Codelabs LLC

import 'package:auto_route/auto_route.dart';
import 'package:mobile/features/health/presentation/pages/healthy.videos.details.dart';
import 'package:mobile/features/home/presentation/pages/home.dart';
import 'package:mobile/features/home/presentation/pages/metric.reader.dart';
import 'package:mobile/features/home/presentation/pages/metric.result.dart';
import 'package:mobile/features/login/presentation/pages/login.dart';
import 'package:mobile/features/welcome/presentation/pages/welcome.dart';

// flutter packages pub run build_runner build --delete-conflicting-outputs
@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute(page: WelcomePage, initial: true),
    AutoRoute(page: HomePage),
    AutoRoute(page: LoginPage),
    AutoRoute(page: HealthyVideoDetailsPage),
    AutoRoute(page: MetricResultPage),
    AutoRoute(page: MetricReaderPage),
  ],
)
class $AppRouter {}
