var express = require('express');
var app = express();
var http = require('http').Server(app);
var io = require('socket.io')(http);
var fs = require('fs');
var path = require('path');
var spawn = require('child_process').spawn;
var proc;
app.use('/', express.static(path.join(__dirname, 'data')));
app.get('/', function(req, res) {
res.sendFile(__dirname + '/index.html');
});
var sockets = {};
io.on('connection', function(socket) {
sockets[socket.id] = socket;
console.log("Total clients connected : ", Object.keys(sockets).length);
socket.on('disconnect', function() {
delete sockets[socket.id];
// no more sockets, kill the stream
if (Object.keys(sockets).length == 0) {
app.set('watchingFile', false);
if (proc) proc.kill();
fs.unwatchFile('./data/data.txt');
}
});
socket.on('start-stream', function() {
startStreaming(io);
});
});
http.listen(8080, function() {
console.log('listening on *:8080');
});
function stopStreaming() {
if (Object.keys(sockets).length == 0) {
app.set('watchingFile', false);
if (proc) proc.kill();
fs.unwatchFile('./data/data.txt');
}
}
function startStreaming(io) {
if (app.get('watchingFile')) {
io.sockets.emit('liveData', 'start');
return;
}
var args = ["dht.py"];
proc = spawn('python', args);
console.log('Watching for changes...');
app.set('watchingFile', true);
fs.watchFile('./data/data.txt', function(current, previous) {
  fs.readFile('./data/data.txt', {encoding: 'utf-8'}, function(err,data){
    if (!err) {
      io.sockets.emit('liveData', data);
    }
  })
})
}

