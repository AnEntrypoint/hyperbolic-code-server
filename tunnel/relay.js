const DHT = require("@hyperswarm/dht");
const crypto = require("hypercore-crypto");
var net = require("net");
var pump = require("pump");
const node = new DHT({});

module.exports = () => {
  return {
    serve: (key, port, secureport, addr) => {
      const keyPair = crypto.keyPair(crypto.data(Buffer.from(key)));
      const server = node.createServer();
      server.on("connection", function(servsock) {
        console.log('connection');
        servsock.once("data", function(data) {
          if(data == 'http') {
            socket = net.connect(port, addr);
          }
          if(data == 'https') {
            socket = net.connect(secureport, addr);
          }
          pump(servsock, socket, servsock);
        });

      });
      server.listen(keyPair);
      return keyPair.publicKey;
    }
  };
};
