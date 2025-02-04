import 'package:final_labo4/screens/playlists_tracks_screen.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../services/spotify_service.dart';
import '../widgets/drawer_menu.dart';

class PlaylistScreen extends StatelessWidget {
  final SpotifyService spotifyService = SpotifyService();

  PlaylistScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerMenu(),
      appBar: AppBar(
        title: const Text('Mis Playlists'),
      ),
      body: FutureBuilder(
        future: spotifyService.getPlaylistsFromFile(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Text("Error al cargar las playlists: ${snapshot.error}"),
            );
          } else if (!snapshot.hasData || (snapshot.data as List).isEmpty) {
            return const Center(
              child: Text("No se encontraron playlists"),
            );
          }

          final playlists = snapshot.data as List<dynamic>;

          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CarouselSlider.builder(
                  itemCount: playlists.length,
                  options: CarouselOptions(
                    height: MediaQuery.of(context).size.height * 0.4,
                    enlargeCenterPage: true,
                    autoPlay: true,
                    autoPlayInterval: const Duration(seconds: 3),
                    enableInfiniteScroll: true,
                  ),
                  itemBuilder: (context, index, realIndex) {
                    final playlist = playlists[index];

                    // Validaciones y asignaciones
                    final playlistName = playlist['name'] ?? 'Sin nombre';
                    final playlistData = playlist['data'] ?? {};
                    final tracks = playlistData['tracks'] ?? [];
                    final firstTrackAlbum = tracks.isNotEmpty ? tracks[0]['album'] : null;
                    final playlistImageUrl = firstTrackAlbum != null &&
                        firstTrackAlbum['images'] != null &&
                        firstTrackAlbum['images'].isNotEmpty
                        ? firstTrackAlbum['images'][0]['url']
                        : 'https://via.placeholder.com/300';

                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PlaylistTracksScreen(
                              playlistName: playlistName,
                              tracks: tracks,
                            ),
                          ),
                        );
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 3),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          image: DecorationImage(
                            image: NetworkImage(playlistImageUrl),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.vertical(
                                bottom: Radius.circular(20),
                              ),
                            ),
                            child: Text(
                              playlistName,
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).brightness == Brightness.dark
                                    ? Colors.white
                                    : Colors.black,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
