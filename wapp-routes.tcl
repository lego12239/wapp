# Simple notation for wapp-page-$page handler generation.
#
# wapp-route [GET|PUT|DELETE|...] /page[/value1[/value2]] [param1 .. paramN] handlerBody
#
# Route values are unpacked into local variables.  Any remainder of the path is
# left as a list in the local variable PATH_TAIL.  The original path tail is
# still available using [wapp-param PATH_TAIL].  Additional parameters are
# unpacked with [wapp-param] into local variables.
#
proc wapp-route-dispatch { page } {
    set REQUEST_METHOD [wapp-param REQUEST_METHOD]
    if { [info command wapp-page-$page-$REQUEST_METHOD] ne "" } {
        wapp-page-$page-$REQUEST_METHOD
    } else {
        wapp-reply-code "404 Page Not Found"
    }
}

proc wapp-route { method pathspec args } {
    set names [lassign [split $pathspec /] -> page]
    set args [lreverse [lassign [lreverse $args] body]]

    set prefix ""
    if { [llength $names] } {
        append prefix "    set PATH_TAIL \[lassign \[split \[wapp-param PATH_TAIL] /] $names]\n"
    }
    foreach arg $args {
        append prefix "    set $arg \[wapp-param $arg]\n"
    }

    proc wapp-page-$page-$method {} "\n$prefix $body"
    proc wapp-page-$page {} "wapp-route-dispatch $page"
}
