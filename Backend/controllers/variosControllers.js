const { getAccessToken } = require('../auth')
const axios = require('axios')

// endpoint obtener generos musicales
const getGenerosMusicales = async (req, res) => {
  try {
    // obtiene token
    const token = await getAccessToken()

    // solicitud a api spotify
    const response = await axios.get('https://api.spotify.com/v1/recommendations/available-genre-seeds', {
      headers: {
        Authorization: `Bearer ${token}`
      }
    })

    // si funciona, se consigen los generos (se limita a los primeros 50)
    const generos = response.data.genres.slice(0, 50)

    // se envia respuesta
    res.status(200).json({ status: 'ok', data: generos })
  } catch (error) {
    console.error('Error en getGenerosMusicales:', error.response ? error.response.data : error.message)
    res.status(500).json({ status: 'error', msg: 'Error al obtener genros musicales', error: error.message })
  }
}


// endpoint buscar podcasts
const getPodcastPorID = async (req, res) => {
  try {
    // Obtiene el ID del podcast desde los parámetros de la solicitud
    const podcastId = req.params.id

    // Obtiene el token de acceso
    const token = await getAccessToken()

    // Solicitud a la API de Spotify
    const response = await axios.get(`https://api.spotify.com/v1/shows/${podcastId}`, {
      headers: {
        Authorization: `Bearer ${token}`
      }
    })

    // Obtiene los datos del podcast
    const podcast = response.data

    // Envía la respuesta
    res.status(200).json({ status: 'ok', data: podcast })
  } catch (error) {
    console.error('Error en getPodcastById:', error.response ? error.response.data : error.message)
    res.status(500).json({ status: 'error', msg: 'Error al obtener el podcast', error: error.message })
  }
}

module.exports = {
  getGenerosMusicales, // hecho
  getPodcastPorID
}
