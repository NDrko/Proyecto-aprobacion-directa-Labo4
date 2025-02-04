import 'package:flutter/material.dart';

class PlaylistCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String subtitle;

  const PlaylistCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: Image.network(
          imageUrl,
          width: 50,
          height: 50,
          fit: BoxFit.cover,
        ),
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: const TextStyle(
          fontSize: 14,
          color: Colors.white70,
        ),
      ),
      onTap: () {
        // Acción al tocar el playlist o canción
        Navigator.pushNamed(context, "/playlist-details");
      },
    );
  }
}
