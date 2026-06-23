# Upload Files Using Pre-signed URLs

Using pre-signed URLs, a client can upload files directly to an S3-compatible cloud storage server (S3) without exposing the S3 credentials to the user. 

This guide describes how to generate a pre-signed URL using the AWS SDK for JavaScript.
The example uses a small Node.js HTTP server to generate a pre-signed URL and a client-side web application to upload a file to Buckit Server using that URL.

The browser upload does not require Node.js or Express.
The server-side signing step does require a trusted backend because it uses Buckit credentials.
That backend can be implemented in any language. This page uses plain Node.js to keep the example minimal.

- [Upload Files Using Pre-signed URLs ](#upload-files-using-pre-signed-urls-)
  - [1. Create the Server](#1-create-the-server)
  - [2. Create the Client-side Web Application](#2-create-the-client-side-web-application)

## <a name="createserver"></a>1. Create the Server
The server exposes an endpoint called `/presigned-url`. This endpoint uses the AWS SDK for JavaScript to generate a short-lived, pre-signed URL that can be used to upload a file to Buckit Server.

```js
const http = require('node:http')
const { URL } = require('node:url')
const { readFile } = require('node:fs/promises')
const { S3Client, PutObjectCommand } = require('@aws-sdk/client-s3')
const { getSignedUrl } = require('@aws-sdk/s3-request-presigner')

const client = new S3Client({
    // Required by the AWS SDK for SigV4 request signing.
    // If Buckit has a server region configured, this value must match it.
    // If no server region is configured, us-east-1 is a common default.
    region: 'us-east-1',
    endpoint: 'https://buckit.example.net',
    forcePathStyle: true,
    credentials: {
        accessKeyId: 'ACCESS_KEY',
        secretAccessKey: 'SECRET_KEY'
    }
})

const bucket = 'uploads'

const server = http.createServer(async (req, res) => {
    const requestUrl = new URL(req.url, 'http://127.0.0.1:8080')

    if (req.method === 'GET' && requestUrl.pathname === '/') {
        const html = await readFile(new URL('./index.html', `file://${__dirname}/`), 'utf8')
        res.writeHead(200, { 'content-type': 'text/html; charset=utf-8' })
        res.end(html)
        return
    }

    if (req.method === 'GET' && requestUrl.pathname === '/presigned-url') {
        const objectName = requestUrl.searchParams.get('name')

        if (!objectName) {
            res.writeHead(400, { 'content-type': 'text/plain; charset=utf-8' })
            res.end('Missing name query parameter')
            return
        }

        try {
            const command = new PutObjectCommand({
                Bucket: bucket,
                Key: objectName
            })
            const signedUrl = await getSignedUrl(client, command, { expiresIn: 300 })

            res.writeHead(200, { 'content-type': 'text/plain; charset=utf-8' })
            res.end(signedUrl)
        } catch (err) {
            res.writeHead(500, { 'content-type': 'text/plain; charset=utf-8' })
            res.end(String(err))
        }
        return
    }

    res.writeHead(404, { 'content-type': 'text/plain; charset=utf-8' })
    res.end('Not found')
})

server.listen(8080, () => {
    console.log('Listening on http://127.0.0.1:8080')
})
```

## <a name="createclient"></a>2. Create the Client-side Web Application
The client-side web application's user interface contains a selector field that allows the user to select files for upload, as well as a button that invokes an `onclick` handler called `upload`:

```html
<input type="file" id="selector" multiple>
<button onclick="upload()">Upload</button>

<div id="status">No uploads</div>

<script type="text/javascript">
    // `upload` iterates through all selected files and requests a new pre-signed URL for each one.
    function upload() {
        // Get selected files from the input element.
        var files = document.querySelector("#selector").files;
        for (var i = 0; i < files.length; i++) {
            var file = files[i];
            // Retrieve a URL from our server.
            retrieveNewUrl(file, (file, url) => {
                // Upload the file to the server.
                uploadFile(file, url);
            });
        }
    }

    // `retrieveNewUrl` accepts the current filename and requests a pre-signed PUT URL from the backend.
    function retrieveNewUrl(file, cb) {
        fetch(`/presigned-url?name=${encodeURIComponent(file.name)}`).then((response) => {
            response.text().then((url) => {
                cb(file, url);
            });
        }).catch((e) => {
            console.error(e);
        });
    }

    // ``uploadFile` accepts the current filename and the pre-signed URL. It then uses `Fetch API`
    // to upload this file directly to Buckit using the URL:
    function uploadFile(file, url) {
        if (document.querySelector('#status').innerText === 'No uploads') {
            document.querySelector('#status').innerHTML = '';
        }
        fetch(url, {
            method: 'PUT',
            body: file
        }).then(() => {
            // If multiple files are uploaded, append upload status on the next line.
            document.querySelector('#status').innerHTML += `<br>Uploaded ${file.name}.`;
        }).catch((e) => {
            console.error(e);
        });
    }
</script>
```

**Note:** This uses the [File API](https://developer.mozilla.org/en-US/docs/Web/API/File), [QuerySelector API](https://developer.mozilla.org/en-US/docs/Web/API/Document/querySelector), [fetch API](https://developer.mozilla.org/en-US/docs/Web/API/Fetch_API) & [Promise API](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Promise).
