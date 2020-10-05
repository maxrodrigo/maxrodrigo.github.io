---
title: Python HTTPS Simple Server
last_modified_at: 2020-10-02 12:02:27+0200
---

Many times Netcat[^netcat] is enough for a single-use transfer,
but when sharing multiple files or even a website,
Python offers a simple yet powerful solution.

Python's [HTTPServer](https://docs.python.org/3/library/http.server.html),
or [SimpleHTTPServer](https://docs.python.org/2/library/simplehttpserver.html) in Python 2,
serves as a quick and easy way to start a local HTTP server on your network.

---
**NOTES**

`http.server` is not recommended for production.
It only implements basic security checks.

Python 2 is [deprecated](https://pythonclock.org/) and should be avoided if possible.
Yet [Python 2 Examples](#python-2) are still available.

---

## HTTP Web Server

The module can be easily invoked,
from the directory we want to share,
using the `-m` switch of the interpreter.

```sh
python3 -m http.server 8000
```

Or within a script, for additional configuration.

```python
#!/usr/bin/env python
# -*- coding: utf-8 -*-

import http.server
import socketserver

PORT = 8000

Handler = http.server.SimpleHTTPRequestHandler

with socketserver.TCPServer(("", PORT), Handler) as httpd:
  print("serving at port", PORT)
  httpd.serve_forever()
```

## HTTP Web Server with SSL Support

### Self-signed certificates

If you are going to create a server that provides SSL-encrypted connection services,
you will need a certificate.
Besides buying a certificate from a certification authority,
another common practice is to generate a self-signed certificate.
The simplest way to do this is with the [OpenSSL](https://www.openssl.org/docs/) tool, using something like the following:

```sh
openssl req -new -x509 -days 365 -nodes -out cert.pem -keyout cert.pem
```

### HTTPS Server

```python
#!/usr/bin/env python
# -*- coding: utf-8 -*-

from http.server import HTTPServer
from http.server import SimpleHTTPRequestHandler
import ssl

server_address = ("localhost", 4443)
httpd = HTTPServer(server_address, SimpleHTTPRequestHandler)
httpd.socket = ssl.wrap_socket(httpd.socket,
                               server_side=True,
                               certfile="cert.pem")
httpd.serve_forever()
```

---

## Python 2

### Command line invocation

```sh
python -m SimpleHTTPServer 8000
```

### HTTP Server

```python
#!/usr/bin/env python
# -*- coding: utf-8 -*-

import SimpleHTTPServer
import SocketServer

PORT = 8000

Handler = SimpleHTTPServer.SimpleHTTPRequestHandler

httpd = SocketServer.TCPServer(("", PORT), Handler)

print "serving at port", PORT
httpd.serve_forever()
```

### HTTPS Server

```python
#!/usr/bin/env python
# -*- coding: utf-8 -*-

import BaseHTTPServer
import SimpleHTTPServer
import ssl

httpd = BaseHTTPServer.HTTPServer(("localhost", 4443),
                                  SimpleHTTPServer.SimpleHTTPRequestHandler)
httpd.socket = ssl.wrap_socket(httpd.socket,
                               server_side=True,
                               certfile="cert.pem")
httpd.serve_forever()
```


[^netcat]:
    Netcat file transfer:

    `nc -nlvp 9000 > file`

    `nc <listener ip> 9000 < file`
