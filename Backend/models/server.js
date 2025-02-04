const express = require('express')

class Server {
  constructor () {
    this.app = express()
    this.port = process.env.PORT || 3000
    this.middleware()
    this.rutas()
  }

  middleware () {
    this.app.use(express.static('public'))
  }

  rutas () {
    this.app.use('/', require('../Routes/apiRoutes'))
    this.app.use('/api/artistas', require('../Routes/artistas'))
    this.app.use('/api', require('../Routes/variosRoutes')) // ejemplo http://localhost:3000/api/generos
  }

  listen () {
    this.app.listen(this.port, () => {
      console.log(`Servidor corriendo en el puerto ${this.port}`)
    })
  }
}

module.exports = Server
