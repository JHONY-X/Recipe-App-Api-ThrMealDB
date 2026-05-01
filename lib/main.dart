import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const RecipeApp());
}

class RecipeApp extends StatelessWidget {
  const RecipeApp({super.key});

  @override
  Widget build(BuildContext context) {
    const luxuryMidnightBlue = Color(0xFF1A1C2C);
    const luxuryGold = Color(0xFFD4AF37);
    const luxuryOffWhite = Color(0xFFF8F9FA);

    return MaterialApp(
      title: 'www.GLOBAL-MENU.COM',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: luxuryMidnightBlue,
          primary: luxuryMidnightBlue,
          secondary: luxuryGold,
          surface: luxuryOffWhite,
          brightness: Brightness.light,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: luxuryMidnightBlue,
          foregroundColor: luxuryGold,
          elevation: 0,
          centerTitle: true,
          titleTextStyle: TextStyle(
            color: luxuryGold,
            fontSize: 22,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
          ),
        ),
        cardTheme: CardThemeData(
          elevation: 8,
          shadowColor: luxuryMidnightBlue.withValues(alpha: 0.2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: luxuryMidnightBlue,
            foregroundColor: luxuryGold,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            textStyle: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        chipTheme: ChipThemeData(
          backgroundColor: luxuryMidnightBlue.withValues(alpha: 0.05),
          labelStyle: const TextStyle(color: luxuryMidnightBlue, fontWeight: FontWeight.bold),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: const BorderSide(color: luxuryMidnightBlue, width: 0.5),
          ),
        ),
        scaffoldBackgroundColor: luxuryOffWhite,
      ),
      home: const HomeScreen(),
    );
  }
}
