// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:auto_route/auto_route.dart' as _i1;
import 'package:flutter/material.dart' as _i2;

import '../../features/health/presentation/pages/healthy.videos.details.dart'
    as _i6;
import '../../features/home/domain/entities/featured.videos.dart' as _i9;
import '../../features/home/presentation/pages/home.dart' as _i4;
import '../../features/home/presentation/pages/metric.reader.dart' as _i8;
import '../../features/home/presentation/pages/metric.result.dart' as _i7;
import '../../features/login/presentation/pages/login.dart' as _i5;
import '../../features/welcome/presentation/pages/welcome.dart' as _i3;
import '../util/calculators.dart' as _i10;

class AppRouter extends _i1.RootStackRouter {
  AppRouter([_i2.GlobalKey<_i2.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i1.PageFactory> pagesMap = {
    WelcomeRoute.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return _i3.WelcomePage();
        }),
    HomeRoute.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return _i4.HomePage();
        }),
    LoginRoute.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return _i5.LoginPage();
        }),
    HealthyVideoDetailsRoute.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (data) {
          final args = data.argsAs<HealthyVideoDetailsRouteArgs>();
          return _i6.HealthyVideoDetailsPage(
              key: args.key, featuredVideo: args.featuredVideo);
        }),
    MetricResultRoute.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (data) {
          final args = data.argsAs<MetricResultRouteArgs>();
          return _i7.MetricResultPage(key: args.key, gender: args.gender);
        }),
    MetricReaderRoute.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return _i8.MetricReaderPage();
        })
  };

  @override
  List<_i1.RouteConfig> get routes => [
        _i1.RouteConfig(WelcomeRoute.name, path: '/'),
        _i1.RouteConfig(HomeRoute.name, path: '/home-page'),
        _i1.RouteConfig(LoginRoute.name, path: '/login-page'),
        _i1.RouteConfig(HealthyVideoDetailsRoute.name,
            path: '/healthy-video-details-page'),
        _i1.RouteConfig(MetricResultRoute.name, path: '/metric-result-page'),
        _i1.RouteConfig(MetricReaderRoute.name, path: '/metric-reader-page')
      ];
}

class WelcomeRoute extends _i1.PageRouteInfo {
  const WelcomeRoute() : super(name, path: '/');

  static const String name = 'WelcomeRoute';
}

class HomeRoute extends _i1.PageRouteInfo {
  const HomeRoute() : super(name, path: '/home-page');

  static const String name = 'HomeRoute';
}

class LoginRoute extends _i1.PageRouteInfo {
  const LoginRoute() : super(name, path: '/login-page');

  static const String name = 'LoginRoute';
}

class HealthyVideoDetailsRoute
    extends _i1.PageRouteInfo<HealthyVideoDetailsRouteArgs> {
  HealthyVideoDetailsRoute(
      {_i2.Key? key, required _i9.BaseFeaturedVideo featuredVideo})
      : super(name,
            path: '/healthy-video-details-page',
            args: HealthyVideoDetailsRouteArgs(
                key: key, featuredVideo: featuredVideo));

  static const String name = 'HealthyVideoDetailsRoute';
}

class HealthyVideoDetailsRouteArgs {
  const HealthyVideoDetailsRouteArgs({this.key, required this.featuredVideo});

  final _i2.Key? key;

  final _i9.BaseFeaturedVideo featuredVideo;
}

class MetricResultRoute extends _i1.PageRouteInfo<MetricResultRouteArgs> {
  MetricResultRoute({_i2.Key? key, required _i10.Gender gender})
      : super(name,
            path: '/metric-result-page',
            args: MetricResultRouteArgs(key: key, gender: gender));

  static const String name = 'MetricResultRoute';
}

class MetricResultRouteArgs {
  const MetricResultRouteArgs({this.key, required this.gender});

  final _i2.Key? key;

  final _i10.Gender gender;
}

class MetricReaderRoute extends _i1.PageRouteInfo {
  const MetricReaderRoute() : super(name, path: '/metric-reader-page');

  static const String name = 'MetricReaderRoute';
}
