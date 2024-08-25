import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tecnical_test/api/api_response.dart';
import 'package:tecnical_test/main.dart';

class DetailsScreen extends StatelessWidget {
  //#region navigation-config
  static const String ROUTE_NAME = 'details';
  static const String ROUTE_PATH = '/$ROUTE_NAME';

  static Widget ROUTE_BUILDER(
    BuildContext context,
    GoRouterState state,
  ) {
    return DetailsScreen(
      user: state.extra as UserResponse,
    );
  }

  static void push(UserResponse user) {
    Global.context.pushNamed(
      DetailsScreen.ROUTE_NAME,
      extra: user,
    );
  }

  //#endregion navigation-config
  final UserResponse user;

  const DetailsScreen({
    required this.user,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Details")),
      body: Center(
        child: Text(user.name.first),
      ),
    );
  }
}
