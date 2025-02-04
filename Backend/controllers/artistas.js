const { getAccessToken } = require('../auth')
const axios = require('axios')

const getArtistaPorNombre = async (req, res) => {
  const { q } = req.query
  try {
    const token = await getAccessToken()
    const response = await axios.get(`https://api.spotify.com/v1/search?q=${q}&type=artist`, {
      headers: {
        Authorization: `Bearer ${token}`
      }
    })
    const artista = response.data.artists.items[0] // Tomamos solo el primer artista

    if (artista) {
      const resultado = {
        nombre: artista.name,
        id: artista.id
      }
      res.status(200).json({ status: 'ok', data: resultado }) // response.data.artists.items
    }
  } catch (error) {
    res.status(500).json({ status: 'error', msg: 'Error inesperado al obtener la información' })
  }
}

const getArtistaPorId = async (req, res) => {
  const { id } = req.params
  try {
    const token = await getAccessToken()
    const response = await axios.get(`https://api.spotify.com/v1/artists/${id}`, {
      headers: {
        Authorization: `Bearer ${token}`
      }
    })
    res.status(200).json({ status: 'ok', data: response.data })
  } catch (error) {
    res.status(500).json({ status: 'error', msg: 'Error inesperado al obtener la información' })
  }
}

const getTodosLosAlbunesDelArtista = async (req, res) => {
  const { id } = req.params
  try {
    const token = await getAccessToken()
    const response = await axios.get(`https://api.spotify.com/v1/artists/${id}/albums`, {
      headers: {
        Authorization: `Bearer ${token}`
      }
    })
    res.status(200).json({ status: 'ok', data: response.data })
  } catch (error) {
    res.status(500).json({ status: 'error', msg: 'Error inesperado al obtener la información' })
  }
}

module.exports = {
  getArtistaPorNombre,
  getArtistaPorId,
  getTodosLosAlbunesDelArtista
}
