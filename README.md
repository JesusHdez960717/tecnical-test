# tecnical_test

## Locale
Se implementó por defecto las traducciones a Inglés (en) y Español (es)

Para cambiar el locale modificar:
```dart
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: intl.technicalTest,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      locale: const Locale('es'), //const Locale('en'), =====>>>>> modificar aqui y cambiar
      routerConfig: RouteConfig.router,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
    );
  }
}
```

Por una cuestión de tiempo y de trabajo 