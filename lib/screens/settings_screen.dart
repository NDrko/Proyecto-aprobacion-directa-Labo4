import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../styles/theme.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Configuración'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        children: [
          ListTile(
            leading: const Icon(Icons.dark_mode, color: Colors.green),
            title: const Text(
              'Modo oscuro',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            subtitle: Text(
              themeProvider.isDarkMode ? 'Activado' : 'Desactivado',
              style: const TextStyle(fontSize: 14),
            ),
            trailing: Switch(
              value: themeProvider.isDarkMode,
              onChanged: (value) {
                themeProvider.toggleTheme();
              },
              activeColor: Colors.green,
            ),
          ),
          Divider(),
          // Otras configuraciones (pueden ser agregadas más adelante)
          ListTile(
            leading: const Icon(Icons.notifications, color: Colors.green),
            title: const Text(
              'Notificaciones',
            ),
          ),
           Divider(),
          ListTile(
            leading: const Icon(Icons.language, color: Colors.green),
            title: const Text(
              'Idioma',
            ),
          ),
        ],
      ),
    );
  }
}
