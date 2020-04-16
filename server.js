'use strict';

const express = require('express');
const util = require("util");
const exec = util.promisify(require("child_process").exec);

// Constants
const PORT = 8080;
const HOST = '0.0.0.0';

// App
const app = express();
app.get('/verify', async (req, res) => {
    if (!req.query.url) return res.send("provide a url param");
    console.log(req.query.url);
    await exec(`curl ${req.query.url} -o file.asice`);
    const result = await exec('/usr/local/bin/digidoc-tool open file.asice')
    await exec(`rm file.asice`);
    res.send(`<html><body><pre><code>${result.stdout}</code></pre></body></html>`);
});

app.listen(PORT, HOST);
console.log(`Running on http://${HOST}:${PORT}`);