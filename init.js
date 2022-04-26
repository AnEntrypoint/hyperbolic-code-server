const fs = require('fs');
const b32 = require('hi-base32');
const crypto = require("hypercore-crypto");

const readline = require('readline');
const rl = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});

rl.question('Enter a password: ', function (password) {
  const keyPair = crypto.keyPair(crypto.data(Buffer.from(password)));

  console.log('address will be: ', b32.encode(keyPair.publicKey).replace('====','').toLowerCase()+".matic.ml");
  fs.mkdirSync('tunnel/greenlock.d/', { recursive: true }, (err) => {console.log(err)});
  fs.writeFileSync('tunnel/greenlock.d/config.json', JSON.stringify({sites:{subject:b32.encode(keyPair.publicKey).replace('====','').toLowerCase()+".matic.ml"}}));
  fs.mkdirSync('~/.config/code-server/', { recursive: true }, (err) => {console.log(err)});
  fs.writeFileSync('~/.config/code-server/config.yaml', 'bind-addr: 127.0.0.1:8080\nauth: password\npassword: '+password+'\ncert: false');
  rl.close();
});

rl.on('close', function () {
  console.log('\nBYE BYE !!!');
  process.exit(0);
});
