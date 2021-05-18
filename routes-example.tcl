#!/usr/bin/env tclkit8.6
#
source wapp.tcl
source wapp-routes.tcl

wapp-route GET /image/date/file {
    puts  "GET $date $file"
}

wapp-route PUT /image/date/file {
    puts  "PUT $date $file"
}

wapp-route DELETE /image/date/file {
    puts  "DEL $date $file" 
}


proc wapp-default {} {
    wapp-subst { HI }
}

wapp-start $argv

