'use strict';

const express = require('express');
const util = require("util");
const exec = util.promisify(require("child_process").exec);

const cors = require('cors')


// Constants
const PORT = 8080;
const HOST = '0.0.0.0';

const formatResponse = (output) => `<html><body><pre><code>${output}</code></pre></body></html>`;

// App
const app = express();
app.use(cors({credentials: true, origin: true}))
app.get('/verify', async (req, res) => {
    if (!req.query.url) return res.send("provide a url param");
    console.log(req.query.url);
    await exec(`curl ${req.query.url} -o file.asice`);
    try {
        const result = await exec('/usr/local/bin/digidoc-tool open file.asice')
        res.send(formatResponse(result.stdout));
    } catch(e) {
        res.send(formatResponse(e.message));
    }
    await exec(`rm file.asice`);
});

app.listen(PORT, HOST);
console.log(`Running on http://${HOST}:${PORT}`);