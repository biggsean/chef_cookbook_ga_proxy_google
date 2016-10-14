default['haproxy']['frontends']['main']['socket'] = '*:80'
default['haproxy']['frontends']['main']['default_backend'] = 'google'

default['haproxy']['backends']['google']['servers'] = [
  {
    name: 'google1',
    socket: 'www.google.com:80',
    options: ['check']
  }
]
default['haproxy']['backends']['google']['options'] = [
  'option  httpchk  HEAD / HTTP/1.1\r\nHost:\ www.google.com',
  'http-request set-header Host www.google.com',
  'http-request set-header User-Agent GoogleProxy'
]
