const { Router } = require('express')
const { getArtistaPorNombre, getTodosLosAlbunesDelArtista, getArtistaPorId } = require('../controllers/artistas')

const rutas = Router()

rutas.get('/search', getArtistaPorNombre) // devuelve el id del artista ej: /search?q=eminem
rutas.get('/:id/albums', getTodosLosAlbunesDelArtista) // devuelve una lista de los albunes donde participo el artista ej: /artist/1HY2Jd0NmPuamShAr6KMms/albums
rutas.get('/:id', getArtistaPorId) // devuelve info del artista ej: /artist/1HY2Jd0NmPuamShAr6KMms  <-- ese id es de Lady Gaga

module.exports = rutas
