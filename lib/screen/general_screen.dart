import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tecnical_test/api/api_response.dart';
import 'package:tecnical_test/api/api_test.dart';
import 'package:tecnical_test/main.dart';
import 'package:tecnical_test/screen/details_screen.dart';

class GeneralScreen extends StatefulWidget {
  //#region navigation-config
  static const String ROUTE_NAME = 'home';
  static const String ROUTE_PATH = '/$ROUTE_NAME';

  static Widget ROUTE_BUILDER(
    BuildContext context,
    GoRouterState state,
  ) =>
      const GeneralScreen();

  static void go() {
    Global.context.goNamed(GeneralScreen.ROUTE_NAME);
  }

  //#endregion navigation-config

  const GeneralScreen({super.key});

  @override
  State<GeneralScreen> createState() => _GeneralScreenState();
}

class _GeneralScreenState extends State<GeneralScreen> {
  ApiTest apiTest = ApiTest();
  List<UserResponse> list = [];

  @override
  void initState() {
    super.initState();

    fetchDataFromApi();
  }

  Future fetchDataFromApi() async {
    list = await apiTest.fetch(page: 0, size: 10);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("Basic app"),
      ),
      body: Center(
        child: ListView(
          children: list
              .map(
                (singleUser) => InkWell(
                  onTap: () => DetailsScreen.push(singleUser),
                  child: ListTile(
                    leading: Image.network(singleUser.picture.thumbnail),
                    title: Text(
                        '${singleUser.name.title} ${singleUser.name.first} ${singleUser.name.last}'),
                    subtitle: Text(singleUser.email),
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
