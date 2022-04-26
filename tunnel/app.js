const express = require('express');
const app = express()
const { createProxyMiddleware } = require('http-proxy-middleware');
const exampleProxy = createProxyMiddleware({
  target: 'http://localhost:8080',
  changeOrigin: true,
  ws: true, 
});
app.use('/', exampleProxy);

module.exports = app;
