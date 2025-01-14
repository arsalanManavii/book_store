import 'package:book_store_application/helper/shared_preferences.dart';
import 'package:book_store_application/state_managment/book_provider.dart';
import 'package:book_store_application/ui/screens/home_screen.dart';
import 'package:book_store_application/state_managment/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Preferences.initFunction();
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: const Application(),
    ),
  );
  // DatabaseHelper.instance.database;
}

class Application extends StatelessWidget {
  const Application({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp(
          themeMode: themeProvider.themeMode,
          theme: MyThemes.lightTheme,
          darkTheme: MyThemes.darkTheme,
          home: ChangeNotifierProvider(
            create: (context) => BookProvider(),
            child: const HomeScreen(),
          ),
        );
      },
    );
  }
}
