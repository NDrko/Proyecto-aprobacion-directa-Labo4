const { getAccessToken } = require('../auth');
const axios = require('axios');
const fs = require('fs');
const path = require('path');


// Controlador para obtener nuevos lanzamientos
const getNewReleases = async (req, res) => {
  try {
    const token = await getAccessToken();
    const response = await axios.get('https://api.spotify.com/v1/browse/new-releases?limit=50', {
      headers: {
        Authorization: `Bearer ${token}`,
      },
    });
    res.status(200).json({ status: 'ok', data: response.data.albums.items });
  } catch (error) {
    console.error('Error al obtener nuevos lanzamientos:', error.message);
    res.status(500).json({ status: 'error', msg: 'Error al obtener nuevos lanzamientos' });
  }
};


// Endpoint para obtener las playlists
const getPlaylistsFromFile = (req, res) => {
  try {
    const directoryPath = path.join('Playlists');
    const files = fs.readdirSync(directoryPath);

    const playlists = files
      .filter(file => file.endsWith('.json'))
      .map(file => {
        // Lee cada archivo y lo parsea como JSON
        const filePath = path.join(directoryPath, file);
        const playlistData = JSON.parse(fs.readFileSync(filePath, 'utf8'));

        return {
          name: file.replace('.json', ''), // Remueve la extensión .json para mostrar solo el nombre
          data: playlistData
        };
      });

    // Responde con el contenido de todas las playlists
    res.status(200).json({ status: 'ok', data: playlists });
  } catch (error) {
    console.error('Error al leer los archivos de playlists:', error.message);
    res.status(500).json({ status: 'error', msg: 'Error al obtener las playlists' });
  }
};





// Endpoint para obtener los tracks de una playlist
const getPlaylistTracks = async (req, res) => {
  const { playlistId } = req.params;

  if (!playlistId) {
    return res.status(400).json({ status: 'error', msg: 'El ID de la playlist es requerido' });
  }

  try {
    const token = await getAccessToken();
    const response = await axios.get(`https://api.spotify.com/v1/playlists/${playlistId}/tracks`, {
      headers: {
        Authorization: `Bearer ${token}`,
      },
      params: {
        limit: 50,
        offset: 0,
      },
    });
    res.status(200).json({ status: 'ok', data: response.data.items });
  } catch (error) {
    console.error(`Error al obtener los tracks de la playlist ${playlistId}:`, error.message);
    res.status(500).json({ status: 'error', msg: 'Error al obtener los tracks de la playlist' });
  }
};

// Endpoint para buscar álbumes por artista
const searchAlbums = async (req, res) => {
  const { artist } = req.query;

  if (!artist) {
    return res.status(400).json({ status: 'error', msg: 'Debes proporcionar un artista' });
  }

  try {
    const token = await getAccessToken();
    const response = await axios.get('https://api.spotify.com/v1/search', {
      headers: {
        Authorization: `Bearer ${token}`,
      },
      params: {
        q: artist,
        type: 'album',
        limit: 50,
      },
    });
    const albums = response.data.albums.items;
    if (albums.length > 0) {
      res.status(200).json({ status: 'ok', data: albums });
    } else {
      res.status(404).json({ status: 'error', msg: 'No se encontraron álbumes para este artista' });
    }
  } catch (error) {
    console.error('Error al buscar álbumes:', error.message);
    res.status(500).json({ status: 'error', msg: 'Error al buscar álbumes' });
  }
};

module.exports = { getNewReleases, getPlaylistsFromFile, getPlaylistTracks, searchAlbums };
