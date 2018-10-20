#!/usr/bin/env bash

patch -p1 -d '/usr/share/X11/xkb/symbols' << 'EOF'
--- a/us	2018-10-20 18:21:16.507009269 +0200
+++ b/us	2018-10-20 18:21:26.391023210 +0200
@@ -144,6 +144,19 @@
     include "level3(ralt_switch)"
 };
 
+partial alphanumeric_keys
+xkb_symbols "intl_nodeadkeys" {
+
+    name[Group1]= "U.S. English - International (without plain dead keys)";
+
+    include "us(intl)"
+
+    // Alphanumeric section (overriding some annoying dead keys)
+    key <TLDE> { [     grave,       asciitilde ] };
+    key <AE06> { [    6, asciicircum,    onequarter,      asciicircum ] };
+    key <AC11> { [ apostrophe,        quotedbl ] };
+};
+
 // Based on symbols/us_intl keyboard map:
 // Dead-keys definition for a very simple US/ASCII layout.
 // by Conectiva (http://www.conectiva.com.br)
EOF

patch -p1 -d '/etc/default' << 'EOF'
--- a/keyboard
+++ b/keyboard
@@ -4,7 +4,7 @@
 
 XKBMODEL="pc105"
 XKBLAYOUT="us"
-XKBVARIANT=""
+XKBVARIANT="intl_nodeadkeys"
 XKBOPTIONS=""
 
 BACKSPACE="guess"
EOF
