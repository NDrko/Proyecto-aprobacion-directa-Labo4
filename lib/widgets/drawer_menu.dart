import 'package:flutter/material.dart';

class DrawerMenu extends StatelessWidget {
  final List<Map<String, dynamic>> _menuItems = <Map<String, dynamic>>[
    {'route': '/', 'title': 'Inicio', 'icon': Icons.home},
    {'route': '/search', 'title': 'Buscar', 'icon': Icons.search},
    {'route': '/playlists', 'title': 'Tu Biblioteca', 'icon': Icons.library_music},
    {'route': '/settings', 'title': 'Configuración', 'icon': Icons.settings},
    {'route': '/releases','title': 'nuevos lanzamientos', 'icon': Icons.new_releases_outlined}
  ];

  DrawerMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const _DrawerHeaderAlternative(),
          ..._menuItems.map((item) => ListTile(
            leading: Icon(item['icon']),
            title: Text(
              item['title'],
              style: const TextStyle(fontSize: 16),
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, item['route']);
            },
          )),
        ],
      ),
    );
  }
}

class _DrawerHeaderAlternative extends StatelessWidget {
  const _DrawerHeaderAlternative();

  @override
  Widget build(BuildContext context) {
    return DrawerHeader(
      decoration: BoxDecoration(
        color: Colors.green[900], // Color principal
      ),
      child: Center(
        child: const Text(
          "Spotify Clone",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
