import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'app.dart';
import 'providers/theme_provider.dart';
import 'providers/stats_provider.dart';

/// Main Entry Point
/// Initializes and runs the Personal Branding App
void main() {
  // Ensure Flutter is initialized
  WidgetsFlutterBinding.ensureInitialized();

  // Run the app
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => StatsProvider()),
      ],
      child: const MyBrandingApp(),
    ),
  );
}
