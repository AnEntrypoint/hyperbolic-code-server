"use strict";
var b32 = require("hi-base32");
console.log(process.argv.length)
if(process.argv.length == 3) {
  const key = process.argv[process.argv.length-1];
  const out = require('./relay.js')().serve(key, 2080, 2443, "127.0.0.1");
  console.log('listening', b32.encode(out).replace('====','').toLowerCase());
  console.log('hex', out);
} else console.log("usage: node server.js <key>");

var app = require("./app.js");
 
require("greenlock-express")
    .init({
      packageRoot: __dirname,
      configDir: "./greenlock.d",
      maintainerEmail: "jon@example.com",
      cluster: false
  })
    .ready(httpsWorker);

function httpsWorker(glx) {
    var httpsServer = glx.httpsServer(null, app);

    httpsServer.listen(2443, "0.0.0.0", function() {
        console.info("Listening on ", httpsServer.address());
    });

    var httpServer = glx.httpServer();

    httpServer.listen(2080, "0.0.0.0", function() {
        console.info("Listening on ", httpServer.address());
    });
}

