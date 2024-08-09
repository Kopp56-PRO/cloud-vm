const http = require('http');
const fs = require('fs');
const path = require('path');
const url = require('url');

// Define the port and directory to serve
const port = 8080;
const directoryToServe = 'C:\\';

const server = http.createServer((req, res) => {
  const parsedUrl = url.parse(req.url);
  let pathname = path.join(directoryToServe, parsedUrl.pathname);

  fs.stat(pathname, (err, stats) => {
    if (err || !stats.isFile()) {
      res.statusCode = 404;
      res.end('404 Not Found');
      return;
    }

    res.statusCode = 200;
    res.setHeader('Content-Type', 'text/html');
    fs.createReadStream(pathname).pipe(res);
  });
});

server.listen(port, () => {
  console.log(`Server running at http://localhost:${port}`);
});
