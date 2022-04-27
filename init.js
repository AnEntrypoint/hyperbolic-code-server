const fs = require('fs');
const b32 = require('hi-base32');
const crypto = require("hypercore-crypto");

const readline = require('readline');
const rl = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});

rl.question('Enter a unique identifier: ', function (password) {
  rl.question('Enter your contact email: ', function (email) {
    const keyPair = crypto.keyPair(crypto.data(Buffer.from(password)));
    const bkey = b32.encode(keyPair.publicKey).replace('====','').toLowerCase();
    console.log('Address will be: ', bkey+".matic.ml");
    fs.mkdirSync('tunnel/greenlock.d/', { recursive: true }, (err) => {console.log(err)});
    fs.writeFileSync('tunnel/.env', 'KEY='+password);
    fs.writeFileSync('tunnel/greenlock.d/config.json', JSON.stringify({sites:[{subject:bkey+".matic.ml"}]}));
    fs.mkdirSync('../.config/code-server/', { recursive: true }, (err) => {console.log(err)});
    fs.writeFileSync('../.config/code-server/config.yaml', 'bind-addr: 127.0.0.1:8080\nauth: password\npassword: '+keyPair.secretKey.toString('base64').replace('==','')+'\ncert: false');
    console.log('Password will be: '+keyPair.secretKey.toString('base64').replace('==',''));
    fs.writeFileSync('address', bkey+".matic.ml");
    rl.close();
  })
});

rl.on('close', function () {
  console.log('\nBYE BYE !!!');
  process.exit(0);
});
