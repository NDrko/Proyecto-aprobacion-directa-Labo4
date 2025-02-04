import 'package:flutter/material.dart';
class PlaylistTracksScreen extends StatelessWidget {
  final String playlistName;
  final List<dynamic> tracks;

  const PlaylistTracksScreen({
    Key? key,
    required this.playlistName,
    required this.tracks,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(playlistName),
      ),
      body: tracks.isEmpty
          ? const Center(
        child: Text(
          "No se encontraron tracks en esta playlist",
          style: TextStyle(fontSize: 16),
        ),
      )
          : ListView.builder(
        itemCount: tracks.length,
        itemBuilder: (context, index) {
          final track = tracks[index];

          // Validación de datos del track
          final trackName = track['name'] ?? 'Sin nombre';
          final artistName = (track['artists'] != null &&
              (track['artists'] as List).isNotEmpty)
              ? track['artists'][0]['name']
              : 'Artista desconocido';
          final previewUrl = track['preview_url'];
          final albumImages = track['album'] != null &&
              track['album']['images'] != null &&
              (track['album']['images'] as List).isNotEmpty
              ? track['album']['images'][0]['url']
              : 'https://via.placeholder.com/300'; // Imagen de respaldo

          return ListTile(
            leading: Image.network(
              albumImages,
              width: 50,
              height: 50,
              fit: BoxFit.cover,
            ),
            title: Text(trackName),
            subtitle: Text(artistName),
          );
        },
      ),
    );
  }
}