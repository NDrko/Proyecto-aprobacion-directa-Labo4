import 'package:final_labo4/screens/playlist_screen.dart';
import 'package:final_labo4/styles/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'screens/home_screen.dart';
import 'screens/new_releases_screen.dart';
import 'screens/search_screen.dart';
import 'screens/settings_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Spotify Clone',
      theme: themeProvider.currentTheme,
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/releases': (context) => NewReleasesScreen(),
        '/settings': (context) => SettingsScreen(),
        '/playlists': (context) => PlaylistScreen(),
        '/search': (context) => SearchScreen()
      },
    );
  }
}
