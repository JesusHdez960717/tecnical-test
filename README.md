# tecnical_test

## Prueba Técnica
[Prueba Técnica.pdf](https://github.com/user-attachments/files/16742834/Prueba.Tecnica.pdf)

## Flutter version

El proyecto se desarrolló y probó utlizando la version `3.24.0` del sdk de flutter, configurada
mediante el `fvm`

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
      locale: const Locale('es'),
      //const Locale('en'), =====>>>>> modificar aqui y cambiar
      routerConfig: RouteConfig.router,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
    );
  }
}
```

## Screenshots:

### Lista de usuarios

![users](https://github.com/user-attachments/assets/705382b3-5ab3-43e0-b5c1-2c05c79bdd73)

### Detalles de usuarios

![detail](https://github.com/user-attachments/assets/c865d98f-c8ae-463f-9857-4969ee846015)

### Ejemplo completo

https://github.com/user-attachments/assets/9aa4d344-ca6e-4139-8ed2-47a711f9ea3d


