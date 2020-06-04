This is a fork of original wapp from D. Richard Hipp with some changes:

- support of PUT, PATCH, DELETE http methods;
- fix cookies parsing(make parsing more rfc6265 compliant,
  but be more liberal to cookie value,
  allowing any chars except dquote in a quoted value and
  any char except semicolon in a nonquoted value).

For documentation look https://wapp.tcl.tk/home/doc/trunk/README.md .
