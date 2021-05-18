#!/usr/bin/env tclkit8.6
#
set root [file dirname [file normalize [info script]]]

source ../wapp.tcl
source wapp-static.tcl

wapp-static ../../tickpic/images images browse

proc wapp-default {} {
  set mname [wapp-param PATH_HEAD]
  if { $mname eq "" } {
      wapp-redirect /images
  }
}

wapp-start $argv
