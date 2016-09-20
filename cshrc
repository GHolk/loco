# @(#)cshrc 1.11 89/11/29 SMI
umask 022
set path=(/bin /usr/bin /usr/ucb /usr/local/bin /usr/sbin /sbin /etc .)
if ( $?prompt ) then
	set history=32
endif
setenv LD_LIBRARY_PATH /usr/dt/lib:/usr/lib:/usr/openwin/lib:/usr/local/lib
source /etc/skel/settings.csh
exec zsh
