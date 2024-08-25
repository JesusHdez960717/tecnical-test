import 'package:flutter/material.dart';
import 'package:tecnical_test/api/api_test.dart';

import 'api/api_response.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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
        title: Text(widget.title),
      ),
      body: Center(
        child: ListView(
          children: list
              .map(
                (e) => ListTile(
                  leading: Image.network(e.picture.thumbnail),
                  title: Text('${e.name.title} ${e.name.first} ${e.name.last}'),
                  subtitle: Text(e.email),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
