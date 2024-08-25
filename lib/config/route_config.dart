import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tecnical_test/main.dart';
import 'package:tecnical_test/screen/details_screen.dart';
import 'package:tecnical_test/screen/general_screen.dart';

class RouteConfig {
  static RouterConfig<Object> router = GoRouter(
    initialLocation: GeneralScreen.ROUTE_PATH,
    navigatorKey: navigatorKey,
    routes: [
      GoRoute(
        name: GeneralScreen.ROUTE_NAME,
        path: GeneralScreen.ROUTE_PATH,
        builder: GeneralScreen.ROUTE_BUILDER,
      ),
      GoRoute(
        name: DetailsScreen.ROUTE_NAME,
        path: DetailsScreen.ROUTE_PATH,
        builder: DetailsScreen.ROUTE_BUILDER,
      ),
    ],
  );
}
