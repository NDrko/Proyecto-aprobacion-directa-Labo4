const axios = require('axios');
const qs = require('qs');
const SpotifyWebApi = require('spotify-web-api-node');
const express = require('express');
require('dotenv').config();

const app = express();

// ** Variables para almacenar el token de acceso y su tiempo de expiración
let accessToken = null;
let tokenExpirationTime = null;

// ** Instancia de SpotifyWebApi **
const spotifyApi = new SpotifyWebApi({
  clientId: process.env.CLIENT_ID,
  clientSecret: process.env.CLIENT_SECRET,
  redirectUri: 'https://localhost:8888/callback',
});

// ** Scopes para autorización de usuario **
const scopes = [
  'ugc-image-upload',
  'user-read-playback-state',
  'user-modify-playback-state',
  'user-read-currently-playing',
  'streaming',
  'app-remote-control',
  'user-read-email',
  'user-read-private',
  'playlist-read-collaborative',
  'playlist-modify-public',
  'playlist-read-private',
  'playlist-modify-private',
];

// ** Función para obtener un token de cliente genérico **
const getAccessToken = async () => {
  if (accessToken && tokenExpirationTime && Date.now() < tokenExpirationTime) {
    console.log('Using existing token');
    return accessToken; // Retorna el token actual si aún es válido
  }

  try {
    const response = await axios.post(
      'https://accounts.spotify.com/api/token',
      qs.stringify({ grant_type: 'client_credentials' }),
      {
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
          Authorization: `Basic ${Buffer.from(
            `${process.env.CLIENT_ID}:${process.env.CLIENT_SECRET}`
          ).toString('base64')}`,
        },
      }
    );

    accessToken = response.data.access_token;
    tokenExpirationTime = Date.now() + response.data.expires_in * 1000;

    console.log('New token obtained');
    //console.log('Token expiration time: ' + new Date(tokenExpirationTime).toLocaleString());

    return accessToken;
  } catch (error) {
    console.error('Error obtaining client access token:', error);
    throw error;
  }
};

// ** Rutas para manejo de autorización de usuario **
app.get('/login', (req, res) => {
  res.redirect(spotifyApi.createAuthorizeURL(scopes));
});

app.get('/callback', async (req, res) => {
  const error = req.query.error;
  const code = req.query.code;

  if (error) {
    console.error('Callback Error:', error);
    return res.send(`Callback Error: ${error}`);
  }

  try {
    const data = await spotifyApi.authorizationCodeGrant(code);
    const access_token = data.body['access_token'];
    const refresh_token = data.body['refresh_token'];
    const expires_in = data.body['expires_in'];

    spotifyApi.setAccessToken(access_token);
    spotifyApi.setRefreshToken(refresh_token);

    //console.log('User Access Token:', access_token);
    //console.log('Refresh Token:', refresh_token);
    console.log(`Successfully retrieved access token. Expires in ${expires_in} s.`);

    res.send('Authorization successful! You can now close this window.');

    // Renovar el token de usuario automáticamente
    setInterval(async () => {
      try {
        const refreshedData = await spotifyApi.refreshAccessToken();
        const refreshedToken = refreshedData.body['access_token'];

        //console.log('User Access Token refreshed:', refreshedToken);
        spotifyApi.setAccessToken(refreshedToken);
      } catch (error) {
        console.error('Error refreshing user access token:', error);
      }
    }, (expires_in / 2) * 1000);
  } catch (error) {
    console.error('Error retrieving access token:', error);
    res.send(`Error retrieving access token: ${error}`);
  }
});

module.exports = { getAccessToken };

// Iniciar servidor
app.listen(8888, () => {
  console.log('Server running on http://localhost:8888/login');
});
