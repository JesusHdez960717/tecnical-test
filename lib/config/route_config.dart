import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tecnical_test/main.dart';
import 'package:tecnical_test/screen/details_screen.dart';
import 'package:tecnical_test/screen/general_screen.dart';

class RouteConfig {
  static RouterConfig<Object> router = GoRouter(
    initialLocation: GeneralScreen.routePath,
    navigatorKey: navigatorKey,
    routes: [
      GoRoute(
        name: GeneralScreen.routeName,
        path: GeneralScreen.routePath,
        builder: GeneralScreen.routeBuilder,
      ),
      GoRoute(
        name: DetailsScreen.routeName,
        path: DetailsScreen.routePath,
        builder: DetailsScreen.routeBuilder,
      ),
    ],
  );
}
