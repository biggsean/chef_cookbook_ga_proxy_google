default['haproxy']['frontends'] = {
  main: {
    ip: '*',
    port: 80,
    default_backend: 'google'
  }
}
default['haproxy']['backends'] = {
  google: {
    servers: [
      google1: {
        socket: 'www.google.com:80',
        options: ['check']
      }
    ],
    options: [
      'option  httpchk  HEAD / HTTP/1.1\r\nHost:\ www.google.com',
      'http-request set-header Host www.google.com',
      'http-request set-header User-Agent GoogleProxy'
    ]
  }
}
