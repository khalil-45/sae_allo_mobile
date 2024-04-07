import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'router.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Color.fromRGBO(0, 0, 0, 0),
    ));
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Sae Allo Mobile',
      theme: ThemeData(
        primarySwatch: Colors.brown,
      ),
      routerConfig: AppRouter().router,
    );
  }
}