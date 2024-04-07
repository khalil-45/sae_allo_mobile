import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://warongqkhuzbkqopcpqp.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Indhcm9uZ3FraHV6Ymtxb3BjcHFwIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTIwOTk3ODksImV4cCI6MjAyNzY3NTc4OX0.RUzWNuiPENHMZtYzj9-dypIB5_5Q4n46vTi1_ZjCrv8',
  );

  final router = AppRouter();
  runApp(Main(router.router));
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