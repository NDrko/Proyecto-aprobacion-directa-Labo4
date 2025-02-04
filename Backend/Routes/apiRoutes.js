const express = require('express');
const {
  getNewReleases,
  getPlaylistsFromFile,
  searchAlbums,
  getPlaylistTracks
} = require('../controllers/spotifyControllers');

const router = express.Router();

// Endpoint para obtener nuevos lanzamientos
router.get('/releases', getNewReleases);

// Endpoint para obtener todas las playlists del usuario
router.get('/playlists', getPlaylistsFromFile);

// Endpoint para buscar álbumes por artista
router.get('/search', searchAlbums);

// Endpoint para obtener los tracks de una playlist específica
router.get('/playlists/:playlistId/tracks', getPlaylistTracks);

module.exports = router;
