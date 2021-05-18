# A wapp extension to allow a directory if static files to be served.
#

set wapp-static-mimetypes {
    .css    text/css
    .html   text/html
    .jpeg   image/jpeg
    .jpg    image/jpeg
    .js     application/javascript
    .png    image/jpeg
    .svg    image/svg+xml
    .txt    text/plain
}

proc wapp-static { root { page {} } { browse nobrowse } } {
    if { $page eq {} } {
        set page [file tail $root]
    }

    # Create a proc to serve static content from root at page.  Browse allows
    # directory navigation.
    #
    proc wapp-page-$page-directory { fileroot filetail } {
        wapp-subst "<ul>"
        foreach file [glob -nocomplain -directory $fileroot -tails -- *] {
            wapp-subst "<li><a href='/images/$filetail/$file'>%html($file)</a></li>"
        }
        wapp-subst "</ul>"
    }

    proc wapp-page-$page {} [subst -nocommands  {
        set rootpath [file normalize $root]
        set filepath [file normalize $root/[wapp-param PATH_TAIL]]

        if { [string first \$rootpath \$filepath] != 0 } {
            return
        }
        set filetail [string range \$filepath [string length \$rootpath] end]

        if { [file isfile \$filepath] }  {
            global wapp
            wapp-mimetype [dict get \${::wapp-static-mimetypes} [string tolower [file extension \$filepath]]]
            dict set wapp .filepath \$filepath
        } else {
            if { "$browse" eq "browse" } {
                wapp-page-$page-directory \$filepath \$filetail
            }
        }
    }]
}
