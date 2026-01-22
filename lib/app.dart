import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'config/theme.dart';
import 'providers/theme_provider.dart';
import 'config/constants.dart';
import 'screens/home_screen.dart';

/// Main App Widget
/// Root application with theme and routing
class MyBrandingApp extends StatelessWidget {
  const MyBrandingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp(
          // App metadata
          title: AppConstants.metaTitle,

          // Debug banner
          debugShowCheckedModeBanner: false,

          // Theme
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: themeProvider.themeMode,

          // Home screen
          home: const HomeScreen(),

          // Scroll behavior for web
          scrollBehavior: const MaterialScrollBehavior().copyWith(
            scrollbars: true,
          ),
        );
      },
    );
  }
}
