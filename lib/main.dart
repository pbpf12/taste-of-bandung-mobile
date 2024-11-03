import 'package:flutter/material.dart';
import 'app.dart';
import 'services/dependencies/di.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();
  runApp(const App());
}