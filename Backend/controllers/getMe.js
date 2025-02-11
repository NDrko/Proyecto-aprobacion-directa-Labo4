const fs = require('fs')
const SpotifyWebApi = require('spotify-web-api-node');
const token = "XXXXX";
const spotifyApi = new SpotifyWebApi();
spotifyApi.setAccessToken(token);

//GET MY PROFILE DATA
function getMyData() {
  (async () => {
    const me = await spotifyApi.getMe();
    console.log(me.body);
    getUserPlaylists(me.body.id);
  })().catch(e => {
    console.error(e);
  });
}

 async function getUserPlaylists(userName) {
    const data = await spotifyApi.getUserPlaylists(userName)

    console.log("---------------+++++++++++++++++++++++++")
   let playlists = []

     for (let playlist of data.body.items) {
      console.log(playlist.name + " " + playlist.id)

      let tracks = await getPlaylistTracks(playlist.id, playlist.name);

       const tracksJSON = { tracks }
       let data = JSON.stringify(tracksJSON);
       fs.writeFileSync(playlist.name+'.json', data);
    }
   }

   //GET SONGS FROM PLAYLIST
   async function getPlaylistTracks(playlistId, playlistName) {

    const data = await spotifyApi.getPlaylistTracks(playlistId, {
      offset: 1,
      limit: 50,
       fields: 'items'
    })


     console.log("'" + playlistName + "'" + ' contains these tracks:');
     let tracks = [];

    for (let track_obj of data.body.items) {
      const track = track_obj.track
      tracks.push(track);
      console.log(track.name + " : " + track.artists[0].name)
     }

     console.log("---------------+++++++++++++++++++++++++")
     return tracks;
   }

  getMyData();
