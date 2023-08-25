// ./index.js
const express = require('express')

const app = express()

app.get('/', (_req, res) => {
 res.send(`
  This "Hello world!" is powered by Terraform AWS Modules!
  The ISO datetime right now is ${new Date().toISOString()}.
 `)
})

app.listen(process.env.PORT, () => {
 console.log(`Listening on port ${process.env.PORT}`)
})