
if [ -z "$LD_LIBRARY_PATH" ] ; then
	export LD_LIBRARY_PATH=/usr/local/lib
else 
	export LD_LIBRARY_PATH+=:/usr/local/lib
fi

export EDITOR=vim


#export LC_ALL="en_US.utf8"
export LC_TIME="sv_SE.utf8"
export LC_NUMERIC="sv_SE.utf8"
export LC_MONETARY="sv_SE.utf8"
export LC_MEASUREMENT="sv_SE.utf8"
export LC_PAPER="sv_SE.utf8"
export LC_COLLATE="sv_SE.utf8"

export LESS=RS

PATH=$PATH:/usr/NX/bin
PATH=/usr/local/epics/base/bin/linux-x86_64:$PATH

export EPICS_HOST_ARCH="linux-x86_64"
