
package require Thread

proc wapp-deliver-file-content { wapp chan } {
    set mimetype [dict get $wapp .mimetype]
    set filepath [dict get $wapp .filepath]

    thread::detach $chan

    thread::create [subst -nocommands {
        thread::attach $chan
        
        set contentLength [file size $filepath]
        set inchan [open $filepath rb]
        puts $chan "Content-Type: $mimetype\r"
        puts $chan "Content-Length: \$contentLength\r"
        puts $chan "\r"
        fcopy \$inchan $chan
        close \$inchan
        flush $chan
        close $chan
    }]
}

