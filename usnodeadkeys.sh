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

#patch -p1 -d '/etc/default' << 'EOF'
#--- a/keyboard
#+++ b/keyboard
#@@ -4,7 +4,7 @@
# 
# XKBMODEL="pc105"
# XKBLAYOUT="us"
#-XKBVARIANT=""
#+XKBVARIANT="intl_nodeadkeys"
# XKBOPTIONS=""
# 
# BACKSPACE="guess"
#EOF

# TODO: Update evdev.xml and evdev.lst in /usr/share/X11/xkb/rules/
# TODO: Is below needed? probably not
echo Now run, \`sudo dpkg-reconfigure keyboard-configuration\`
echo or \`sudo dpkg-reconfigure xkb-data\`

# --- evdev.lst.orig	2019-11-04 14:19:24.112470691 +0100
# +++ evdev.lst	2019-11-04 14:20:24.040410777 +0100
# @@ -295,6 +295,7 @@
#    chr             us: Cherokee
#    euro            us: English (US, euro on 5)
#    intl            us: English (US, intl., with dead keys)
# +  intl_nodeadkeys us: English (US, intl., with no dead keys)
#    alt-intl        us: English (US, alt. intl.)
#    colemak         us: English (Colemak)
#    dvorak          us: English (Dvorak)
# --- evdev.xml.orig	2019-11-04 14:19:29.608464564 +0100
# +++ evdev.xml	2019-11-04 14:22:50.120291490 +0100
# @@ -1375,6 +1375,12 @@
#          </variant>
#          <variant>
#            <configItem>
# +            <name>intl_nodeadkeys</name>
# +            <description>English (US, intl., with no dead keys)</description>
# +          </configItem>
# +        </variant>
# +        <variant>
# +          <configItem>
#              <name>alt-intl</name>
#              <description>English (US, alt. intl.)</description>
#            </configItem>
# @@ -7388,4 +7394,4 @@
#        </option>
#      </group>
#    </optionList>
# -</xkbConfigRegistry>
# \ No newline at end of file
# +</xkbConfigRegistry>
