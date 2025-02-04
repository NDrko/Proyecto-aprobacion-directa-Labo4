import 'package:flutter/material.dart';
import '../services/spotify_service.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  final SpotifyService spotifyService = SpotifyService();

  bool _isLoading = false;
  List<Map<String, dynamic>> _searchResults = [];

  // Función de búsqueda en playlists
  void _search(String query) async {
    if (query.isEmpty) return;

    setState(() {
      _isLoading = true;
      _searchResults.clear();
    });

    // Buscar canciones del artista en playlists locales
    final results = await spotifyService.searchTracksByArtist(query);

    setState(() {
      _isLoading = false;
      _searchResults = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Buscar Artista")),
      body: Column(
        children: [
          // Barra de búsqueda
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: "Buscar artista...",
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () => _search(_searchController.text),
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          // Resultados de búsqueda
          _isLoading
              ? const Center(child: CircularProgressIndicator())
              : Expanded(
            child: _searchResults.isEmpty
                ? const Center(child: Text("No se encontraron resultados"))
                : ListView.builder(
              itemCount: _searchResults.length,
              itemBuilder: (context, index) {
                final track = _searchResults[index];
                return ListTile(
                  leading: Image.network(
                    track['image'] ?? 'https://via.placeholder.com/50',
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  ),
                  title: Text(track['name']),
                  subtitle: Text(track['artist'])
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
