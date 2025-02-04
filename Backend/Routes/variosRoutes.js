const express = require('express')
const { getGenerosMusicales, getPodcastPorID } = require('../controllers/variosControllers')

const router = express.Router()

// ruta obtener generos musicales
router.get('/generos', getGenerosMusicales)
// ejemplo   http://localhost:3000/api/generos

// ruta obtener playlists de usuario
//router.get('/playlists/:id', getPlaylistPorID)
// ejemplo   http://localhost:3000/api/playlists/3Z9oPJuIN9kpQtxo2mSbUt

// ruta obtener podcasts
router.get('/podcasts/:id', getPodcastPorID)
// ejemplo:   http://localhost:3000/api/podcasts/3VIKVOSfbHk7vy83sgB7SE
    // ejemplo:   http://localhost:3000/api/podcasts/1KRwhKl60iMj3r9QH5fTnf

module.exports = router
