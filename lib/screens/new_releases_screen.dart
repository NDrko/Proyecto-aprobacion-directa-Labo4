import 'package:flutter/material.dart';
import '../services/spotify_service.dart';
import '../models/releases.dart' as releases_model;
import '../widgets/drawer_menu.dart';

class NewReleasesScreen extends StatelessWidget {
  final SpotifyService spotifyService = SpotifyService();

  NewReleasesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerMenu(),
      appBar: AppBar(
        title: const Text('Nuevos Lanzamientos'),
      ),
      body: FutureBuilder<releases_model.Releases>(
        future: spotifyService.getNewReleases(), // Ahora devuelve un modelo `Releases`
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.data.isEmpty) {
            return const Center(
              child: Text(
                "No se encontraron lanzamientos",
                style: TextStyle(color: Colors.white),
              ),
            );
          }

          final newReleases = snapshot.data!.data; // Lista de álbumes (modelo `Datum`)

          return ListView.builder(
            itemCount: newReleases.length,
            itemBuilder: (context, index) {
              final album = newReleases[index];
              return ListTile(
                leading: Image.network(
                  album.images.isNotEmpty ? album.images[0].url : '',
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) =>
                  const Icon(Icons.broken_image),
                ),
                title: Text(
                  album.name,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  album.artists.isNotEmpty ? album.artists[0].name : 'Desconocido',
                ),
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    '/album-details',
                    arguments: album.id, // Pasamos el ID del álbum
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
