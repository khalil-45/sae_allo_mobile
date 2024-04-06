import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'router.dart';

void main() {
  final router = AppRouter().router;

  runApp(Main(router));
}

class Main extends StatelessWidget {
  final GoRouter router;
  const Main(this.router, {super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: router,
    );
  }
}