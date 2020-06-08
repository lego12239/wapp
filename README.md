This is a fork of original wapp from D. Richard Hipp with some changes:

- support of PUT, PATCH, DELETE http methods;
- fix cookies parsing(make parsing more rfc6265 compliant,
  but be more liberal to cookie value,
  allowing any chars except dquote in a quoted value and
  any char except semicolon in a nonquoted value);
- throw error on bad cookie value set;
- -server option accepts a listen address in plan9 format:
  tcp!ADDR!PORT or tcp!ADDR!0 or tcp!ADDR or ADDR.
  If PORT isn't specified or 0, then the first not used port is selected.
  If ADDR is 0.0.0.0, then listen on wildcard address;
- fix request target parsing(make parsing more rfc3986 compliant);

For documentation look https://wapp.tcl.tk/home/doc/trunk/README.md .
