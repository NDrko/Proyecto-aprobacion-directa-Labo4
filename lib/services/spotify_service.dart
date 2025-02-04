import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/releases.dart';
import '../models/Playlist_Tracks.dart';

class SpotifyService {
  final String baseUrl;

  SpotifyService([String? baseUrl])
      : baseUrl = baseUrl ?? dotenv.env['API_BASE_URL']!;

  Future<dynamic> _makeRequest(String endpoint) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl$endpoint'));

      // Manejo de códigos de estado
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else if (response.statusCode == 404) {
        throw Exception('Recurso no encontrado (404)');
      } else if (response.statusCode == 500) {
        throw Exception('Error interno del servidor (500)');
      } else {
        throw Exception(
            'Error inesperado: ${response.statusCode} - ${response
                .reasonPhrase}');
      }
    } catch (e) {
      // Capturar errores de red o de decodificación
      throw Exception('Error de red o inesperado: $e');
    }
  }

  /// Obtener nuevos lanzamientos
  Future<Releases> getNewReleases() async {
    final data = await _makeRequest('/releases');
    if (data != null) {
      return Releases.fromJson(data);
    } else {
      throw Exception(
          'Respuesta vacía o inesperada al obtener nuevos lanzamientos');
    }
  }


  /// Obtener las playlists del usuario
  Future<List<dynamic>> getPlaylistsFromFile() async {
    final response = await http.get(Uri.parse('$baseUrl/playlists'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['data']; // Retorna la lista de playlists
    } else {
      throw Exception('Error al obtener playlists: ${response.reasonPhrase}');
    }
  }



  /// Obtener tracks de una playlist
  Future<PlaylistTracks> getPlaylistTracks(String playlistId) async {
    final response = await http.get(
        Uri.parse('$baseUrl/playlists/$playlistId/tracks'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return PlaylistTracks.fromJson(data);
    } else {
      throw Exception(
          'Error al obtener los tracks: ${response.statusCode} ${response
              .reasonPhrase}');
    }
  }

  /// Buscar canciones por artista Ej: Simple plan, Hans Zimmer
  Future<List<Map<String, dynamic>>> searchTracksByArtist(String artistName) async {
    final playlists = await getPlaylistsFromFile();
    List<Map<String, dynamic>> tracksFound = [];

    for (var playlist in playlists) {
      var tracks = playlist['data']['tracks'] ?? [];
      for (var track in tracks) {
        var trackArtist = track['artists'][0]['name'].toLowerCase();
        if (trackArtist.contains(artistName.toLowerCase())) {
          tracksFound.add({
            'name': track['name'],
            'artist': trackArtist,
            'image': track['album']['images'][0]['url']
          });
        }
      }
    }

    return tracksFound;
  }
}