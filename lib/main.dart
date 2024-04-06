import 'package:flutter/material.dart';
import 'package:sae_allo_mobile/MyApp.dart';
import 'package:supabase_flutter/supabase_flutter.dart';


Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://warongqkhuzbkqopcpqp.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Indhcm9uZ3FraHV6Ymtxb3BjcHFwIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTIwOTk3ODksImV4cCI6MjAyNzY3NTc4OX0.RUzWNuiPENHMZtYzj9-dypIB5_5Q4n46vTi1_ZjCrv8',
  );


  runApp(MyApp());
}
